public class JIRAIssueLinks extends JIRAField {
    public String autoCompleteUrl {public get; private set;}
    
    public JIRAIssueLinks(Object o) {
        super(o); // Call inherited constructor
        
        Map<String, Object> untypedJIRAIssueLinks = (Map<String, Object>) o;
        autoCompleteUrl = (String) untypedJIRAIssueLinks.get('autoCompleteUrl');
    }
}