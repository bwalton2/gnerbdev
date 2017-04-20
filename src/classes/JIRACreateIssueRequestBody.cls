public class JIRACreateIssueRequestBody {
    Public Map<String, Object> fields {
        get {
            if (fields == null) {
                fields = new Map<String, Object>();
            }
            
            return fields;
        }
        
        private set;
    }
    
    /*
     * Simple method wrapper to provide a friendly name
     * for a standard field.
     */
    public void setProjectKey(String projectKey) {
        setProjectPicker('project', projectKey, false);
    }
    
    /*
     * Gets the value of the project field's key
     * 
     * @return String The project field's key
     */
    public String getProjectKey() {
        return getUntypedIdentifier('project');
    }
    
    /*
     * Simple method wrapper to provide a friendly name
     * for a standard field.
     */
    public void setIssueTypeName(String issueTypeName) {
        setUntypedIdentifierObject('issuetype', issueTypeName, false);
    }
    
    /*
     * Gets the value of the issue type field's name
     * 
     * @return String The issue type field's name
     */
    public String getissueTypeName() {
        return getUntypedIdentifier('issuetype');
    }
    
    /*
     * Simple method wrapper to provide a friendly name
     * for a standard field.
     * 
     * @param String The value to set the summary field to
     */
    public void setSummary(String summary) {
        setTextField('summary', summary);
    }
    
    /*
     * Simple method wrapper to provide a fiendly name for
     * a standard field.
     *
     * @return String The value of the summary field
     */
    public String getSummary() {
        return getTextField('summary');
    }
    
    /*
     * Simple method wrapper to provide a friendly name
     * for a standard field.
     *
     * @param String The value to set the description field to
     */
    public void setDescription(String description) {
        setTextField('description', description);
    }
    
    /*
     * Simple method wrapper to provide a friendly name
     * for a standard field.
     *
     * @return String The value of the description field
     */
    public String getDescription() {
        return getTextField('description');
    }
    
    /*
     * Sets the value of a date picker field. This override accepts strings.
     * Strings are preferred as that is what JIRA Rest API requires.
     *
     * @param String The name of the field to be updated.
     * @param String The 4 digit year of the date.
     * @param String The 2 digit month of the date.
     * @param String The 2 digit day of the date.
     */
    public void setDateField(String name, String YYYY, String MM, String DD) {
        // ToDo: Add validation on the params
        fields.put(name, YYYY + '-' + MM + '-' + DD);
    }
    
    /*
     * Sets the value of a date picker field. This ovverride accepts integers.
     * This override requires extra processing to convert integers to strings;
     * as such, this method is not preferred.
     *
     * @param String The name of the field to be updated.
     * @param Integer The 4 digit year of the date.
     * @param Integer The 2 digit month of the date.
     * @param Integer The 2 digit day of the date.
     */
    public void setDateField(String name, Integer YYYY, Integer MM, Integer DD) {
        fields.put(name, String.valueOf(YYYY) + '-' + String.valueOf(MM) + '-' + String.valueOf(DD));
    }
    
    /*
     * Gets the value of a date field
     * 
     * @param String The name of the field to retreive
     * @return String The value of the date field in a formatted string.
     */
    public String getDateField(String name) {
        return getTextField(name);
    }
    
    /*
     * Sets the value of a date/time field. This override accespts strings.
     * Strings are preferred as that is what is required by JIRA rest API.
     *
     * <p>
     * For the time being timezone is not supported.
     * </p>
     *
     * @param String The name of the field to be updated
     * @param String The 4 digit year of the date
     * @param String The 2 digit month of the date
     * @param String The 2 digit day of the date
     * @param String The 2 digit hour of the time
     * @param String The 2 digit minute of the time
     * @param String The 2 digit second of the time
     * @param String The 1-3 digit millisecond of the time
     */
    public void setDateTimeField(String name, String YYYY, String MM, String DD,
        String hh, String mi, String ss, String s) {
        String dateString = YYYY + '-' + MM + '-' + DD;
        String timeString = hh + ':' + mi + ':' + ss + '.' + s;
        setTextField(name, dateString + 'T' + timeString);
    }
    
    /*
     * Sets the value of a date/time field. This override accespts integers.
     * This override requires extra processing to convert integers to strings;
     * as such, this method is not preferred.
     *
     * <p>
     * For the time being timezone is not supported.
     * </p>
     *
     * @param String The name of the field to be updated
     * @param Integer The 4 digit year of the date
     * @param Integer The 2 digit month of the date
     * @param Integer The 2 digit day of the date
     * @param Integer The 2 digit hour of the time
     * @param Integer The 2 digit minute of the time
     * @param Integer The 2 digit second of the time
     * @param Integer The 1-3 digit millisecond of the time
     */
    public void setDateTimeField(String name, Integer YYYY, Integer MM, Integer DD,
        Integer hh, Integer mi, Integer ss, Integer s) {
        String dateString = String.valueOf(YYYY) + '-' + String.valueOf(MM) + '-' + String.valueOf(DD);
        String timeString = String.valueOf(hh) + ':' + String.valueOf(mi) + ':' + String.valueOf(ss) + '.' + String.valueOf(s);
        setTextField(name, dateString + 'T' + timeString);
    }
    
    /*
     * Gets the value of a date/time field
     * 
     * @param String The name of the field to retreive
     * @return String The value of the date/time field in a formatted string.
     */
    public String getDateTimeField(String name) {
        return getTextField(name);
    }
    
    /*
     * Sets the value of a free text field.
     *
     * @param String The name of the field to be set
     * @param String The text to set the field to
     */
    public void setTextField(String name, String text) {
        fields.put(name, text);
    }
    
    /*
     * Returns the value of a text field
     *
     * @param String The name of the field to retrieve
     * @return String The value of the desired field
     */
    public String getTextField(String name) {
        return (String) fields.get(name);
    }
    
    /*
     * Sets the value of a single group picker field
     *
     * @param String The name of the field to be set
     * @param String The name or id of the group to set the field to
     * @param Boolean True if the provided groupName is an id; false if it is
     * a name.
     */
    public void setGroupPicker(String name, String groupName, Boolean isId) {
        setUntypedIdentifierObject(name, groupName, isId);
    }
    
    /*
     * Sets the value of a single group picker field. This override
     * always assumes you're pasing an id.
     *
     * @param String The name of the field to be set
     * @param String The name or id of the group to set the field to
     */
    public void setGroupPicker(String name, String groupName) {
        setGroupPicker(name, groupName, true);
    }
    
    /*
     * Returns the group identifier from the specified group picker filed
     *
     * @param String The name of the field to be retreived
     * @return String The identifier stored in the group picker field
     */
    public String getGroupPicker(String name) {
        return getUntypedIdentifier(name);
    }
    
    /*
     * Sets the value of a label field.
     *
     * @param String The name of the field to be set
     * @param List<String> The labels to populate the field with
     */
    public void setLabelField(String name, List<String> labels) {
        fields.put(name, labels);
    }
    
    /*
     * Sets the value of a label field. This override accepts a single
     * string and converts it to a list.
     *
     * @param String The name of the field to be set
     * @param List<String> The labels to populate the field with
     */
    public void setLabelField(String name, String label) {
        List<String> labels = new List<String>{label};
        setLabelField(name, labels);
    }
    
    /*
     * Gets the labels specified in a label field.
     *
     * @param String The name of the field to retrieve
     * @return List<String> The labels contained in the field
     */
    public List<String> getLabelField(String name) {
        return (List<String>) fields.get(name);
    }
    
    /*
     * Sets the value of a multiGroupPicker field.
     * 
     * @param String The name of the field to be set
     * @param List<String> A list containing all of the names or ids to populate the field with
     * @param Boolean True if the provided names are ids; false if they are names
     */
    public void setMultiGroupPicker(String name, List<String> groupNames, Boolean isId) {
        setMultiUntypedIdentifierObject(name, groupNames, isId);
    }
    
    /*
     * Gets the value of a multiGrouPicker field.
     *
     * @param String The name of the field to be set
     * @return List<String> The identifiers stored in the field
     */
    public List<String> getMultiGroupPicker(String name) {
        return getMultiUntypedIdentifierObject(name);
    }
    
    /*
     * Sets the value of a multiSelectField.
     *
     * @param String The name of the field to be udpated
     * @param List<String> The desired values for the pick list
     */
    public void setMultiSelectField(String name, List<String> values) {
        setMultiUntypedIdentifierObject(name, values, false, 'value');
    }
    
    /*
     * Returns a list of values stored in a multiSelectField
     *
     * @param String The name of the field to retrieve
     * @return List<String> The values stored in the field
     */
    public List<String> getMultiSelectField(String name) {
        return getMultiUntypedIdentifierObject(name);
    }
    
    /*
     * Sets the value of a multiUserPicker field.
     * 
     * @param String The name of the field to be set
     * @param List<String> A list containing all of the names or ids to populate the field with
     * @param Boolean True if the provided names are ids; false if they are names
     */
    public void setMultiUserPicker(String name, List<String> userNames, Boolean isId) {
        setMultiUntypedIdentifierObject(name, userNames, isId);
    }
    
    /*
     * Returns a list of values stored in a MultiUserPicker
     *
     * @param String The name of the field to retrieve
     * @return List<String> The values stored in the field
     */
    public List<String> getMultiUserPicker(String name) {
        return getMultiUntypedIdentifierObject(name);
    }
    
    /*
     * Sets the value of a number field
     * 
     * @param String The name of the field to be updated
     * @param Decimal The value to set the field to
     */
    public void setNumberField(String name, Decimal value) {
        fields.put(name, value);
    }
    
    /*
     * Returns the value of a number field
     *
     * @param String The name of the field to retrieve
     * @return Decimal The value stored in the field
     */
    public Decimal getNumberField(String name) {
        return (Decimal) fields.get(name);
    }
    
    /*
     * Sets the value of a projectPicker field.
     *
     * @param String The name of the field to be set
     * @param String The id or the key of the project
     * @param Boolean True if the provided value is an id, false if it is a key
     */
    public void setProjectPicker(String name, String projectId, Boolean isId) {
        setUntypedIdentifierObject(name, projectId, isId, 'key');
    }
    
    /*
     * Returns the value of a projectPicker field.
     *
     * @param String The name of the field to retrieve
     * @return String The value stored in the field
     */
    public String getProjectPicker(String name) {
        return getUntypedIdentifier(name);
    }
    
    /*
     * Sets the value of a radioButtons field
     *
     * @param String The name of the field to be set
     * @param String The id of the value -OR- the value to set the field to
     * @param Boolean True if the value is an id, false if it is a string value
     */
    public void setRadioButtons(String name, String value, Boolean isId) {
        setUntypedIdentifierObject(name, value, isId, 'value');
    }
    
    /*
     * Returns the value of a radioButtons field
     *
     * @param String The name of the field
     * @return String The value stored in the field
     */
    public String getRadioButtons(String name) {
        return getUntypedIdentifier(name);
    }
    
    /*
     * Sets the value of a selectList field
     * 
     * @param String The name of the field to be set
     * @param String The value to set the field to
     * @param Boolean True if the value is an id, false if it is a string value
     */
    public void setSelectList(String name, String value, Boolean isId) {
        setUntypedIdentifierObject(name, value, isId, 'value');
    }
    
    /*
     * Returns the value of a selectList field
     *
     * @param String The name of the field
     * @return String The value stored in the field
     */
    public String getSelectList(String name) {
        return getUntypedIdentifier(name);
    }
    
    /*
     * Sets the value of a singleVersionPicker field
     * 
     * @param String The name of the field to set
     * @param String The name or id of the version to populate the field with
     * @param Boolean True if the name is an id, false if it is a name
     */
    public void setSingleVersionPicker(String name, String versionName, Boolean isId) {
        setUntypedIdentifierObject(name, versionName, isId);
    }
    
    /*
     * Returns the value of a singleVersionPicker field
     *
     * @param String The name of the field
     * @return String The value stored in the field
     */
    public String getSingleVersionPicker(String name) {
        return getUntypedIdentifier(name);
    }
    
    /*
     * Sets the value of a URL field
     *
     * @param String The name of the field to set
     * @param String The value to set the field to
     */
    public void setUrlField(String name, String value) {
        setTextField(name, value);
    }
    
    /*
     * Returns the value of a url field
     *
     * @param String The name of the field
     * @return String The value stored in the field
     */
    public String getUrlField(String name) {
        return getTextField(name);
    }
    
    /*
     * Sets the value of a userPicker field
     *
     * @param String The name of the field to set
     * @param String The name or id of the user to populate the field with
     * @param Boolean Trie if the id is provided; false if a name is provided
     */
    public void setUserPicker(String name, String identifier, Boolean isId) {
        setUntypedIdentifierObject(name, identifier, isId);
    }
    
    /*
     * Returns the value of a userPicker field
     *
     * @param String The name of the field
     * @return String The value stored in the field
     */
    public String getUserPicker(String name) {
        return getUntypedIdentifier(name);
    }
    
    /*
     * Sets the value of a versionPicker field.
     *
     * @param String The name of the field to set
     * @param List<String> The identifiers for the desired versions
     * @param Boolean True if the identifier is an id; false if it is a name
     */
    public void setVersionPicker(String name, List<String> identifiers, Boolean isId) {
        setMultiUntypedIdentifierObject(name, identifiers, isId);
    }
    
    /*
     * Returns the value of a versionPicker field
     *
     * @param String The name of the field
     * @return String The value stored in the field
     */
    public String getVersionPicker(String name) {
        return getUntypedIdentifier(name);
    }
    
    /*
     * Sets the value of an untyped Identifier JSON Object. This override
     * assumes the most common isIdOrKey of name.
     *
     * @param String The name of the indentifier field
     * @param String The identifier (name, id, or in rare cases a non-standard key)
     * @param Boolean True if the provided identifier is an id; false if the identifier
     * is of a different type.
     */
    public void setUntypedIdentifierObject(String name, String identifier, Boolean isId) {
        setUntypedIdentifierObject(name, identifier, isId, 'name');
    }
    
    /*
     * Sets the value of an untyped Identifier JSON Object.
     *
     * @param String The name of the indentifier field
     * @param String The identifier (name, id, or in rare cases a non-standard key)
     * @param Boolean True if the provided identifier is an id; false if the identifier
     * is of a different type.
     * @param String The key to use if the provided value is not an id.
     */
    public void setUntypedIdentifierObject(String name, String identifier, Boolean isId,
        String isIdOrKey) {
        Map<String, Object> untypedIdentifier = new Map<String, Object>();
        
        if (isId) {
            untypedIdentifier.put('id', identifier);
        } else {
            untypedIdentifier.put(isIdOrKey, identifier);
        }
        
        fields.put(name, untypedIdentifier);
    }
    
    /*
     * Returns the value of an untyped identifier JSON object. Note, an identifier
     * object should only have 1 key. If more then 1 key is present this method
     * does not guartentee which key will be returned.
     *
     * @param String The name of the identifier to retrieve
     * @return String The requested identifier
     */
    public String getUntypedIdentifier(String name) {
        Map<String, Object> untypedIdentifier = (Map<String, Object>) fields.get(name);
        
        for (Object o : untypedIdentifier.values()) {
            return (String) o;
        }
        
        return null;
    }
    
    /*
     * Sets the value of an multi untyped identifier JSON Object. This override
     * assumes the standard isIdOrKey of name.
     *
     * @param String The name of the identifier field
     * @param String A list of identifiers (name, id, or in rare cases a non-standard key)
     * @param Boolea True if the provided identifiers are ids; false if they are of a
     * different type.
     * @param String the key to use if the provided idnetifiers are not ids
     */
    public void setMultiUntypedIdentifierObject(String name, List<String> identifiers, Boolean isId) {
        setMultiUntypedIdentifierObject(name, identifiers, isId, 'name');
    }
    
    /*
     * Sets the value of an multi untyped identifier JSON Object
     *
     * @param String The name of the identifier field
     * @param String A list of identifiers (name, id, or in rare cases a non-standard key)
     * @param Boolea True if the provided identifiers are ids; false if they are of a
     * different type.
     * @param String the key to use if the provided idnetifiers are not ids
     */
    public void setMultiUntypedIdentifierObject(String name, List<String> identifiers, Boolean isId,
        String isIdOrKey) {
        List<Object> multiUntypedIdentifierObject = new List<Object>();
        
        for (String s : identifiers) {
            Map<String, Object> untypedIdentifier = new Map<String, Object>();
            
            if (isId) {
                untypedIdentifier.put('id', s);
            } else {
                untypedIdentifier.put(isIdOrKey, s);
            }
            
            multiUntypedIdentifierObject.add(untypedIdentifier);
        }
        
        fields.put(name, multiUntypedIdentifierObject);
    }
    
    /*
     * Gets the list of identifiers stored in the specified field.
     *
     * @param String The name of the field to be retrieved
     * @return List<String> The identifiers stored in the field.
     */
    public List<String> getMultiUntypedIdentifierObject(String name) {
        List<Object> multiUntypedIdentifierObject = (List<Object>) fields.get(name);
        List<String> result = new List<String>();
        
        for (Object o : multiUntypedIdentifierObject) {
            Map<String, Object> untypedIdentifier = (Map<String, Object>) o;
            
            for (Object oo : untypedIdentifier.values()) {
                result.add((String) oo);
            }
        }
        
        return result;
    }
    
    /*
     * Simple wrapper for removing fields
     *
     * @param String The name of the field to be dropped
     */
    public void removeField(String name) {
        fields.remove(name);
    }
    // To Do: Add validations?? (I assume this will happen on JIRA's side but adding them here might speed things up)
    // To Do: Create a JIRARequestBody virtual class to store the field methods so they can be re-used in other request bodies
}