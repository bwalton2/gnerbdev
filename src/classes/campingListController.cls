public with sharing class campingListController {
    @auraEnabled
    public static List<Camping_Item__c> getItems() {
        List<Camping_Item__c> result = new List<Camping_Item__c>([SELECT Name, Price__c, Quantity__c, Packed__c FROM Camping_Item__c]);
        system.debug(string.valueOf(result));
        return result;
    }
    
    @auraEnabled
    public static Camping_Item__c saveItem(Camping_Item__c newItem) {
        upsert newItem;
        return newItem;
    }
}