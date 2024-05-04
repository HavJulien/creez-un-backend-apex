/**
 * @description       : Test class for CreateAccountsRecallTaskBatch
 * @author            : HAVARD Julien
 * @group             : 
 * @last modified on  : 05-03-2024
 * @last modified by  : HAVARD Julien
**/
@isTest
public with sharing class CreateAccountsRecallTaskBatchTest {
    @IsTest
    static void testCreateAccountsRecallTaskBatch(){
        Account accWithOrder = TestDataFactory.generateAccount('Order', true);
        TestDataFactory.generateOrder('ORDER PRE BATCH', accWithOrder, true);
        Account accWithTask = TestDataFactory.generateAccount('Task', true);
        Task task = TestDataFactory.generateTask(accWithTask, false);
        task.Subject = 'TASK BEFORE BATCH';
        insert task;
        List<Account> accWithoutTaskAndOppList = TestDataFactory.generateAccounts(150, true);

        Test.startTest();
        CreateAccountsRecallTaskBatch batch = new CreateAccountsRecallTaskBatch();
        String cron = '0 0 2 ? * 2#1';
        String uniqueCronName = 'Test Schedule CRON ' + accWithOrder.Id;
        String jobId = System.schedule(uniqueCronName, cron, batch);
        Database.executeBatch(batch);
        Test.stopTest();

        Assert.isNotNull(jobId, 'We should have created a job');
        List<CronJobDetail> cronJobList = [SELECT Id, Name FROM CronJobDetail WHERE Name = :uniqueCronName];
        Assert.isFalse(cronJobList.isEmpty(), 'We should have created a cronJobDetail');

        List<Task> taskList = [SELECT Id FROM Task WHERE WhatId = :accWithOrder.Id];
        Assert.areEqual(0, taskList.size(), 'We should not have created a task for an account with an order');

        taskList = [SELECT Id FROM Task WHERE WhatId = :accWithTask.Id];
        Assert.areEqual(1, taskList.size(), 'We should not have created a task for an account that already has a task');

        Set<Id> accountIdWihTaskSet = new Map<Id, AggregateResult>([
            SELECT WhatId Id FROM Task
            WHERE AccountId != :accWithTask.Id
            GROUP BY WhatId
        ]).keySet();
        for (Account acc : accWithoutTaskAndOppList){
            Assert.isTrue(accountIdWihTaskSet.contains(acc.Id), 'We should have created a Task for every other account');
        }
    }
}