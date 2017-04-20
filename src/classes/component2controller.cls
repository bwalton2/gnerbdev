public class component2controller {
    public boolean failState {get;set;}
    public string failMessage {get;set;}
    
    public List<Contact> contacts {get;set;}
    
    public component2controller () {
        failState = false;
        failMessage = '';
        
        try {
            contacts = [SELECT Id FROM Contact];
        } catch (Exception ex) {
            failState = true;
            failMessage = 'Component2 failed to load ' + ex.getMessage() + 
                ex.getStackTraceString();
        }
    }
}