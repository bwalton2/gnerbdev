trigger EmailMessageTrigger on EmailMessage (before insert, before update, after insert, after update) {
    if (trigger.IsBefore) {
        if (trigger.IsInsert || trigger.IsUpdate) {
            
        }
        if (trigger.IsInsert) {
            
        }
        if (trigger.IsUpdate) {
            
        }
    }
    if (trigger.IsAfter) {
        if (trigger.IsInsert) {
            EmailMessageTriggerHelper.insertCaseComment(trigger.new);
            EmailMessageTriggerHelper.insertCaseContacts(trigger.new);
        }
    }
}