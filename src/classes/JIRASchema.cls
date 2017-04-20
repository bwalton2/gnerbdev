public class JIRASchema {
    public String uSystem {public get; private set;} // System is a reserved word. This is not available in typed deserialization
    public String uType {public get; private set;} // Type is a reserved word. This is not available in typed deserialization
    public String items {public get; private set;}
    public String custom {public get; private set;}
    public Integer customId {public get; private set;}
    
    public JIRASchema(Object o) {
        Map<String, Object> untypedJIRASchema = (Map<String, Object>) o;
        uSystem = (String) untypedJIRASchema.get('system');
        uType = (String) untypedJIRASchema.get('type');
        items = (String) untypedJIRASchema.get('items');
        custom = (String) untypedJIRASchema.get('custom');
        customId = (Integer) untypedJIRASchema.get('customId');
    }
}