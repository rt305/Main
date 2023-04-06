public class getAccountsRecord {
    public static void getAccountsFromOrgB(){
        
         Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://rohittiwaribhopalorgcom-dev-ed.my.salesforce.com/services/apexrest/accounts');
        req.setMethod('GET');
        req.setHeader('Authorization','Bearer !AQoAQCIEvjeShfTSHGwXyJJ5zGuWeOgqT01y8ERBYKrBlG6ZlfIg1dY4ZNLzHnNYpT_AE450IxKSyWqzxPBTPYyQKwDN6ny1');
        
        HttpResponse res = http.send(req);
        
        if(res.getStatusCode() == 200 ){
        List<Object> results = (List<Object>)JSON.deserializeUntyped(res.getBody());
            for(Object result : results){
                Map<String, Object> accPro = (Map<String, Object>) result;
                system.debug(accPro);
            }
        }
        
    }

}