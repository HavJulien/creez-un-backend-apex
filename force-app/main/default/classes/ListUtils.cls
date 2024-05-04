/**
 * @description       : Utils class for lists
 * @author            : HAVARD Julien
 * @group             : 
 * @last modified on  : 05-01-2024
 * @last modified by  : HAVARD Julien
**/
public with sharing class ListUtils {
    /**
     * @description Extracts a set of Id of a Lookup field from a list of SObject
     * @param sobjectList List of SObject
     * @param fieldName Name of the field to extract id from
     * @return `Set<Id>` of the lookup field
     */
    public static Set<Id> getSetIdFromFieldId (List<SObject> sobjectList, String fieldName){
        Set<Id> newSetId = new Set<Id>();

        if (!sobjectList.isEmpty() && (sobjectList[0].get(fieldName) instanceOf Id)){
            for (SObject sObjLoop : sobjectList){
                newSetId.add((Id) sObjLoop.get(fieldName));
            }
        }
        return newSetId;
    }
}