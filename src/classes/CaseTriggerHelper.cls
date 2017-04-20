public class CaseTriggerHelper {
    public static void setAudit(List<Case> newSourceList, Map<Id,Case> oldSourceMap) {
        for (Case c : newSourceList) {
            if (oldSourceMap.get(c.Id).Stage__c != 'Complete' && c.Stage__c == 'Complete' && !c.Audited__c) {
                Decimal temp = math.random();
                if (temp.setScale(2) < c.Audit_Chance__c/100) {
                    c.Stage__c = 'Waiting for audit';
                }
            }
        }
    }
    
    public static void validatePicklistValues (List<SObject> sourceList) {
        Map<string,List<String>> fieldValues = getPicklistsValueMap(sourceList.getSObjectType());
        
        for (SObject sobj : sourceList) {
            validatePickListValue(sobj, fieldValues);
        }
    }
    
    public static void validatePicklistValues (SObject source) {
        validatePickListValue(source, getPicklistsValueMap(source.getSObjectType()));
    }
    
    public static void LookupQueueEmail(List<Case> newCases) {
        Set<String> QueueNames = new Set<String>();
        List<QueueSObject> Queues;
        Map<String,String> NameToEmail = new Map<String,String>();
        
        for (Case c : newCases) {
            if (c.Escalation_Queue__c != null) {
                QueueNames.add(c.Escalation_Queue__c);
            } else {
            	c.Escalation_Email__c = '';
            }
        }
        
        Queues = [SELECT Id, Queue.Name, Queue.Email FROM QueueSObject WHERE Queue.Name IN :QueueNames];
    	
        for (QueueSObject q : Queues) {
            NameToEmail.put(q.queue.name, q.queue.email);
        }
        
        for (Case c : newCases) {
            if (c.Escalation_Queue__c != null) {
                if (NameToEmail.get(c.Escalation_Queue__c) != null) {
                    c.Escalation_Email__c = NameToEmail.get(c.Escalation_Queue__c);
                }
            }
        }
    }
    
    public static void createInitalFollowUp (Case newSource) {
        string prefix = (string)(newSource.OwnerId);
        prefix = prefix.left(3);
        
        if (prefix == '005') { //make sure the case is assigned to a user
            DateTime followUpTime = system.now().addMinutes(
                (integer)(newSource.Initial_Follow_Up_Delay__c));
            
            Event initialFollowUp = new Event(
                Subject='Initial Follow Up',
                StartDateTime=followUpTime,
                EndDateTime=followUpTime.addMinutes(30),
                Status__c='Not Started',
                OwnerId=newSource.OwnerId,
                WhatId=newSource.Id,
                IsReminderSet=true,
                ReminderDateTime=followUpTime.addMinutes(-15),
                Description='Auto Generated Follow-up event based on task priority'
            );
            
            insert initialFollowUp;
        }
    }
    
    public static void createNextFollowUp (Case newSource) {
        string prefix = (string)(newSource.OwnerId);
        prefix = prefix.left(3);
        
        if (prefix == '005') {
            DateTime followUpTime = newSource.Next_Follow_Up__c;
            
            Event nextFollowUp = new Event(
                Subject='Next Follow Up',
                StartDateTime=followUpTime,
                EndDateTime=followUpTime.addMinutes(15),
                Status__c='Not Started',
                OwnerId=newSource.OwnerId,
                WhatId=newSource.Id,
                IsReminderSet=true,
                ReminderDateTime=followUpTime.addMinutes(-15),
                Description='Auto Generated Follow-up event based on Next Follow Up field'
            );
                
            insert nextFollowUp;
        }
    }
    
    public static void updateStatuses(List<Case> newCases) {
        for (Case c : newCases) {
            updateStatusField(c);
        }
    }
    
    public static void updateStatusField(Case newCase) {
        //Updates status field based on stage value
        //Currently, since their are only 3 statuses
        //Only need to add entries for "closed"
        if (newCase.Stage__c == 'New') {
            newCase.Status = 'New';
        } else if (newCase.Stage__c == 'Complete' || 
                   newCase.Stage__c == 'Waiting for audit' ||
                   newCase.Stage__c == 'In Audit' ||
                   newCase.Stage__c == 'RCA Investigation') {
            newCase.Status = 'Closed';
        } else { //The most common status
            newCase.Status = 'In Progress';
        }
    }
    
    public static void sendCaseCommentEmail(Case newCase) {
        final integer ilimit = 100;
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
        List<String> addresses = new List<String>();
        messaging.SingleEmailMessage message;
        OrgWideEmailAddress owa;
        EmailTemplate templateId;
        integer ilimiter = 0;
        
        owa = [SELECT Id, DisplayName, Address FROM OrgWideEmailAddress WHERE address = 'cases@gnerb.com' LIMIT 1];
        templateId = [SELECT Id FROM EmailTemplate WHERE Name = 'Support: Signature with thread Id'];
        
        for (Case_Contact__c cc : [SELECT Email__c FROM Case_Contact__c WHERE Case__c = :newCase.Id]) {
            If (ilimiter < ilimit) {
                if (cc.Email__c != Null && cc.Email__c != '') {
                    addresses.add(cc.Email__c);
                	ilimiter = ilimiter + 1;
                }
            } else {
                break;
            }
        }
        
        if (addresses != null && addresses.size() > 0) {
            message = new messaging.SingleEmailMessage();
            message.setTemplateId(templateId.Id);
            message.setOrgWideEmailAddressId(owa.Id);
            message.setSaveAsActivity(false);
            message.setTreatTargetObjectAsRecipient(false); //Enables use of to-addresses
            message.setTargetObjectId(newCase.ContactId);
            message.setWhatId(newCase.Id);
            message.setToAddresses(addresses);
            messages.add(message);
            messaging.sendEmail(messages);
        }
    }
    
    private static void validatePickListValue(SObject source, Map<string,List<String>> valueMap) {
        boolean legal;
        String temp;
        
        for (string s : valueMap.keySet()) {
                legal = false;
                temp = (String)source.get(s);
                for (String v : valueMap.get(s)) {
                    if (temp == v) {
                        legal = true;
                        break;
                    }
                }
                if (temp != '' && temp != null && !legal) {
                    source.addError('Invalid Value ' + source.get(s) + ' for ' + s);             
                }
            }
    }
    
    private static Map<String,List<String>> getPicklistsValueMap(schema.SObjectType sType) {
        Map<String,Schema.SObjectField> sofMap = stype.getDescribe().fields.getMap();
        Map<String,Schema.DescribeFieldResult> dfrMap = new Map<String,Schema.DescribeFieldResult>();
        Map<String,List<String>> fieldValues = new Map<String,List<String>>();
        
        for (String s : sofMap.keyset()) {
            dfrMap.put(s, sofMap.get(s).getDescribe());
        }
        
        for (Schema.DescribeFieldResult dfr : dfrMap.values()) {
            if (dfr.getType().Name() == 'PICKLIST') {
                List<String> values = new List<String>();
                List<Schema.PicklistEntry> ple = dfr.getPicklistValues();
                for (Integer x = 0; x < ple.size(); x++) {
                    values.add(ple[x].getLabel());
                }
                fieldValues.put(dfr.getname(),values);
            }
        }
        return fieldValues;
    }
}