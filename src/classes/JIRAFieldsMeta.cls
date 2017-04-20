public class JIRAFieldsMeta {
	// ToFinish: Create objects for each of these fields
	public JIRAAssignee assignee;
    public JIRAAttachmentField attachment;
    public JIRAComponentsField components;
    public JIRADescription description;
    public JIRAFixVersions fixVersions;
    public JIRAIssueLinks issueLinks;
    public JIRAIssueTypeMeta issueType;
    
    // ToDo: Test if these customfield ids are consistent across all jira instances
    public JIRACustomField_10005 customfield_10005; // Epic Link
    public JIRACustomField_10002 customfield_10002; // Epic Name
    public JIRACustomField_10104 customfield_10104; // Parent Link
    public JIRACustomField_10115 customfield_10115; // Sprint
    
    // Untyped map for storing custom fields
    public Map<String, Object> customFields;
    
    public JIRAFieldsMeta(Map<String, Object> untypedFields) {
        assignee = untypedFields.get('assignee') != null ? new JIRAAssignee(untypedFields.get('assignee')) : null;
        attachment = untypedFields.get('attachment') != null ? new JIRAAttachmentField(untypedFields.get('attachment')) : null;
        components =  untypedFields.get('components') != null ? new JIRAComponentsField(untypedFields.get('components')) : null;
        description = untypedFields.get('description') != null ? new JIRADescription(untypedFields.get('description')) : null;
        fixVersions = untypedFields.get('fixVersions') != null ? new JIRAFixVersions(untypedFields.get('fixVersions')) : null;
        issueLinks = untypedFields.get('issueLinks') != null ? new JIRAIssueLinks(untypedFields.get('issueLinks')) : null;
        issueType = untypedFields.get('issueType') != null ? new JIRAIssueTypeMeta(untypedFields.get('issueType')) : null;
        customfield_10005 = untypedFields.get('customfield_10005') != null ? new JIRACustomField_10005(untypedFields.get('customfield_10005')) : null;
        customfield_10002 = untypedFields.get('customfield_10002') != null ? new JIRACustomField_10002(untypedFields.get('customfield_10002')) : null;
        customfield_10104 = untypedFields.get('customfield_10104') != null ? new JIRACustomField_10104(untypedFields.get('customfield_10104')) : null;
        customfield_10115 = untypedFields.get('customfield_10115') != null ? new JIRACustomField_10115(untypedFields.get('customfield_10115')) : null;
        
        // Remove known fields
        untypedFields.remove('assignee');
        untypedFields.remove('attachment');
        untypedFields.remove('components');
        untypedFields.remove('description');
        untypedFields.remove('fixVersions');
        untypedFields.remove('issueLinks');
        untypedFields.remove('issueType');
        untypedFields.remove('customfield_10005');
        untypedFields.remove('customfield_10002');
        untypedFields.remove('customfield_10104');
        untypedFields.remove('customfield_10115');
        
        // All remaining unknown fields are treated as custom
        if (untypedFields.size() > 0) {
            customFields = untypedFields;
        }
    }
}