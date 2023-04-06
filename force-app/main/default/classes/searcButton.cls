public class searcButton {
    @AuraEnabled(cacheable=true)
    public static List<Lead> getAccountLst(string customer){
        Set<Id> accIds = new Set<Id>();
        for(Account acc: [SELECT Id, Customer_Id__c FROM Account WHERE Customer_Id__c =: customer]){
            accIds.add(acc.Id);
        }
        
        List<Lead> leadlist =  [SELECT Id, Name, Company, Phone, Status, Title FROM Lead WHERE Custumer__c IN : accIds];
        for(Lead leadobj : leadlist){
            leadobj.Title = '/'+leadobj.Id;
        }
        if(leadlist.isEmpty()){
            throw new AuraHandledException('List is empty');
        }
        else{
            return leadlist;
        } 
    }
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getLeadList(string pan){
        List<Opportunity> objLead =[SELECT ID, Pan_Number__c FROM Opportunity WHERE Pan_Number__c =: pan];
        if(objLead.isEmpty()){
            throw new AuraHandledException('List is empty');
        }
        else{
            return objLead;  
        } 
    }}