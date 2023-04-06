public class apexClassT{
     public static void myMethod(){
      /*  String a = 'Rohit';
        List<String> listString = new List<String>{'Mohit', 'Sohit', a};
            listString.add('abc');
            system.debug(listString);
       // System.assertEquals(4, listString.size());
        System.assertEquals('Mohit', listString[0]);*/
         List<Profile> pList = new List<Profile>([Select Name From Profile]);
         system.debug(pList);
         
          List<Profile> lList = [Select Name From Profile];
         system.debug(lList);
    }
}