public class JIRAAssignee extends JIRAField {
	public String autoCompleteUrl {public get; private set;}
    
    public JIRAAssignee (Object o) {
        super(o);
        Map<String, Object> untypedCustomField_10104 = (Map<String, Object>) o;
        autoCompleteUrl = (String) untypedCustomField_10104.get('autoCompleteUrl');
    }
}