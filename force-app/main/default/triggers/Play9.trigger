trigger Play9 on Account (before delete) {
    
    List<Contact> conList = new List<Contact>();
    
    for(Account acc : trigger.old){
        conList = [Select id, accountId from contact where accountId =: acc.Id];
        
        if(conList != null){
            for(Contact con : conList){
                con.AccountId = null;
            }
        }
        
    }

}