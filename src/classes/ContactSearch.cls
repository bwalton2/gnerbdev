public class ContactSearch {
    public static List<Contact> searchForContacts(string s, string t) {
        List<Contact> contacts = new List<Contact>();
        
        for  (Contact c : [SELECT Id, Name
                          FROM Contact
                          WHERE lastName = :s AND MailingPostalCode = :t]) {
            contacts.add(c);
        }
        
        return contacts;
    }
}