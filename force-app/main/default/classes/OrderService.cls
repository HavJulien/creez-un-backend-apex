/**
 * @description       : Service class for Orders
 * @author            : HAVARD Julien
 * @group             : 
 * @last modified on  : 05-03-2024
 * @last modified by  : HAVARD Julien
**/
public with sharing class OrderService {
    /**
     * @description Unchecks the field Active__c from Account if there are no orders linked to it
     * @param orderList List of deleted orders
     */
    public void uncheckActiveAccountIfNoOrder(List<Order> orderList){
        Set<Id> accountIdSet = ListUtils.getSetIdFromFieldId(orderList, 'AccountId');
        List<Account> accountList = [SELECT Id, Active__c,(SELECT Id FROM Orders) FROM Account WHERE Id IN :accountIdSet];
        for (Account acc : accountList){
            if(acc.Orders.isEmpty()){
                acc.Active__c = false;
            }
        }
        update accountList;
    }

    /**
     * @description Adds an error before updating an order to active if there are no products linked
     * @param newOrderMap Map of updated orders
     * @param oldOrderMap Map of before update orders
     */
    public void addErrorIfActiveAndNoProducts(Map<Id, Order> newOrderMap, Map<Id, Order> oldOrderMap){
        List<Order> activatedOrderList = new List<Order>();
        for (Order order :newOrderMap.values()){
            //We check if we updated the status to Activated
            if (order.Status == 'Activated' && order.Status != oldOrderMap.get(order.Id).Status){
                activatedOrderList.add(order);
            }       
        }

        List<Order> ordersAndOrderItems = [SELECT Id, (SELECT Id FROM OrderItems) FROM Order WHERE ID IN :activatedOrderList];
        for (Order order :ordersAndOrderItems){
            if (order.OrderItems.isEmpty()){
                newOrderMap.get(order.id).addError(System.Label.ErrorNoOrderProduct);
            }
        }
    }
}