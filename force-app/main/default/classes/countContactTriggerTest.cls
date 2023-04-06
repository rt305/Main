@isTest
public class countContactTriggerTest {
@isTest
    public static void myMethod(){
        Contact con = new Contact();
        con.LastName = 'TestLastName';
        Test.startTest();
        insert con;
        Test.stopTest();
    }
    @isTest
    public static void myMethod1(){
        Account a = new Account();
        a.Name = 'IRONMAN';
        insert a;
        
        Contact co = new Contact(); 
        co.LastName = 'ABC';
        co.AccountId = a.Id;
        insert co;
        
        Contact con = [Select Id, LastName From Contact Where LastName = 'ABC'];
        con.LastName = 'New Name';
        update con;
}
}