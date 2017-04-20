public class testcontroller {
	public boolean testb {get;set;}
    public boolean show {
        get {
            if (testB) {
                return true;
            } else {
                return false;
            }
        }
        set;
    }
    
    public testController() {
        testb = true;
    }
    
    public pageReference outputValue() {
        system.debug(testb);
        return null;
    }
}