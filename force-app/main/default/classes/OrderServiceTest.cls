/**
 * @description       : Test class for OrderService class
 * @author            : HAVARD Julien
 * @group             : 
 * @last modified on  : 05-03-2024
 * @last modified by  : HAVARD Julien
**/
@IsTest
public with sharing class OrderServiceTest {
    @IsTest
    static void testUncheckActiveAccountIfNoOrder(){
        List<Account> accList = TestDataFactory.generateAccounts(200, true);
        List<Order> orderListDeleted = new List<Order>();
        for (Account acc : accList){
            Order orderLoop = new Order();
            acc.Active__c = true;
            //We don't insert orders to simulate deletion
            orderLoop = TestDataFactory.generateOrder('Test order ' + acc.Name, acc, false);
            orderListDeleted.add(orderLoop);
        }
        //We update all accounts to active
        update accList;

        Test.startTest();
        OrderService service = new OrderService();
        service.uncheckActiveAccountIfNoOrder(orderListDeleted);
        Test.stopTest();
        
        accList = [SELECT Id, Active__c FROM Account];
        for (Account acc: accList){
            Assert.isFalse(acc.Active__c, 'The account should have been deactivated as there is no order attached');
        }
    }  
    
    @IsTest
    static void testAddErrorIfActiveAndNoProducts(){
        Account acc = TestDataFactory.generateAccount(true);
        List<Order> orderList = TestDataFactory.generateOrders(5, acc, true);
        Map<Id, Order> oldOrderMap = new Map<Id, Order>(orderList);
        Map<Id, Order> newOrderMap = new Map<Id, Order>(orderList.deepClone(true,true,true));
        for (Order order:newOrderMap.values()){
            order.Status = 'Activated';
        }

        Test.startTest();
            OrderService service = new OrderService();
            service.addErrorIfActiveAndNoProducts(newOrderMap, oldOrderMap);
        Test.stopTest();
        for (Order order:newOrderMap.values()){
            Assert.isTrue(order.hasErrors(), 'We should have added an error to this order because we tried to activate it without products');
        }
    }
}