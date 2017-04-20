public class JIRACreateMetaResponse {
	public String expand {public get; private set;}
    public List<JIRAProjectMeta> projects {public get; private set;}
    
    /*
     * Converts an untyped object into a JIRACreateMetaResponse.
     * 
     * Note: Due to annoying issues in apex, I can't provide a valid
     * type casting option. This constructor is the best we can do.
     */
    public JIRACreateMetaResponse(Object o) {
        Map<String, Object> untypedProjectResponse = (Map<String, Object>) o;
        List<Object> untypedProjects = (List<Object>) untypedProjectResponse.get('projects');
        
        projects = new List<JIRAProjectMeta>();
        
        expand = (String) untypedProjectResponse.get('expand');
        
        for (Object p : untypedProjects) {
            projects.add(new JIRAProjectMeta(p));
        }
    }
    
    /*
     * Provides the basic constructor
     */
    public JIRACreateMetaResponse() {}
}