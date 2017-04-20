public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(integer i, string s) {
        List<Contact> result = new List<Contact>();
        
        for (integer x = 0; x < i; x++) {
        	result.add(new Contact(
            	FirstName = 'test' + x,
                lastName = x + 'test'
            ));    
        }
        
        return result;
    }
}