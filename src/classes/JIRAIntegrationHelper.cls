public class JIRAIntegrationHelper {
    /*
     * Used to send all requests to JIRA
     */
    private Http http;
    
    /*
     * This is the request object used interally to the class.
     * For reasons I haven't cared to investigate, when I define
     * this variable within the individual methods SFDC wont
     * expose the HttpRequest methods to me.
     */
    private HttpRequest request;
    
    /*
     * Determines if the helper uses typed or untyped JSON parsing.
     * - Typed parsing is faster but more limited
     * - Untyped parsing is slower but more complete
     */
    public Boolean typed;
    
    // ToDo: Find somwhere customizable to store these configs
    // like custom settings/custom meta-data types
    private String authString = 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf('brendwalton:HungMuppets'));
    private String restEndpoint = 'https://gnerbdev.atlassian.net/rest/api/latest/';
    private String contentType = 'application/json';
    
    public JIRAIntegrationHelper() {
        http = new Http();
        typed = true;
    }
    
    /*
     * Provides overload for getProjects that has a default of false
     * for grabFields. We default to false for efficiency. Pass true
     * to include fields. Alternatively, use getIssueTypeFields to
     * request fields for a specific issue type.
     */
    public List<JIRAProjectMeta> getProjects() {
        return getProjects(false);
    }
    
    /*
     * Gets a list of all projects that the API user has access to
     * in the specified Jira instance.
     * 
     * @param determins if expandFields is added to the request.
     * @return List<JIRAProjectMeta> List of all projects that the API
     * user has access to in the specified Jira instance.
     */
    public List<JIRAProjectMeta> getProjects(Boolean grabFields) {
        getProjectsRequest(grabFields);
        JIRACreateMetaResponse createMetaResponse = getCreateMetaResponse();
        
        return createMetaResponse.projects;
    }
    
    public List<JIRAIssueTypeMeta> getIssueTypeFields(String projectKey, String issueTypeName) {
        getIssueTypeFieldsRequest(projectKey, issueTypeName);
        JIRACreateMetaResponse createMetaResponse = getCreateMetaResponse();
        List<JIRAIssueTypeMeta> result = new List<JIRAIssueTypeMeta>();

        for (JIRAProjectMeta jp : createMetaResponse.projects) {
            for (JIRAIssueTypeMeta jit : jp.issueTypes) {
                result.add(jit);
            }
        }
        
        return result;
    }
    
    /*
     * Provides a default override where grabFields is false.
     * Default to false as it is much faster to process the
     * getProjectsRequest. Call the overload that accepts a 
     * boolean and pass true to include fields in the request.
     * Alternatively, call getIssueTypeFields to request
     * fields for a specific issue type.
     */
    public HttpRequest getProjectsRequest() {
        return getProjectsRequest(false);
    }
    
    public HttpRequest getIssueTypeFieldsRequest(String projectKey, String issueTypeName) {
        request = new HttpRequest();
        
        request.setEndpoint(
            restEndpoint + 'issue/createmeta?projectKeys=' + projectKey +
        	'&issuetypeNames=' + issueTypeName + '&expand=projects.issuetypes.fields'
        );
        
        request.setMethod('GET');
        setDefaultHeaders();
        return request;
    }
    
    /*
     * Returns a request that will retrieve the Jira Instance's projects
     */
    public HttpRequest getProjectsRequest(Boolean grabFields) {
        request = new HttpRequest();
        request.setEndpoint(restEndpoint + 'issue/createmeta');
        
        if (grabFields) {
            request.setEndpoint(request.getEndpoint() + '?expand=projects.issuetypes.fields');
        }
        
        request.setMethod('GET');
        setDefaultHeaders();
        return request;
    }
    
    public HttpRequest getCreateIssueRequest() {
        request = new HttpRequest();
        request.setEndpoint(restEndpoint + 'issue/');
        request.setMethod('POST');
        setDefaultHeaders();
        return request;
    }
    
    /*
     * Creates an issue with the provided content body. This 
     * is the most abbreviated way of creating an issue.
     * 
     * <p>
     * The body MUST contain the project key and issue name. Ids are not supported.
     * </p>
     * 
     * <p>
     * Why are ids not supported? Consistency with other methods.
     * </p>
     */
    public JIRACreateIssueResponse createIssue(JIRACreateIssueRequestBody body) {
        String projectKey = body.getProjectKey();
        String issueTypeName = body.getIssueTypeName();
        
        return createIssue(projectKey, issueTypeName, body);
    }
    
    /*
     * Creates an issue with the provided project key, IssueTypeName and content body.
     * 
     * <p>
     * This overload does not require the developer to provide a JIRAIssueTypeMeta.
     * </p>
     * 
     * @param String The key of the project this issue type should be created under (TP or SFE)
     * @param String The name of the type of issue (Bug or Task)
     * @param JIRACreateIssueRequestBody The data to be used to create the issue.
     */
    public JIRACreateIssueResponse createIssue(String projectKey, String issueTypeName, JIRACreateIssueRequestBody body) {
        JIRAIssueTypeMeta result;
        
        for (JIRAIssueTypeMeta jit : getIssueTypeFields(projectKey, issueTypeName)) {
            if (jit.name == issueTypeName) {
                result = jit;
                break;
            }
        }
        
        return createIssue(projectKey, result, body);
    }
    
    /*
     * Creates an issue with the provided project key, issue type and content body.
     * This overload requires the most work prior to calling it and is provided as
     * a way of reducing callouts in the event that the developer has already collected
     * this data through processing other requests.
     * 
     * @param String The key of the project the issue should be nested under
     * @param JIRAIssueTypeMeta the issue type of the new issue
     * @param JIRACreateIssueRequestBody The content of the issue to be created
     */
    public JIRACreateIssueResponse createIssue(String projectKey, JIRAIssueTypeMeta issueType, JIRACreateIssueRequestBody body) {
        getCreateIssueRequest();
        request.setBody(JSON.serialize(body));
        
        return getCreateIssueResponse();
    }
    
    public JIRACreateIssueResponse getCreateIssueResponse() {
        HttpResponse response = http.send(request);
        JIRACreateIssueResponse createIssueResponse;
        
        createissueResponse = (JIRACreateIssueResponse) JSON.deserialize(
        	response.getBody(),
            JIRACreateIssueResponse.class
        );
        
        return createissueResponse;
    }
    
    public JIRACreateMetaResponse getCreateMetaResponse() {
        HttpResponse response = http.send(request);
        system.debug('response');
        system.debug(response.getBody());
        JIRACreateMetaResponse createMetaResponse;
        
        if (typed) {
            createMetaResponse = (JIRACreateMetaResponse) JSON.deserialize(
                response.getBody(), 
                JIRACreateMetaResponse.class
            );
        } else {
            createMetaResponse = new JIRACreateMetaResponse(JSON.deserializeUntyped(response.getBody()));
        }
        
        return createMetaResponse;
    }
    
    /*
     * Used to set the basic headers for all requests.
     * Content Type and Authorization
     */
    private void setDefaultHeaders() {
        request.setHeader('Content-Type', contentType);
        request.setHeader('Authorization', authString);
    }
    
    private class JIHException extends Exception {}
}