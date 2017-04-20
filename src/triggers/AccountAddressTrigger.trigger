trigger AccountAddressTrigger on Account (before insert, before update) {
    if (trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) {
        for (Account a : trigger.new) {
            if (a.Match_Billing_Address__c) {
                a.ShippingPostalCode = a.BillingPostalCode;
            }
        }
    }
}