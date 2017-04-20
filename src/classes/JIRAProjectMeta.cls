public class JIRAProjectMeta {
	public string self;
    public string id;
    public string key;
    public string name;
    
    public List<JIRAIssueTypeMeta> issueTypes;
    public JIRAAvatarUrls avatarUrls; // Disabled until we can build out the logic for it
    
    /*
     * Provides a way to convert an untyped object into a JIRAProject
     */
    public JIRAProjectMeta(Object o) {
        Map<String, Object> uptypedProject = (Map<String, Object>) o;
        List<Object> untypedIssueTypes = (List<Object>) uptypedProject.get('issuetypes');
        issueTypes = untypedIssueTypes != null ? new List<JIRAIssueTypeMeta>() : null;
        
        self = (String) uptypedProject.get('self');
        id = (String) uptypedProject.get('id');
        key = (String) uptypedProject.get('key');
        name = (String) uptypedProject.get('name');
        avatarUrls = new JIRAAvatarUrls(uptypedProject.get('avatarUrls'));
        
        for (Object it : untypedIssueTypes) {
            issueTypes.add(new JIRAIssueTypeMeta(it));
        }
    }
}