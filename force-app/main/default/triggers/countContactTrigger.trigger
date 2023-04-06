trigger countContactTrigger on Contact (after insert, after delete, after undelete) {
    Set<Id> accountIds = new Set<Id>();
    
    if(trigger.isInsert){
        for(Contact con: Trigger.new){
            if(con.AccountId != null){
                accountIds.add(con.AccountId);
            }
        }
    }
    if(trigger.isDelete){
        for(Contact con: Trigger.old){
            if(con.AccountId != null){
                accountIds.add(con.AccountId);
            }
        }
    }
    if(trigger.isUndelete){
        for(Contact con: Trigger.new){
            if(con.AccountId != null){
                accountIds.add(con.AccountId);
            }
            
        }
        List<Account> accList = [Select Id, Number_of_Contacts__c,(Select Id from Contacts) From Account Where Id IN: accountIds ];
        List<Account> updateAccList = new List<Account>();
        for(Account acc : accList){
            Account objAcc = new Account ( Id = acc.Id, Number_of_Contacts__c = acc.Contacts.size() );
            updateAccList.add(objAcc);
        }
        Update updateAccList;
        
    }        
    
}  





// Number_of_Contacts__c