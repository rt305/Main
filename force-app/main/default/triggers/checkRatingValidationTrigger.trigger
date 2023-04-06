trigger checkRatingValidationTrigger on Account (before insert) {
    for(Account a : trigger.new){
        a.Rating = 'Warm';
    }

}