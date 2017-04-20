public class fakeobjtriggerhelper {
    public static void go() {
        if (trigger.isbefore || trigger.isafter) {
            system.debug('gotcha');
        }
    }
}