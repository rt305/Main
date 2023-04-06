trigger parentAccCon on Account (after insert) {
    for(Account acc : trigger.new){
        list<Contact> conList = new list<Contact>();
        if(acc.Email__c != Null){
            Contact con = new Contact();
            con.AccountId = acc.Id;
            con.lastName = acc.Name;
            con.EmailCheckbox__c = True;
            conList.add(con);
        }
        Insert conList;
        
    }
    

}