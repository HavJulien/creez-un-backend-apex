/**
 * @description       : Test class for ListUtils class
 * @author            : HAVARD Julien
 * @group             : 
 * @last modified on  : 05-03-2024
 * @last modified by  : HAVARD Julien
**/
@isTest
public with sharing class ListUtilsTest {
    @IsTest
    static void testGetSetIdFromFieldId(){
        Account account1 = TestDataFactory.generateAccount('1', true);
        Account account2 = TestDataFactory.generateAccount('2', true);

        List<Order> orderList = TestDataFactory.generateOrders(3, account1, false);
        orderList.addAll(TestDataFactory.generateOrders(2, account2, false));

        Set<Id> accountSetId = new Set<Id>();
        Test.startTest();
            accountSetId.addAll(ListUtils.getSetIdFromFieldId(orderList, 'AccountId'));
        Test.stopTest();
        
        Assert.isFalse(accountSetId.isEmpty(), 'The account set id shouldn\'t be empty');
        Assert.areEqual(2, accountSetId.size(), 'We should have 2 discincts Ids');
        Assert.isTrue(accountSetId.contains(account1.Id), 'The first account Id should be in the set');
        Assert.isTrue(accountSetId.contains(account2.Id), 'The second account Id should be in the set');
    }
}