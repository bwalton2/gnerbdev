trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        createTasks(Trigger.new);
    }
    
    private void createTasks(List<Opportunity> opps) {
        List<Task> newTasks = new List<Task>();
        
        for (Opportunity o : Trigger.new) {
            if (o.stageName == 'Closed Won') {
                newTasks.add(new Task(
                	whatId = o.Id,
                    subject = 'Follow Up Test Task'
                ));
            }
        }
        
        if (newTasks.size() > 0) {
            insert newTasks;
        }
    }
}