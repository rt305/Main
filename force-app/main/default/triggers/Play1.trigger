trigger Play1 on Account (before insert, before update) {
    
    if((trigger.isBefore) && (trigger.isInsert || trigger.isUpdate)){
    for(Account acc: Trigger.new){
        if(acc.Industry == 'Banking'){
            acc.Rating = 'Hot';
        }
    }
  }
}