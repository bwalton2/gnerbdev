public virtual class JIRAField {
	public Boolean hasDefaultValue;
    public String key;
    public String name;
    public List<String> operations;
    public Boolean required;
    public JIRASchema schema;
    
    /*
     * Convert the provided object into a map and pass it
     * to the cunstructor that does all the work.
     */
    public JIRAField (Object o) {
        this((Map<String, Object>) o);
    }
    
    /*
     * Provides a way to pass a pre-converted map. This is
     * to allow minimising the number of conversions required.
     */
    public JIRAField (Map<String, Object> untypedField) {
        hasDefaultValue = (Boolean) untypedField.get('hasDefaultValue');
        key = (String) untypedField.get('key');
        name = (String) untypedField.get('name');
        required = (Boolean) untypedField.get('required');
        schema = new JIRASchema(untypedField.get('schema'));
        
        List<Object> untypedOperations = (List<Object>) untypedField.get('operations');
		operations = new List<String>();
        
        for (Object o : untypedOperations) {
            operations.add((String) o);
        }
    }
    
    /*
     * Checks the field to see if it has the set verb.
     */
    public Boolean hasSet() {
        for (String s : operations) {
            if (s == 'set') {
                return true;
            }
        }
        
        return false;
    }
    
    /*
     * Checks the field to see if it has the set verb.
     */
    public Boolean hasAdd() {
        for (String s : operations) {
            if (s == 'add') {
                return true;
            }
        }
        
        return false;
    }
    
    /*
     * Checks the field to see if it has the set verb.
     */
    public Boolean hasRemove() {
        for (String s : operations) {
            if (s == 'remove') {
                return true;
            }
        }
        
        return false;
    }
}