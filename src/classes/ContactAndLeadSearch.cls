public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(string s) {
        List<List<SObject>> result = [FIND :s RETURNING CONTACT(FirstName, LastName), LEAD(FirstName, LastName)];
                
        return result;
    }
}