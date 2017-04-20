trigger CaseContactTrigger on Case_Contact__c (before insert, before update, 
    after insert, after update) {
    If (Trigger.IsBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            CaseContactTriggerHelper.getContactsInformation(Trigger.New);
        }
        if (Trigger.isInsert) {
            
        }
        if (Trigger.isUpdate) {
            
        } 
    }
}