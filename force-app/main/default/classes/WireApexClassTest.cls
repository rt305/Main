@isTest
public class WireApexClassTest {
    
 @testSetup static void setup() {
        // Create common test accounts
        List<Account> testAccts = new List<Account>();
        for(Integer i=0;i<2;i++) {
            testAccts.add(new Account(Name = 'TestAcct'+i));
        }
        insert testAccts;
    }
  
	@isTest 
    public static void myMethod(){
        Account a =[select id from account limit  1];
        test.startTest();
        WireApexClass.myMethod(a.id);
        test.stopTest();
        
    }
}