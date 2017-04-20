public class CaseContactControllerHelper {
    private Case Parent;
    public List<Case_Contact__c> CaseContacts;
    public List<Contact> AccountContacts;
    public List<Id> Exclude;
    public Id ToDo {get;set;}
    
    public CaseContactControllerHelper(apexPages.StandardSetController stdCon) {
        Parent = [SELECT Id, AccountId FROM Case 
            WHERE Id=:ApexPages.currentPage().getParameters().get('id')];
        setCaseContacts();
        setAccountContacts();
    }
   
    public pagereference DeleteCaseContact() {
        Delete [SELECT Id FROM Case_Contact__c WHERE Id = :ToDo];
        setCaseContacts();
        setAccountContacts();
        return Null;
    }
    
    public pagereference CreateCaseContact() {
        INSERT new Case_Contact__c(Case__c=Parent.Id,Contact__c=ToDo);
        setCaseContacts();
        setAccountContacts();
        return Null;
    }
    
    private void setAccountContacts() {
        this.AccountContacts = [SELECT FirstName, LastName, Email, Phone FROM Contact
            WHERE AccountId = :Parent.AccountId AND Id NOT IN :exclude];
    }
    
    public List<Contact> getAccountContacts() {
        return this.AccountContacts;
    }
  
    private void setCaseContacts() {
        this.CaseContacts = [SELECT First_Name__c, Last_Name__c, Email__c, Phone__c, contact__c 
            FROM Case_Contact__c WHERE Case__c = :Parent.Id];
        exclude = new List<Id>();
        for (Case_Contact__c cc : CaseContacts) {
            if (cc.contact__c != Null) {
                exclude.add(cc.contact__c);
            }
        }
        system.debug(exclude);
    }
    
    public List<Case_Contact__c> getCaseContacts() {
        return this.CaseContacts;
    }
}