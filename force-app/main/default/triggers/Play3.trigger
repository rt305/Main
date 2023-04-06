trigger Play3 on Contact (before insert, before update) {
    
    for(Contact con : trigger.new){
        if(con.Phone == null || con.Email == null){
            con.addError('Email and Phone fields , both are mendatory');
        }
    }

}