trigger AjayTrig1 on Account (after Insert) {
    
    List<Contact> listCont = new List<Contact>();
    
    for(Account a : Trigger.new){
        
        Contact c = new Contact();
        c.LastName = a.Name;
        c.AccountId = a.Id;
        listCont.add(c);
        
         Contact c1 = new Contact();
        c.LastName = a.Name;
        c.AccountId = a.Id;
        listCont.add(c1);
        
    }
    Insert listCont;
}