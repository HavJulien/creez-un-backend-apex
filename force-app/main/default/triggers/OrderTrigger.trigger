/**
 * @description       : Trigger on Order for all events
 * @author            : HAVARD Julien
 * @group             : 
 * @last modified on  : 05-03-2024
 * @last modified by  : HAVARD Julien
**/
trigger OrderTrigger on Order (before insert, after insert, before update, after update, before delete, after delete) {
    if (Trigger.isBefore && Trigger.isUpdate){
        OrderService service = new OrderService();
        service.addErrorIfActiveAndNoProducts(Trigger.newMap, Trigger.oldMap);
    }

    if (Trigger.isAfter && Trigger.isDelete){
        OrderService service = new OrderService();
        service.uncheckActiveAccountIfNoOrder(Trigger.old);
    }
}