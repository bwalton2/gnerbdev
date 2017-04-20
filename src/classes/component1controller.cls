public class component1controller {
    public boolean failState {get;set;}
    public string failMessage {get;set;}
    
    public List<Contact> contacts {get;set;}
    
    public component1controller () {
        failState = false;
        failMessage = '';
        //contacts = new List<Contact>();
        
        try {
            for (contact c : [SELECT Id FROM Contact]) {
                contacts.add(c);
            }
        } catch (Exception ex) {
            failState = true;
            failMessage = 'Component1 failed to load ' + ex.getMessage() + 
                ex.getStackTraceString();
        }
    }
}