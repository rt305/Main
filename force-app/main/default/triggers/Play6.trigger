trigger Play6 on Account (before delete) {
    for(Account acc : trigger.old){
        if(acc.ActiveAccount__c == true){
            acc.addError('You can not delete');
        }       
    }
}