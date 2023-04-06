trigger priyanshuTriggerTuesday on Account (after Update) {
        accountEmailUpdate.accountMethod(trigger.new); 
    }