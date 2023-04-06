public class ConvertToLoanApplication {
    
     @AuraEnabled
    public static Lead panAdharDedupeValues(String recordId){
        Lead l = [SELECT Id,Is_Pan_Verified__c, Is_Adhar_Verified__c, Dedupe_Check__c from Lead where Id =: recordId];
        system.debug(l);
		return l;
	    }
    
     @AuraEnabled
    public static String createLoanApplication(String leadRecordId){
       
            Lead leadObject = [SELECT Id, Name, Email, Phone, status from Lead where Id = : leadRecordId ];
        
            Opportunity oppObject = new Opportunity();
            oppObject.Name = leadObject.Name;
            oppObject.lead__c = leadRecordId;
            oppObject.stagename = 'Sales';
            oppObject.closedate = system.today();
            insert oppObject;
        
           Account accObject = new Account();
           accObject.Name = leadObject.name;
           insert accObject;

           leadObject.Custumer__c = accObject.Id;
           leadObject.status = 'Closed - Converted';
           update leadObject;
           oppObject.AccountId = accObject.Id;
           update oppObject;
          
          
           return oppObject.Id;

        }
      
    }