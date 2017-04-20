trigger fobjjtrig on fakeobj__c (before insert, before update, after insert, after update, before delete, after delete) {
	fakeobjtriggerhelper.go();
}