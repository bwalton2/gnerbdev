trigger CaseAttachment on Attachment (after insert) {
    Set<Id> Parents = new Set<Id>();
    List<Attachment> newFiles = new List<Attachment>();
    
    for (attachment a : Trigger.New) {
        Parents.add(a.parentId);
    }

    for (EmailMessage e : [SELECT Id, ParentId FROM EmailMessage WHERE Id in :Parents]) { //loop through unique parents
        for (Attachment a : Trigger.New) {
            if (e.Id == a.ParentId) {
                Attachment newFile = a.clone();
                newFile.ParentId = e.ParentId;
                newFiles.add(newFile);
            }
        }
    }

    Insert newFiles;
}