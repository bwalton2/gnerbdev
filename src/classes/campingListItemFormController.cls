public class campingListItemFormController {
    @auraEnabled
    public static Camping_Item__c createItem(String Name, Decimal Price, Decimal Quantity, Boolean Packed) {
        Camping_item__c result;
        
        try {
            
            result = new Camping_Item__c();
            
            result.Name = Name;
            result.Price__c = Price;
            result.Quantity__c = Quantity;
            result.Packed__c = Packed;
            
            insert result;
        } catch (Exception e) {
            system.debug(e.getCause());
            system.debug(e.getMessage());
            system.debug(e.getStackTraceString());
        }
        
        return result;
    }
}