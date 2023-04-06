public with sharing class LWCAccountsController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccount(String searchText){
        try {
            if(String.IsEmpty(searchText)){
                return [Select Id, Name From Account ORDER BY createdDate Desc];
            }
            else{
                searchText = '%'+ searchText + '%';
                return [Select Id, Name From Account where Name LIKE : searchText];
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}