trigger Play7 on Account (before insert, before update) {
    
    
    List<Account> listAccount = [Select Id, Name from Account];
    List<String> listAccountName = new List<String>();
    
    for(Account acc : listAccount){
        listAccountName.add(acc.Name);
    }
    system.debug(listAccountName);
    
    for(Account a : trigger.new){
        if(listAccountName.contains(a.Name)){
            a.addError('Duplicate name found');
        }
    }
    

}