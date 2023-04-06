public class CloneFunction {
    
    @AuraEnabled
    public static string myMethod(string recId){
        lead newlead = [select fields(standard),Adhar_Card_Number__c,Custumer__c, Dedupe_Check__c,Is_Adhar_Verified__c, Is_pan_verified__c,
                        Pan_Number__c,Primary__c from lead where id =:recId];
        lead ld = new lead();
        ld = newlead.clone();
        ld.Clone_Leads__c = recId;
        insert ld;
        string iid = ld.id;
        return iid;
    }
    
    @AuraEnabled(cacheable=true)
    public static list<Party__c> getPartyRecords(String iDi){
        list<Party__c> listParty = [SELECT Name, PAN_ID__c From Party__c Where Lead__c =: iDi];
        return listParty;
    }
    
    @AuraEnabled(cacheable=true)
    public static list<Document_Detail__c> getDocumentRecords(String iDi){
        list<Document_Detail__c> listDocument = [Select Name, filename__c From Document_Detail__c Where Lead__c =: iDi];
        return listDocument;
    }
    
    @AuraEnabled
    public static void cloneMethod(list<Party__c> PartyList, list<Document_Detail__c> DocumentList, String iDi){
       
             list<Party__c> cc = new list<Party__c>();
            for(Party__c Partylists : PartyList){
                Party__c P = [select fields(standard), Aadhaar__c, Date_of_Birth__c, Email_ID__c, Last_Name__c, PAN_ID__c, Phone__c, Type__c from party__c where id = :Partylists.id];
                Party__c pp = new party__C();
                pp = P.clone();
                pp.Lead__c = iDi;
                cc.add(pp);
            }
            insert cc; 
        
       
            list<Document_Detail__c> c = new list<Document_Detail__c>();
            for(Document_Detail__c Doclist : DocumentList){
                Document_Detail__c DocLi = [select fields(standard), Document_Master__c, Account__c from Document_Detail__c where id = :Doclist.id];
                Document_Detail__c dd = new Document_Detail__c();
                dd = DocLi.clone();
                dd.lead__C = iDi;
                c.add(dd);
            }
            insert c;
    }
}