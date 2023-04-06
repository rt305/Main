public class priyanshuNoteTriggerHandler {
    public static void throwErrorMethod(list<ContentVersion> conVersion){
            Set<ContentVersion> conDoc = new Set<ContentVersion>();
            Set<Id> setContentDocumentId = new Set<Id>();
        
            for(ContentVersion cv : conVersion){
                if(cv.FileType == 'SNOTE'){
                    conDoc.add(cv);
                    setContentDocumentId.add(cv.ContentDocumentId);
                }
            }
        if(!conDoc.isEmpty()){
            
      List<ContentVersion> ContentDocumentIdvsLinkedEntityId = [Select id, ContentDocumentId from ContentVersion where Id IN :setContentDocumentId];
            Set<String> linkEntityIds = new Set<String>();
            for(ContentVersion cv1 : ContentDocumentIdvsLinkedEntityId){
                linkEntityIds.add(cv1.ContentDocumentId);
            }
            List<Opportunity> opp = [SELECT Id, StageName FROM Opportunity Where Id =: linkEntityIds];
            for(Opportunity o : opp){
                If(o.StageName == 'Closed Won' ){
                   throw new dmlException('You can not create Note');
                }
            }
        }
    }
}