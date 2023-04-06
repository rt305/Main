trigger priyanshuNoteTrigger on ContentVersion (after insert) {
    if(trigger.isAfter && trigger.isInsert){
        priyanshuNoteTriggerHandler.throwErrorMethod(trigger.new);
    }

}