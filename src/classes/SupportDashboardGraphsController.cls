public with sharing class SupportDashboardGraphsController {
    public List<Document> Documents {get;set;} //List of documents to be brought into the vf page
    
    public SupportDashboardGraphsController () { //Constructor
        Documents = [SELECT Id, body, name FROM Document where Keywords Like '%Support Dashboard%' ORDER BY Keywords ASC];
    }
    
    public PageReference UpdateDocuments() {
        update Documents;
        return null;
    }
}