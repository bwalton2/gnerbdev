public class CaseControllerExension {
    private final Case sourceCase;
    public List<CaseComment> CaseCommentsSortedASC{get; set;}
    public List<CaseComment> CaseCommentsSortedDESC{get; set;}
    public List<EmailMessage> CaseEmailsSortedASC{get; set;}
    public List<EmailMessage> CaseEmailsSortedDESC{get; set;}
    public List<Attachment> caseAttachments{get;set;}
    //In order to accept values from VF a container must be defined
    //this must be class level as parameters cannot be passed to functions directly
    public string cId {get;set;} //Stores Id of the active CaseComment for creating links
    
    public CaseControllerExension (apexPages.StandardController stdCon) { //Constructor
    	this.sourceCase = [SELECT Id, CaseNumber FROM Case WHERE Id = :stdCon.getRecord().Id];
        this.CaseCommentsSortedASC = new List<CaseComment>();
        this.CaseCommentsSortedDESC = new List<CaseComment>();
        this.caseEmailsSortedASC = new List<EmailMessage>();
        this.caseEmailsSortedDESC = new List<EmailMessage>();
        this.caseAttachments = new List<Attachment>();
        cId = '';
        sortCaseComments();
        sortCaseEmails();
        getAttachments();
    }
    
    public PageReference loadComments() {
        sortCaseComments();
        return null;
    }
    
    public PageReference loadEmails() {
        sortCaseEmails();
        return null;
    }
    
    public PageReference loadAttachments() {
        getAttachments();
        return null;
    }
    
    private void sortCaseComments() {
        //If profile ID = gnerb community user, only return published comments
        //Notes: One buld DML statement to maximize functionality
        for (Case c : [SELECT (SELECT CommentBody, CreatedById, CreatedBy.Name, CreatedDate, ParentId, IsPublished 
                       FROM CaseComments ORDER BY CreatedDate ASC) FROM Case WHERE Id = :sourceCase.Id]) {
			for (CaseComment cc : c.CaseComments) {
            	this.CaseCommentsSortedASC.add(cc);
			}
			
            for (integer x = this.CaseCommentsSortedASC.Size()-1; x >= 0; x--) {
				this.CaseCommentsSortedDESC.add(this.CaseCommentsSortedASC[x]);
			}
        }
    }
    
    private void sortCaseEmails() {
        //If profile ID = gnerb community user, only return published comments
        //Notes: One buld DML statement to maximize functionality
        for (Case c : [SELECT (SELECT Id, FromName, Subject, toLabel(Status), CreatedDate, TextBody
                       FROM EmailMessages ORDER BY CreatedDate ASC) FROM Case WHERE Id = :sourceCase.Id]) {
			for (EmailMessage e : c.EmailMessages) {
            	this.CaseEmailsSortedASC.add(e);
			}
			
            for (integer x = this.CaseEmailsSortedASC.Size()-1; x >= 0; x--) {
				this.CaseEmailsSortedDESC.add(this.CaseEmailsSortedASC[x]);
			}
        }
    }
    
    private void getAttachments() {
        Case temp = [SELECT (SELECT Name, CreatedBy.Name FROM Attachments) FROM Case WHERE ID = :sourceCase.Id];
        for (Attachment a : temp.attachments) {
            this.caseAttachments.add(a);
        }
    }

    public PageReference ccEdit() { //Action methods must return a PageReference
        //Page reference must start with a '/' character or they will throw formula error
    	return new PageReference('/' + cId + '/e?parent_id=' + sourceCase.Id + '&retURL=' + sourceCase.Id);
    }
    
    public PageReference ccNew() {
    	return new PageReference('/00a/e?parent_id=' + sourceCase.Id + '&retURL=' + sourceCase.Id);
    }
    
    public PageReference aEdit() {
        return new PageReference('/' + cId + '/e?retURL=' + sourceCase.Id);
    }
    
    public PageReference aNew() {
    	return new PageReference('/p/attach/NoteAttach?pid=' + sourceCase.Id + '&parentname=' + sourceCase.CaseNumber + '&retURL=' + sourceCase.Id);
    }
    
    public PageReference aView() {
        return new PageReference('https://gnerb-dev-ed--c.na34.content.force.com/servlet/servlet.FileDownload?file=' + cId);
    }
    
    public PageReference eView() {
        return new PageReference('/' + cId);
    }
}