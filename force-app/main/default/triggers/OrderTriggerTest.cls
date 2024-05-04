/**
 * @description       : Test class for OrderTrigger
 * @author            : HAVARD Julien
 * @group             : 
 * @last modified on  : 05-03-2024
 * @last modified by  : HAVARD Julien
**/
@isTest
public with sharing class OrderTriggerTest {
    @IsTest
    static void testBeforeUpdate(){
        Account acc = TestDataFactory.generateAccount(true);
        Order order = TestDataFactory.generateOrder('Test', acc, true);
        order.name = 'New name';
        Test.startTest();
        update order;
        Test.stopTest();
        Assert.areEqual(order.name, [SELECT Id, Name FROM Order LIMIT 1].Name, 'The name should have been updated');
    }

    @IsTest
    static void testAfterDelete(){
        Account acc = TestDataFactory.generateAccount(true);
        acc.Active__c = true;
        update acc;
        Order order = TestDataFactory.generateOrder('Test', acc, true);
        Test.startTest();
        delete order;
        Test.stopTest();
        List<Order> orderList = [SELECT Id FROM Order];
        Assert.isTrue(orderList.isEmpty(), 'The order should have been deleted');
        acc = [SELECT Id, Active__c FROM Account LIMIT 1];
        Assert.isFalse(acc.Active__c, 'The account should have been deactivated');
    }
}