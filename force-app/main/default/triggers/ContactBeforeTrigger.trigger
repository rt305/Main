trigger ContactBeforeTrigger on Contact (before insert) {
    for(Contact c : Trigger.new){
        c.Title = 'Admin';
    }

}