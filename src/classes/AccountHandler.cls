public class AccountHandler {
    public static account insertNewAccount(string s) {
        try {
            Account result = new Account(
                name = s
            );
            
            insert result;
            
            return result;
        } catch (DMLException ex) {
            return null;
        }
    }
}