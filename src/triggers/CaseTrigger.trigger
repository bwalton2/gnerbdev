trigger CaseTrigger on Case (before insert, before update, after insert, after update) {
    if (Trigger.isBefore) {
        if (Trigger.IsUpdate || Trigger.isInsert) { //Both
            if (Trigger.New.Size() == 1) { //Help ensure that it the rules are only being run when edited through the UI
                CaseTriggerHelper.validatePicklistValues(Trigger.New[0]);
            }
            CaseTriggerHelper.updateStatuses(Trigger.New);
            CaseTriggerHelper.LookupQueueEmail(Trigger.New);
        }
        
        if (Trigger.isUpdate) { //Just update
            if (Trigger.new.Size() == 1) {
                CaseTriggerHelper.setAudit(Trigger.New, Trigger.oldMap);
            }
        }
        if (Trigger.isInsert) { //Just Insert
            for (Case c : Trigger.New) {
                if (c.Stage__c == null) {
                    c.Stage__c = 'New';
                }
            }
        }
    } else if (Trigger.isAfter) {
        if (Trigger.IsUpdate) {
            if (Trigger.new.size() == 1) {
                if ((trigger.new[0].Last_Comment__c != Trigger.oldMap.get(trigger.new[0].Id).Last_Comment__c || 
            		trigger.new[0].Last_Comment_Public__c != Trigger.oldMap.get(trigger.new[0].Id).Last_Comment_Public__c) &&
                    trigger.new[0].Last_Comment_Public__c) {
					casetriggerhelper.sendCaseCommentEmail(trigger.new[0]);                    
                }
                if (Trigger.new[0].Stage__c == 'Assigned' && 
                    Trigger.oldMap.get(Trigger.New[0].Id).Stage__c == 'New') {
                	CaseTriggerHelper.createInitalFollowUp (Trigger.new[0]);
            	}
                
                if (Trigger.new[0].Next_Follow_Up__c != 
                    Trigger.oldMap.get(Trigger.New[0].Id).Next_Follow_Up__c &&
                    Trigger.new[0].Next_Follow_Up__c != null) {
                	CaseTriggerHelper.createNextFollowUp (Trigger.new[0]);
            	}
            }
        }
    }
}