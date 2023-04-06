public class accountEmailUpdate {
    public static void accountMethod(List<Account>aclist){
        
        set<id> accountId = new set<id>();
        for(Account ac : aclist){
            if(ac.Email__c != Null){
                accountId.add(ac.Id);
            }
        }
        map<Id,Account> accountmap = new map<Id,Account>([SELECT Id, Email__c,(select Id, Email from contacts) from Account where Id IN : accountId]);
        List<Contact> clist = new List<Contact>();
        
        for(Account ac : aclist){
            if(ac.Email__c != Null){
                Account ac1 = accountmap.get(ac.Id);
                List<Contact>lstCont = ac1.contacts;
                for(Contact c : lstCont){
                    c.Email = ac.Email__c;
                    clist.add(c);
                }              
            }
            Update clist;
        }
    }
}