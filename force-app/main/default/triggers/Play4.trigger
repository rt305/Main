trigger Play4 on Account (before insert, before update) {
    
    for(Account acc : trigger.new){
        if(acc.Industry == 'banking'){
            acc.AnnualRevenue = 5000;
        } else If( acc.Industry == 'Finance'){
           acc.AnnualRevenue = 4000;
        } else {
            acc.AnnualRevenue = 1000;
        }
    }

}