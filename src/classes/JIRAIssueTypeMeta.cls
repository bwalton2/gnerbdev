public class JIRAIssueTypeMeta {
	public string self;
    public string id;
    public string description;
    public string iconURL;
    public string name;
    public boolean subTask;
    public JIRAFieldsMeta fields;
    
    /*
     * Provides a way to convert an untyped object into a JIRAIssueType
     */
    public JIRAIssueTypeMeta (Object o) {
        Map<String, Object> untypedJIRAIssueType = (Map<String, Object>) o;
        Map<String, Object> untypedFields = (Map<String, Object>) untypedJIRAIssueType.get('fields');
        
        self = (String) untypedJIRAIssueType.get('self');
        id = (String) untypedJIRAIssueType.get('id');
        description = (String) untypedJIRAIssueType.get('description');
        iconURL = (String) untypedJIRAIssueType.get('iconURL');
        name = (String) untypedJIRAIssueType.get('name');
        subTask = (Boolean) untypedJIRAIssueType.get('subTask');
        fields = untypedFields != null ? new JIRAFieldsMeta(untypedFields) : null;
    }
}