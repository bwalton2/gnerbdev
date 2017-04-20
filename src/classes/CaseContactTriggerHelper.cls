public class CaseContactTriggerHelper {
    public static void getContactsInformation (List<Case_Contact__c> newCaseContacts) {
        Set<Id> contacts = new Set<Id>();
        Map<Id, Contact> contactMap;
        for (Case_Contact__c cc : newCaseContacts) {
            if (cc.contact__c != Null) {
                contacts.add(cc.contact__c);
            }
        }

        contactMap = new Map<Id,Contact>([SELECT FirstName, LastName, Email, Phone 
        	FROM Contact WHERE Id in : contacts]);
        For (Case_Contact__c cc : newCaseContacts) {
            if (cc.contact__c != Null) {
                if (contactMap.get(cc.Contact__c) != Null) {
                    Contact temp = contactMap.get(cc.Contact__c);
                    cc.First_Name__c = temp.FirstName;
                    cc.Last_Name__c = temp.LastName;
                    cc.Email__c = temp.Email;
                    cc.Phone__c = temp.Phone;
                }
            }   
        }
    }
}