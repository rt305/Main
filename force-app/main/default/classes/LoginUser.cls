global class LoginUser {
    @AuraEnabled
    global static string login(string userName, string password){
        string homeURL = 'https://gagstek-2f-dev-ed.my.site.com/login/';
        ApexPages.PageReference PageRef = Site.login(userName, password, homeURL); 
        return PageRef.getUrl();   
    }
}