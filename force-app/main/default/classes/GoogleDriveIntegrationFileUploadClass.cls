public class GoogleDriveIntegrationFileUploadClass

{
    @AuraEnabled(cacheable=True)
    public static void uploadFilesWithAccessToken() 
    
    {
                                                                              // Retrieve the access token from a custom metadata field
      
        
                // Retrieve the file data for the record
        
        List<ContentDocumentLink> contentDocumentLinks = SalesforceFilesHelper.getContentDocumentLinks('0015g00001BRnf4AAD');
        
        Map<String, Blob> fileDataMap = SalesforceFilesHelper.getFileDataMap(contentDocumentLinks);
        
               // Construct the HTTP request
      
        
        String endpoint = 'https://www.googleapis.com/upload/drive/v3/files';
        
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + 'ya29.a0Ael9sCN-69MmgmTLPASvQ-pfCqPCMZLwR5XpsjFnfabU4mmgY32XQpLSRqpqIjmwr0h_gD2_C7viZHZeiqFADtD3LxeZU44TTsHh4GPJMXtN_nPGfDonaSTdetUJX9Rjl-kfIBzk21hEe-9J3QC_Qe26UW7wBwaCgYKAW8SARASFQF4udJhnBPo6QnN-zyh321B5R2EDg0165');
        req.setHeader('Content-Type', 'multipart/related; boundary=MyBoundaryString');
        
               
        
               // Construct the multipart request body
        
        
        String body = '';
        
        for (String fileName : fileDataMap.keySet())
         {
            
            String fileContentType = SalesforceFilesHelper.getContentType(fileName.substringAfterLast('.'));
           
            String fileContent = EncodingUtil.base64Encode(fileDataMap.get(fileName));
            
            body += '--MyBoundaryString\r\n';
            body += 'Content-Type: application/json; charset=UTF-8\r\n\r\n';
            body += '{ "name" : "' + fileName + '" }\r\n';
            body += '--MyBoundaryString\r\n';
            body += 'Content-Type: ' + fileContentType + '\r\n';
            body += 'Content-Transfer-Encoding: base64\r\n\r\n';
            body += fileContent + '\r\n';
        }
        
        
        body += '--MyBoundaryString--\r\n';
        
        req.setBody(body);
        
                                                                                                    // Send the HTTP request
       
         Http http = new Http();

         HttpResponse res = http.send(req);
        
                     
                                                                                                        // Check the response for errors
       
        if (res.getStatusCode() >= 200 && res.getStatusCode() <= 299)
        {
            System.debug('Files uploaded successfully');
        } else {
            System.debug('Error uploading files: ' + res.getBody());
               }
    }

}