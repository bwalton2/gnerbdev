public class EmailMessageTriggerHelper {
    public static void insertCaseComment(List<EmailMessage> newEmails) {
        List<CaseComment> CaseComments = new List<CaseComment>();
    	string message;
        
        for (EmailMessage e : newEmails) {
            if (e.FromName != Null) {
                message = ' has added an email to the case: \n https://gnerb-dev-ed.my.salesforce.com/';
            } else {
                message = 'A new email has been added to the case: \n https://gnerb-dev-ed.my.salesforce.com/';
            }
            CaseComments.add(new CaseComment(CommentBody=e.FromName + message + e.Id,
                ParentId=e.parentId));
        }
        
        insert CaseComments;
    }
    
    public static void insertCaseContacts(List<EmailMessage> newEmails) {
        String toAddresses; //String of email addresses seperated by semicolon and newline
        List<String> addresses; //Split string of email addresses
        Map<Id,List<String>> caseContactAddresses = new Map<Id,List<String>>(); //Case Id to split list of addresses
        Map<Id,List<Contact>> caseAccountContacts = new Map<Id,List<Contact>>(); //Case Id to list of contacts from cases parent account
        Map<Id,Id> CaseAccounts = new Map<Id,Id>(); //Cases parent account Id to Case Id
        Set<Id> parentIds = new Set<Id>(); //Email parent IDs for bulk query
        Set<Id> accounts = new Set<Id>(); //Case account parent IDs for bulk query
        List<Case> cases = new List<Case>(); //List of cases to minimize DML calls
        List<Contact> contacts = new List<contact>(); //List of accounts contacts
        List<Case_Contact__c> caseContacts = new List<Case_Contact__c>(); //List of Case Contacts
        boolean match = false;

        for (EmailMessage e : newEmails) { //Loop through every email message
            caseContactAddresses.put(e.ParentId, new List<String>()); //Create an entry for the emails parent case to store all of the new contacts to add
            caseAccountContacts.put(e.ParentId, new List<Contact>()); //Create an entry for the emails parent case to store it's parent account's contacts
            parentIds.add(e.ParentId); //Add parent Id for bulk DML
        }
        
        for (EmailMessage e : newEmails) { //Loop through every email message
            toAddresses = e.FromAddress + ';\n' + e.ToAddress; //Gather the from and to addresses from the email
            if (e.CcAddress != Null && e.CcAddress != '') { //check for CCaddress
                toAddresses = toAddresses  + ';\n' + e.CcAddress; //Add the ccaddresses
            }
            
            for (String s : toAddresses.split(';\\n')) { //Split the string into seperate addresses
                if (s.toLowerCase() != 'cases@gnerb.com') { //Make sure we are not added as a contact
                    caseContactAddresses.get(e.ParentId).add(s); //Add the addresses to the container
                }
            }
        } //caseContactAddresses filled
        
        for (Case c : [SELECT AccountId, (SELECT Email__c FROM Case_Contacts__r) FROM Case where Id in :parentIds]) { //Loop through every parent case
            cases.add(c); //Add to cases so that the next loop doesn't need to make a DML call
            addresses = caseContactAddresses.get(c.id); //get the list of the cases contacts to add
            caseAccounts.put(c.AccountId, c.id); //Reverse the relationship
            accounts.add(c.AccountId); //Add account id for bulk DML
			caseContacts = c.getSObjects('Case_Contacts__r');
            
            if (caseContacts != Null) {
                for (Case_Contact__c cc : caseContacts) { //loop through each cases case contacts
                    for (integer x = 0; x < addresses.size(); x++) { //loop through address list for case
                        if (addresses[x].toLowerCase() == cc.Email__c.toLowerCase()) { //check for duplicate addresses
                            addresses.remove(x); //Remove duplicate addresses (hope this doesn't cause problems)
                        }
                    }
                }
            }
            
            caseContactAddresses.put(c.id,addresses); //Update map to remove duplicates
        }
        
        for (Account a : [SELECT Id, (SELECT Id, FirstName, LastName, Email, Phone FROM Contacts)
        	FROM Account WHERE Id in :accounts]) { //Loop through ever account
            contacts = a.getSObjects('Contacts'); //Get all the contacts on the account
            caseAccountContacts.put(caseAccounts.get(a.id),contacts); //Add the list to the container
        } //CaseAccountContacts Filled
        
        for (case c : cases) { //loop through every case
            Case_Contact__c tempcc;
            addresses = caseContactAddresses.get(c.id);
            contacts = caseAccountContacts.get(c.id);
            caseContacts = new List<Case_Contact__c>();
            for (String s : addresses) {
                match = false;
                tempcc = new Case_Contact__c();
                for (Contact con : contacts) {
                    if (s.toLowerCase() == con.Email.toLowerCase()) {
                        match = true;
                        tempcc.Contact__c = con.id;
                        tempcc.Case__c = c.id;
                        break;
                    }
                }
                if (!match) {
                    tempcc.Email__c = s;
                    tempcc.Case__c = c.Id;
                }
                caseContacts.add(tempcc);
            }
            insert caseContacts;
        }
    }
}