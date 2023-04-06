trigger Player2 on Account (after insert) {
    
    List<Contact> cList = new List<Contact>();
    
    for(Account acc : trigger.new){
        Contact con = new Contact();
        con.LastName = acc.Name;
        con.AccountId = acc.Id;
        
        cList.add(con);
    }
    Insert cList;

}