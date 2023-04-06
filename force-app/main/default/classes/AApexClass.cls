public class AApexClass {
    public static string myMethod(){
        Custom_Integration_Endpoint__mdt customInt = [SELECT Endpoint_URL_Custom_Metadata__c from Custom_Integration_Endpoint__mdt];
        String endpointUrl = customInt.Endpoint_URL_Custom_Metadata__c;
        system.debug(endpointUrl);
        return endpointUrl;
    }
   
}