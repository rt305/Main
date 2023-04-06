public class ContactRecords {
  @AuraEnabled
    public static void myMethod(String m, String n, String o){
       Lead l = new Lead();
        l.lastName = m;
        l.company = n;
        l.Status = o;
        Insert l;
    }  
}