export default [
    {
        "title": "Home",
        "fileName": "index.html",
        "text": "Home Project Home Use the apexdox.homePagePath  setting to point to an HTML file that contains details about your project. The body of the HTML will show up here instead of this default!"
    },
    {
        "title": "CreateAccountsRecallTaskBatch",
        "fileName": "CreateAccountsRecallTaskBatch.html",
        "text": "CreateAccountsRecallTaskBatch : Batch to create Tasks for Accounts with no tasks and no Orders Signature global class CreateAccountsRecallTaskBatch implements Database.Batchable<sObject>, Database.Stateful, Schedulable Author : HAVARD Julien CreateAccountsRecallTaskBatch Methods execute(info, scope) We filter the scope with account with no tasks If an account has no Task we create one with a reminder in five days execute(ctx) Schedulable execute, we start the batch when the schedulable is called finish(info) Finish method for the batch, we inform how many tasks were created start(info) Start for batch class, we return a list of Accounts with no Orders execute(info, scope) We filter the scope with account with no tasks If an account has no Task we create one with a reminder in five days Signature global void execute(      Database.BatchableContext info,      List<Account> scope    ) Parameters info Type:       Database.BatchableContext scope Type:      List<Account> List of Accounts without Orders returned from the start method execute(ctx) Schedulable execute, we start the batch when the schedulable is called Signature global void execute(System.SchedulableContext ctx) Parameters ctx Type: System.SchedulableContext finish(info) Finish method for the batch, we inform how many tasks were created Signature global void finish(Database.BatchableContext info) Parameters info Type: Database.BatchableContext start(info) Start for batch class, we return a list of Accounts with no Orders Signature global Database.QueryLocator start(Database.BatchableContext info) Parameters info Type: Database.BatchableContext Returns Database.QueryLocator  List of Accounts with no Orders"
    },
    {
        "title": "CreateAccountsRecallTaskBatchTest",
        "fileName": "CreateAccountsRecallTaskBatchTest.html",
        "text": "CreateAccountsRecallTaskBatchTest : Test class for CreateAccountsRecallTaskBatch Signature @isTest public with sharing class CreateAccountsRecallTaskBatchTest Author : HAVARD Julien CreateAccountsRecallTaskBatchTest Methods testCreateAccountsRecallTaskBatch() testCreateAccountsRecallTaskBatch() Signature @IsTest static void testCreateAccountsRecallTaskBatch()"
    },
    {
        "title": "ListUtils",
        "fileName": "ListUtils.html",
        "text": "ListUtils : Utils class for lists Signature public with sharing class ListUtils Author : HAVARD Julien ListUtils Methods getSetIdFromFieldId(sobjectList, fieldName) Extracts a set of Id of a Lookup field from a list of SObject getSetIdFromFieldId(sobjectList, fieldName) Extracts a set of Id of a Lookup field from a list of SObject Signature public static Set<Id> getSetIdFromFieldId(List<SObject> sobjectList, String fieldName) Parameters sobjectList Type: List<SObject> List of SObject fieldName Type: String Name of the field to extract id from Returns Set<Id>  of the lookup field"
    },
    {
        "title": "ListUtilsTest",
        "fileName": "ListUtilsTest.html",
        "text": "ListUtilsTest : Test class for ListUtils class Signature @isTest public with sharing class ListUtilsTest Author : HAVARD Julien ListUtilsTest Methods testGetSetIdFromFieldId() testGetSetIdFromFieldId() Signature @IsTest static void testGetSetIdFromFieldId()"
    },
    {
        "title": "OrderService",
        "fileName": "OrderService.html",
        "text": "OrderService : Service class for Orders Signature public with sharing class OrderService Author : HAVARD Julien OrderService Methods addErrorIfActiveAndNoProducts(newOrderMap, oldOrderMap) Adds an error before updating an order to active if there are no products linked uncheckActiveAccountIfNoOrder(orderList) Unchecks the field Active__c from Account if there are no orders linked to it addErrorIfActiveAndNoProducts(newOrderMap, oldOrderMap) Adds an error before updating an order to active if there are no products linked Signature public void addErrorIfActiveAndNoProducts(Map<Id, Order> newOrderMap, Map<Id, Order> oldOrderMap) Parameters newOrderMap Type: Map<Id, Order> Map of updated orders oldOrderMap Type: Map<Id, Order> Map of before update orders uncheckActiveAccountIfNoOrder(orderList) Unchecks the field Active__c from Account if there are no orders linked to it Signature public void uncheckActiveAccountIfNoOrder(List<Order> orderList) Parameters orderList Type: List<Order> List of deleted orders"
    },
    {
        "title": "OrderServiceTest",
        "fileName": "OrderServiceTest.html",
        "text": "OrderServiceTest : Test class for OrderService class Signature @IsTest public with sharing class OrderServiceTest Author : HAVARD Julien OrderServiceTest Methods testAddErrorIfActiveAndNoProducts() testUncheckActiveAccountIfNoOrder() testAddErrorIfActiveAndNoProducts() Signature @IsTest static void testAddErrorIfActiveAndNoProducts() testUncheckActiveAccountIfNoOrder() Signature @IsTest static void testUncheckActiveAccountIfNoOrder()"
    },
    {
        "title": "TestDataFactory",
        "fileName": "TestDataFactory.html",
        "text": "TestDataFactory : TestDataFactory class to generate data for test classes Signature @IsTest public with sharing class TestDataFactory Author : HAVARD Julien TestDataFactory Methods generateAccount(isInserted) generateAccount(name, isInserted) generateAccounts(size, isInserted) generateOrder(isInserted) generateOrder(name, isInserted) generateOrder(name, acc, isInserted) generateOrders(orderListSize, isInserted) generateOrders(orderListSize, acc, isInserted) generateTask(acc, isInserted) generateAccount(isInserted) Signature public static Account generateAccount(Boolean isInserted) generateAccount(name, isInserted) Signature public static Account generateAccount(String name, Boolean isInserted) generateAccounts(size, isInserted) Signature public static List<Account> generateAccounts(Integer size, Boolean isInserted) generateOrder(isInserted) Signature public static Order generateOrder(Boolean isInserted) generateOrder(name, isInserted) Signature public static Order generateOrder(String name, Boolean isInserted) generateOrder(name, acc, isInserted) Signature public static Order generateOrder(String name, Account acc, Boolean isInserted) generateOrders(orderListSize, isInserted) Signature public static List<Order> generateOrders(Integer orderListSize, Boolean isInserted) generateOrders(orderListSize, acc, isInserted) Signature public static List<Order> generateOrders(Integer orderListSize, Account acc, Boolean isInserted) generateTask(acc, isInserted) Signature public static Task generateTask(Account acc, Boolean isInserted)"
    },
    {
        "title": "OrderTriggerTest",
        "fileName": "OrderTriggerTest.html",
        "text": "OrderTriggerTest : Test class for OrderTrigger Signature @isTest public with sharing class OrderTriggerTest Author : HAVARD Julien OrderTriggerTest Methods testAfterDelete() testBeforeUpdate() testAfterDelete() Signature @IsTest static void testAfterDelete() testBeforeUpdate() Signature @IsTest static void testBeforeUpdate()"
    }
];
