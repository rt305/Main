public with sharing class LabelController {
    public static Void getLabel() {
        String s1 = 'Hello from Apex Controller, ' ;
        String s2 = System.Label.Monthly_Fee_For_Academic;
        String s3 = s1 + s2;
        system.debug(s3);
        
    }
}