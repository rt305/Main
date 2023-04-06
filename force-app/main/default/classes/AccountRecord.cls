public class AccountRecord{
    
    public static Id insertData(string name, string rating){
        Account acc = new Account();
        acc.Name = name;
        acc.Rating = rating;
        
        insert acc;
        
        return acc.Id;
    }
    public static void insertContact(){
        
        Id accId;
        accId = insertData('sgst4','Warm');
        
        Contact con = new Contact(lastName = 'lst111');
        con.accountId = accId;
        Insert con;
    }
    
}