public class testRest {
    public void auth() {
        String projectKey;
        String issueTypeName;
        
        JIRAIntegrationHelper jih = new JIRAIntegrationHelper();
        jih.typed = false;
        
        List<JIRAProjectMeta> jps = jih.getProjects(); // Gets the projects, pass true to include the fields available to the project's issue types

        for (JIRAProjectMeta jp : jps) {
            projectKey = jp.key;
            for (JIRAIssueTypeMeta jit : jp.issueTypes) {
                if (jit.name == 'Bug') {
                    issueTypeName = jit.name;
                }
            }
        }
        
        jih.getIssueTypeFields(projectKey, issueTypeName);
    }
}