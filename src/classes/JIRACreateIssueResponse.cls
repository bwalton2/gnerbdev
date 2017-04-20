public class JIRACreateIssueResponse {
    public String id {public get; private set;}
    public String key {public get; private set;}
    public String self {public get; private set;}
    
    public JIRACreateIssueResponse (Object o) {
        Map<String, Object> untypedCreateIssueResponse = (Map<String, Object>) o;
        id = (String) untypedCreateIssueResponse.get('id');
        key = (String) untypedCreateIssueResponse.get('key');
        self = (String) untypedCreateIssueResponse.get('self');
    }
}