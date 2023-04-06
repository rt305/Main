public class LeadandLoanDatatable{
    
    @AuraEnabled(cacheable=true)
    public static List<Lead> LeadList(string customer){
        Set<Id> accIds = new Set<Id>();
        for(Account acc: [SELECT ID, Customer_Id__c FROM Account WHERE Customer_Id__c =: customer]){
            accIds.add(acc.ID);
        }
        list<Lead> leadlist =  [SELECT Id, Name, Company, Phone, Status, Title FROM Lead WHERE Custumer__c IN : accIds];
        for(Lead leadobj : leadlist){
            leadobj.Title =  '/'+leadobj.Id;
        }
        return leadlist;
    }
    
   @AuraEnabled(cacheable=true)
    public static List<Opportunity> getLeadDetails(string pan){
        Set<Id> accIds = new Set<Id>();
        for(Opportunity opp: [SELECT ID, Pan_Number__c FROM Opportunity WHERE Pan_Number__c =: pan]){
            accIds.add(opp.ID);
        }
        list<Opportunity> listOpportunity = new list<Opportunity>();
        list<Opportunity> leadlist1 =  [SELECT Id, Name, Amount, StageName, closeDate FROM Opportunity WHERE Id IN : accIds];
        for(Opportunity leadobj : leadlist1){
            listOpportunity.add(leadobj);
        }
        return listOpportunity;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getLeadDetails1(string customer){
        Set<Id> accIds = new Set<Id>();
        List<Account> table1 = [select Id From Account where Customer_ID__c =: customer];
        for(Account ObjAcc :table1 ){
            accIds.add(ObjAcc.Id);
        }
        return[select Id, Name, Amount, StageName, CloseDate from Opportunity where AccountId IN : accIds];        
    }
    
    @AuraEnabled(cacheable=true)
    public static List<Lead> leadDetails(string pan){
        List<Lead> leadData = [select Id, Name, Company, Pan_Number__c, Phone, Status, Title From Lead where Pan_Number__c =: pan];
        for(Lead objlead : leadData){
            objlead.Title =  '/'+objlead.Id;
            
        }
        return leadData;    
    }}