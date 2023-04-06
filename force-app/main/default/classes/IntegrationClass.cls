public with sharing class IntegrationClass {
    public static String getVerification(){
        
        Custom_Integration_Endpoint__mdt mcs = Custom_Integration_Endpoint__mdt.getInstance('Integrartion_Endpoint_URL');
        string s = mcs.Endpoint_URL_Custom_Metadata__c;
        system.debug('@@@@' + s);
        string c = mcs.Client_Id__c;
        system.debug('$$$$' + c);
        string l = mcs.Client_Secret__c;
        system.debug('&&&&' + l);
        String t = mcs.Security_Token__c;
        system.debug('####' + t);
        String url1 = 'https://mycompany57-dev-ed.develop.my.salesforce.com/services/oauth2/token?grant_type=password&client_id='+ c +'&client_secret='+ l +'&username=my@rohit.com&password=radha@12345NaHWYEP7smfLCefXNfc7InIu';
        system.debug(url1);
            
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String accessToken;
        request.setEndpoint(url1);
        request.setMethod('POST');
        
        HttpResponse response = http.send(request);
        System.debug('Responce code'+ response.getStatusCode());
        if(response.getStatusCode() == 200) {
            System.debug('Responce code'+ response.getStatusCode());
            System.debug(response.getBody());
            Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            system.debug(m);
            String InstanceURL = String.valueOf(m.get('instance_url'));
            system.debug(InstanceURL);
            accessToken = String.valueOf(m.get('access_token'));
            system.debug(accessToken);
           
            //accessToken = UserInfo.getOrganizationId()+''+UserInfo.getSessionId().SubString(15);
            //system.debug(accessToken);
        }
        return accessToken;
    }
}