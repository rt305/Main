public class Ccccc {
public static void myMethod(){
    List<Contact> coLi = [Select Id, EmailCheckbox__c From Contact where EmailCheckbox__c = True ];
    system.debug('Result is: '+coLi);
    system.debug(coLi);
}
}