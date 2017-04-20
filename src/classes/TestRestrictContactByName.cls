@isTest
public class TestRestrictContactByName {
    @isTest
    public static void test_good() {
        try {
            contact c = new Contact(
                firstName = 'test',
                lastName = 'smith'
            );
            
            insert c;
            system.assert(true);
        } catch (DMLException ex) {
            system.assert(false);   
        }
    }
    
    @isTest
    public static void test_bad() {
        try {
            contact c = new Contact(
                firstName = 'test',
                lastName = 'INVALIDNAME'
            );
            
            insert c;
            system.assert(true);
        } catch (DMLException ex) {
            system.assert(false);   
        }
    }
}