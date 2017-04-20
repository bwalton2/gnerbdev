@isTest
public class TestVerifyDate {
	@isTest
    public static void test_within30() {
        Date one = date.newInstance(2016, 1, 1);
        Date two = date.newInstance(2016, 1, 2);
        
        system.assertEquals(two, VerifyDate.CheckDates(one, two));
    }
    
    @isTest
    public static void test_greaterThan30() {
        Date one = date.newInstance(2016, 1, 1);
        Date two = date.newInstance(2016, 2, 28);
        
        system.assert(two != VerifyDate.CheckDates(one, two));
    }
}