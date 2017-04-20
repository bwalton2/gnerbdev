public class JIRAAvatarUrls {
    public string u48x48 {public get; private set;}
    public string u32x32 {public get; private set;}
    public string u24x24 {public get; private set;}
    public string u16x16 {public get; private set;}
    
    public JIRAAvatarUrls(Object o) {
        Map<String, Object> untypedAvatarUrls = (Map<String, Object>) o;
        u48x48 = (String) untypedAvatarUrls.get('48x48');
        u32x32 = (String) untypedAvatarUrls.get('32x32');
        u24x24 = (String) untypedAvatarUrls.get('24x24');
        u16x16 = (String) untypedAvatarUrls.get('16x16');
    }
    
    public JIRAAvatarUrls() {}
}