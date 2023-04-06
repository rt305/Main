public class OpportunityTriggerHandler {
    public static void onAfterInsert(List<Opportunity> newList){
        
        Set<Id> setIds = new Set<Id>();
        List<Account> accToBeUpdated = new List<Account>();
        
        for(Opportunity opp : newList){
            if(opp.AccountId != NULL){
                setIds.add(opp.AccountId);
            }
        }
        
    }

}