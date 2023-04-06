public class VerifyAccountsRecord {
    public static Boolean getAccountsFromOrgB(){
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://rohittiwaribhopalorgcom-dev-ed.my.salesforce.com/services/apexrest/account');
        req.setMethod('GET');
        req.setHeader('Authorization','Bearer !AQoAQCIEvjeShfTSHGwXyJJ5zGuWeOgqT01y8ERBYKrBlG6ZlfIg1dY4ZNLzHnNYpT_AE450IxKSyWqzxPBTPYyQKwDN6ny1');
        
        HttpResponse res = http.send(req);
        Boolean a = false;
        if(res.getStatusCode() == 200){
            
            system.debug('Its Present'+ res.getBody());
            a = Boolean.valueOf(res.getBody());
            system.debug('Its Present 2'+ a);
            return a;
           
        }
        else{
            system.debug('Response not received.');
            return a;
        }
        
    }
    
}