public class apex1Copy {
    public static void myMethod(){
        List<Lead> lLead = new List<Lead>();
        Set<Id> aList = new Set<Id>();
        List<Account> listAcc = [SELECT Id, Customer_Id__c From Account];
        For(Account a : listAcc){
            aList.add(a.Id);
            List<Lead> leadList = [SELECT Id, Customer_Id__c, Custumer__c From Lead where Custumer__c IN : aList];
            For(Lead l : leadList){
                l.Customer_Id__c = a.Customer_Id__c;
                l.Custumer__c = a.Id;
                lLead.add(l);
            }
        }
        update lLead;
        system.debug(lLead);
    }
    
}