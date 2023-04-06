public class customerSearchClass {
    @AuraEnabled(cacheable=true)
    public static List<Lead> accList(string existingCustomerId){
        List<Lead> acc = [Select Id, Customer_ID__c From Lead Where Customer_ID__c =: existingCustomerId];
        return acc;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> panList(string existingPan){
        List<Opportunity> pcc = [Select Id, PAN_Number__c From Opportunity Where PAN_Number__c =: existingPan];
        return pcc;
    }
    @AuraEnabled(cacheable=true)
    public static List<Lead> LeadList(string customer){
        Set<Id> idSet = new Set<Id>();
        List<Lead> leadList = [SELECT Id, Customer_ID__c, Company FROM Lead WHERE Customer_ID__c =: customer];
        for(Lead l : leadList){
            idSet.add(l.Id);
        }
        List<Lead> listLead =  [SELECT Id, Name, Company, Phone, Status, Title FROM Lead WHERE Custumer__c IN : idSet];
        for(Lead obLead : listLead){
            obLead.Title =  '/'+obLead.Id;
            
        }
        return listLead;
    }
}