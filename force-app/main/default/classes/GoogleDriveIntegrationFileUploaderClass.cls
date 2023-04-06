public class GoogleDriveIntegrationFileUploaderClass {
    
    @AuraEnabled
    public static string uploadFile(String base64, string filename, string recordId){
        ContentVersion cv = createContentVersion(base64 , filename);
        ContentDocumentLink cdl = createContentLink(cv.Id, recordId);
        if(cv == null || cdl == null){
            return null;
        }
        return cdl.Id;
    } 
    private static ContentVersion createContentVersion(string base64, string filename){
        ContentVersion cv = new ContentVersion();
        cv.VersionData = EncodingUtil.base64Decode(base64);
        cv.Title = filename;
        cv.PathOnClient = filename;
        try{
            insert cv;
            return cv;
        } catch(DMLException e){
            System.debug(e);
            return null;
        }
    }
    
    private static ContentDocumentLink createContentLink(string ContentVersionId, String recordId){
        if(ContentVersionId == null || recordId == null){
            return null;
        }
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = [Select ContentDocumentId From ContentVersion Where Id =: contentVersionId].ContentDocumentId;
        cdl.LinkedEntityId = recordId;
        cdl.ShareType = 'V';
         try{
            insert cdl;
            return cdl;
        } catch(DMLException e){
            System.debug(e);
            return null;
        }
    }

}