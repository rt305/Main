trigger validationEmailTrigger on Dairy_Owner__c (after insert) {
    List<Dairy_Customer__c> listOfDairyCustomer = new List<Dairy_Customer__c>();
    for(Dairy_Owner__c dairyOwner : trigger.new){
        Dairy_Customer__c dairyCustomer = new Dairy_Customer__c();
        dairyCustomer.Customer_Name__c = 'TriggerTest1';
        dairyCustomer.Customer_Phone__c = '9696857485';
        listOfDairyCustomer.add(dairyCustomer);
    }
        insert listOfDairyCustomer;

}