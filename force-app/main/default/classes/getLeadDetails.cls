public class getLeadDetails{
    @AuraEnabled(cacheable=true)
    public static List<Lead> LeadList(string customer){
        Set<Id> listOfIDs = new Set<Id>();
        for(Account acc: [SELECT ID, Customer_Id__c FROM Account WHERE Customer_Id__c =: customer]){
            listOfIDs.add(acc.ID);
            
        }
        
        list<Lead> listLead =  [SELECT Id, Name,Company,Phone,Status,Title FROM Lead WHERE Custumer__c IN :listOfIDs];
        for(Lead obLead : listLead){
            obLead.Title =  '/'+obLead.Id;
            
        }
        return listLead;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getLeadDetails(string pan){
        Set<Id> listIDs = new Set<Id>();
        List<Lead> table = [select Id From lead where PAN__c =: pan];
        for(lead Objlead :table ){
            listIDs.add(Objlead.Id);
        }
        return[select Id, Name, Amount, StageName, CloseDate from Opportunity where Lead__c IN  : listIDs];        
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getLeadDetails1(string customer){
        Set<Id> listOFIDs = new Set<Id>();
        List<Account> table1 = [select Id From Account where Customer_ID__c =: customer];
        for(Account ObjAcc :table1 ){
            listOFIDs.add(ObjAcc.Id);
        }
        return[select Id, Name, Amount, StageName, CloseDate from Opportunity where AccountId IN : listOFIDs];        
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Lead> leadDetails(string pan){
        List<Lead> ObLead1 = [select Id,Name,Company,Phone,Status, Title From lead where PAN__c =: pan];
        for(Lead obLd : ObLead1){
            obLd.Title =  '/'+obLd.Id;
            
        }
        return ObLead1;
        
    }
    
    
}