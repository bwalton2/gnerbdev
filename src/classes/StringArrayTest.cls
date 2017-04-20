public class StringArrayTest {
    public static List<String> generateStringArray(integer n) {
        List<String> result = new List<String>();
        
        for (integer x = 0; x < n; x++) {
        	result.add('Test ' + x);    
        }
        
        return result;
    }
}