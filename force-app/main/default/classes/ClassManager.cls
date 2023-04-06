public class ClassManager {
    static String url2='https://mycompany57-dev-ed.develop.my.salesforce.com/services/apexrest/panverify/';
    static String urlForAadhaar='https://mycompany57-dev-ed.develop.my.salesforce.com/services/apexrest/Aadhar/';
    static String urlForDedupeCheck='https://mycompany57-dev-ed.develop.my.salesforce.com/services/apexrest/Dedupe/';

@AuraEnabled
public static void getPanVerified(String panNumber, String recordId){
        String accessToken=IntegrationClass.getVerification();
        calloutToVerifyPan(panNumber,accessToken,recordId);
}
  
@AuraEnabled
public static void getAadhaarVerified(String aadhaarNumber, String recordId){
        String accessToken=IntegrationClass.getVerification();
        calloutToVerifyAadhaar(aadhaarNumber,accessToken,recordId);
}

@AuraEnabled
public static void getDedupeCheck(String customerId, String recordId){
        String accessToken=IntegrationClass.getVerification();
        calloutToDedupeCheck(customerId,accessToken,recordId);
}


public static HttpRequest httpRequestGenerator(String reqMethod, String endpoint, String accessToken) {
    String authorizationHeader = 'Bearer ' + accessToken;
    HttpRequest httpRequest = new HttpRequest();
    httpRequest.setMethod(reqMethod);
    httpRequest.setEndpoint(endpoint);
    httpRequest.setHeader('Authorization', authorizationHeader);
    httpRequest.setHeader('Content-Type', 'application/json;charset=UTF-8');
    return httpRequest;
}

public static void calloutToVerifyPan(String panNumber,String accessToken, String recordId){
    Http http = new Http();
    HttpRequest httpRequest = httpRequestGenerator('GET', url2 + panNumber, accessToken);
    HTTPResponse httpResponse = http.send(httpRequest);
    if(httpResponse.getBody()=='true'){
        updateIsPanVerifiedToTrue(recordId);
    }
    else {
        updateIsPanVerifiedToFalse(recordId);
    }
    
}


public static void calloutToVerifyAadhaar(String aadhaarNumber,String accessToken, String recordId){
    
    system.debug(urlForAadhaar + 'urlForAadhaar');
    
    //callout:SFDCB/services/apexrest/Aadhar/12345466
        
   // https://mycompany57-dev-ed.develop.my.salesforce.com/services/apexrest/Aadhar?aadhaarNumber=888822227777
    
    Http http = new Http();
    HttpRequest httpRequest = httpRequestGenerator('GET',urlForAadhaar + aadhaarNumber , accessToken);
    HTTPResponse httpResponse = http.send(httpRequest);
    
    system.debug('httpResponse.getBody() ->' + httpResponse.getBody());
    if(httpResponse.getBody()=='true'){
        updateIsAadhaarVerifiedToTrue(recordId);
    }
    else {
        updateIsAadhaarVerifiedToFalse(recordId);
    }
    
}


public static void calloutToDedupeCheck(String customerId,String accessToken, String recordId){
    Http http = new Http();
    HttpRequest httpRequest = httpRequestGenerator('GET',  urlForDedupeCheck + customerId, accessToken);
    HTTPResponse httpResponse = http.send(httpRequest);
    
    system.debug('httpResponse.getBody() ->' + httpResponse.getBody());
    if(httpResponse.getBody()=='true'){
        updateIsDedupeCheckToTrue(recordId);
    }
    else {
        updateIsDedupeCheckToFalse(recordId);
    }
    
}

public static void updateIsPanVerifiedToTrue(String recordId){
    Lead leadRecord = [SELECT id, Is_Pan_Verified__c from Lead where id=:recordId];
    leadRecord.Is_Pan_Verified__c='Yes';
    update leadRecord;
}

public static void updateIsPanVerifiedToFalse(String recordId){
    Lead leadRecord = [SELECT id, Is_Pan_Verified__c from Lead where id=:recordId];
    leadRecord.Is_Pan_Verified__c='No';
    update leadRecord;
}


public static void updateIsAadhaarVerifiedToTrue(String recordId){
    Lead leadRecord = [SELECT id, Is_Adhar_Verified__c from Lead where id=:recordId];
    leadRecord.Is_Adhar_Verified__c='Yes';
    update leadRecord;
}

public static void updateIsAadhaarVerifiedToFalse(String recordId){
    System.debug('Adhaar false');
    Lead leadRecord = [SELECT id, Is_Adhar_Verified__c from Lead where id=:recordId];
    leadRecord.Is_Adhar_Verified__c='No';
    update leadRecord;
}



public static void updateIsDedupeCheckToTrue(String recordId){
    Lead leadRecord = [SELECT id, Dedupe_Check__c from Lead where id=:recordId];
    leadRecord.Dedupe_Check__c='Yes';
    update leadRecord;
}

public static void updateIsDedupeCheckToFalse(String recordId){
    System.debug('Adhaar false');
    Lead leadRecord = [SELECT id, Dedupe_Check__c from Lead where id=:recordId];
    leadRecord.Dedupe_Check__c='No';
    update leadRecord;
}

@AuraEnabled
public static Lead getRefreshValues(String recordId){
    Lead leadRecord = [SELECT id, Is_Pan_Verified__c, Is_Adhar_Verified__c, Dedupe_Check__c from Lead where id=:recordId];
    return leadRecord;
}


}