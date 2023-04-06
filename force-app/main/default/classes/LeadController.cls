public class LeadController {
    @AuraEnabled(cacheable=true)
    public static Lead getLeadList(String recordId) {
        
        Lead listLead = [SELECT Id, Is_pan_verified__c From Lead Where Id =: recordId];
        
                return listLead;
            }
        }