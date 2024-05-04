/**
 * @description       : Batch to create Tasks for Accounts with no tasks and no Orders
 * @author            : HAVARD Julien
 * @group             : 
 * @last modified on  : 05-01-2024
 * @last modified by  : HAVARD Julien
**/
global class CreateAccountsRecallTaskBatch implements Database.Batchable<sObject>, Database.Stateful, Schedulable {
    Integer numberOfTasksCreated = 0;
    /**
     * @description Start for batch class, we return a list of Accounts with no Orders
     * @param info 
     * @return `Database.QueryLocator` List of Accounts with no Orders
     */
    global Database.QueryLocator start(Database.BatchableContext info) {
      return Database.getQueryLocator(
        'SELECT Id, Name FROM Account WHERE ID NOT IN (SELECT AccountId FROM Order)'
      );
    }

    /**
     * @description We filter the scope with account with no tasks
     * @description If an account has no Task we create one with a reminder in five days
     * @param info  
     * @param scope List of Accounts without Orders returned from the start method
     */
    global void execute(
      Database.BatchableContext info,
      List<Account> scope
    ) {
      Set<Id> accountIdScopeSet = new map<Id, Account>(scope).keySet();
      Set<Id> accountIdWihTaskSet = new Map<Id, AggregateResult>([
            SELECT WhatId Id FROM Task
            WHERE AccountId IN :accountIdScopeSet
            GROUP BY WhatId
        ]).keySet();
      accountIdScopeSet.removeAll(accountIdWihTaskSet);

      List<Task> taskToCreateList = new List<Task>();
      for (Id accountId : accountIdScopeSet){
        Task newTask = new Task();
        newTask.Status = 'Not Started';
        newTask.Priority = 'Normal';
        newTask.Subject = 'Call';
        newTask.IsReminderSet = true;
        newTask.ReminderDateTime = Datetime.now().addDays(5);
        newTask.WhatId = accountId;
        numberOfTasksCreated++;
        taskToCreateList.add(newTask);
      }
      insert taskToCreateList;
    }
  
    /**
     * @description Finish method for the batch, we inform how many tasks were created
     * @param info 
     */
    global void finish(Database.BatchableContext info) {
        System.debug('We have created ' + numberOfTasksCreated );
    }
  
    /**
     * @description Schedulable execute, we start the batch when the schedulable is called
     * @param ctx 
     */
    global void execute(System.SchedulableContext ctx) {
        CreateAccountsRecallTaskBatch batch = new CreateAccountsRecallTaskBatch();
        Database.executeBatch(batch, 200);
    }
  }

