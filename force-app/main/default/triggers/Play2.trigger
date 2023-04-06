trigger Play2 on Contact (after insert) {
    
    List<Account> listAcc = new List<Account>();
    
    for(Contact con : trigger.new){
        Account acc = new Account();
        acc.Name = con.LastName;
        
        listAcc.add(acc);
        
    }
    Insert listAcc;
        

}