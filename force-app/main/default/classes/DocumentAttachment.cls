public with sharing class DocumentAttachment {
    
    @AuraEnabled
    public static void savedd(List<Document_Detail__c> ddlst, String lid){
        System.debug('#i am from savedd');
        List<document_Master__c> objDMRecords = [select id,Name from document_Master__c];
        Id idGst;
        Id idItr;
        for(Document_Master__c objDM: objDMRecords){
            System.debug('#i am for condition 1');
            if(objDM.Name=='ITR'){
                idItr=objDM.id;
            }
            if(objDM.Name=='GST'){
                idGst=objDM.id;
            }
        }
        list<document_detail__c> listdd = new list<document_detail__c>();
        
        for(Document_Detail__c dd : ddlst){
            System.debug('#i am for condition 2');
            if(dd.Party__c!= null || dd.Document_Master__c!= null || dd.filename__c!= null){
                System.debug('#i am if condition 1');
                if(dd.id!= null){
                    System.debug('#i am if condition 2');
                    if(dd.file__c!= null){
                        System.debug('#i am if condition 3');
                        ContentVersion cv = createContentVersion(dd.file__c, dd.filename__c);
                        Id cdid = createContentLink(cv.Id, dd.id);
                        dd.cdid__c = cdid;
                    }
                    listdd.add(dd);
                }
                else{
                    System.debug('i am here');
                    Document_Detail__c doc = new Document_Detail__c();
                    doc.party__c = dd.party__c;
                    
                    doc.Document_Master__c = dd.Document_Master__c;
                    if(doc.Document_Master__c == idItr){
                        doc.file__c = dd.file__c;
                    }
                    if(doc.Document_Master__c == idGst ){
                        doc.file__c = dd.file__c;
                        system.debug('yes');
                    }
                    doc.filename__c = dd.filename__c;
                    doc.Lead__c = lid;
                    insert doc;
                    if(dd.file__c != null){
                        ContentVersion cv = createContentVersion(dd.file__c, dd.filename__c);
                        Id cdid = createContentLink(cv.Id, doc.id);
                        doc.cdid__c = cdid;
                        listdd.add(doc);
                    }
                }
            }
            else{
                throw new AuraHandledException('No Inputs');
            }
        }
        update listdd;
    }
    
    
    
    @AuraEnabled
    public static void saveddOfLoan(List<Document_Detail__c> ddlst, String loanid){
        List<document_Master__c> objDMRecords = [select Id,Name from document_Master__c];
        Id idGst;
        Id idItr;
        for(Document_Master__c objDM: objDMRecords){
            if(objDM.Name=='ITR'){
                idItr=objDM.id;
            }
            if(objDM.Name=='GST'){
                idGst=objDM.id;
            }
        }
        list<document_detail__c> listdd = new list<document_detail__c>();
        
        for(Document_Detail__c dd : ddlst){
            
            
            if(dd.Party__c!= null || dd.Document_Master__c!= null || dd.filename__c!= null){
                
                if(dd.id != null){
                    
                    if(dd.file__c != null){  
                        
                        ContentVersion cv = createContentVersion(dd.file__c, dd.filename__c);
                        Id cdid = createContentLink(cv.Id, dd.id);
                        dd.cdid__c = cdid;
                        
                    }
                    listdd.add(dd);
                    
                }
                else{
                    Document_Detail__c doc = new Document_Detail__c();
                    doc.party__c = dd.party__c;
                    
                    doc.Document_Master__c = dd.Document_Master__c;
                    if(doc.Document_Master__c == idItr){
                        doc.file__c = dd.file__c;
                        system.debug('yes');
                    }
                    if(doc.Document_Master__c == idGst ){
                        doc.file__c = dd.file__c;
                        system.debug('yes');
                    }
                    doc.filename__c = dd.filename__c;
                    doc.Loan_Application__c = loanid;
                    
                    try{
                        insert doc;
                    }catch(DmlException e){
                        String errorMsg = e.getMessage();
                        String pureErrorMsg = errorMsg.substringAfter('_EXCEPTION,');
                        pureErrorMsg = pureErrorMsg.Substring(0, (pureErrorMsg.length()-4));
                        throw new AuraHandledException(pureErrorMsg);
                    }
                    
                    
                    
                    if(dd.file__c != null){
                        ContentVersion cv = createContentVersion(dd.file__c, dd.filename__c);
                        Id cdid = createContentLink(cv.Id, doc.id);
                        doc.cdid__c = cdid;
                        listdd.add(doc);
                        
                    }
                }
            }
            else{
                
                throw new AuraHandledException('No Inputs');
            }
            
        }
        
        
        try{
            update listdd;
        }catch(DmlException e){
            String errorMsg = e.getMessage();
            String pureErrorMsg = errorMsg.substringAfter('_EXCEPTION,');
            pureErrorMsg = pureErrorMsg.Substring(0, (pureErrorMsg.length()-4));
            throw new AuraHandledException(pureErrorMsg);
        }
    }
    
    private static ContentVersion createContentVersion(String base64, String filename) {
        ContentVersion cv = new ContentVersion();
        cv.VersionData = EncodingUtil.base64Decode(base64);
        cv.Title = filename;
        cv.PathOnClient = filename;
        try {
            insert cv;
            return cv;
        } catch(DMLException e) {
            System.debug(e);
            return null;
        }
    }
    
    private static Id createContentLink(String contentVersionId, String recordId) {
        if (contentVersionId == null || recordId == null) { return null; }
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = [
            SELECT ContentDocumentId 
            FROM ContentVersion 
            WHERE Id =: contentVersionId
        ].ContentDocumentId;
        cdl.LinkedEntityId = recordId;
        // ShareType is either 'V', 'C', or 'I'
        // V = Viewer, C = Collaborator, I = Inferred
        cdl.ShareType = 'V';
        try {
            insert cdl;
            return cdl.ContentDocumentId;
        } catch(DMLException e) {
            System.debug(e);
            return null;
        }
    }
    
    @AuraEnabled
    public static List<Document_Detail__c> getExistingRecords(String recordId){
        List<Document_Detail__c> recordList=[SELECT id, Party__c, Document_Master__c, filename__c, cdid__c From Document_Detail__c WHERE Lead__c=:recordId];
        if(!recordlist.isempty()){
            system.debug('#recordId'+recordList);
            return recordList;
        }
        else{
            throw new AuraHandledException('addRow');
        }
    }
    
    @AuraEnabled
    public static List<Document_Detail__c> getExistingRecordsForLoan(String recordId){
        List<Document_Detail__c> recordList=[SELECT id, Party__c, Document_Master__c, filename__c, cdid__c From Document_Detail__c WHERE Loan_Application__c=:recordId];
        if(!recordlist.isempty()){
            system.debug(recordList);
            return recordList;
        }
        else{
            throw new AuraHandledException('addRow');
        }
    }
    
    @AuraEnabled
    public static void deletedd(String ddid, STRING cdid){
        if(cdid != null){
            contentdocument cd = [select id from contentdocument where id =: cdid];
            system.debug(cd);
            delete cd;
        }
        if(ddid != null){
            document_detail__c dd = [select id from document_detail__c where id =: ddid];
            system.debug(dd);
            delete dd;
        }
    }
    
    @AuraEnabled
    public static boolean getIsPrimaryParty(String recordId){
        return ([select Id, Is_Primary_Party__c from Party__c where Id=:recordId].Is_Primary_Party__c);
    }
    
    @AuraEnabled
    public static String getDocMasterName(String recordId){
        return ([select Id, Name from Document_Master__c where Id=:recordId].Name);
    }
    
    
    
}