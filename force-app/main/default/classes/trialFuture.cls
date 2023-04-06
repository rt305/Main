public class trialFuture {
    
    public static void myMethod(){
        myMethod1();
        myMethod2();
        myMethod3();
    }
    
    public static void myMethod1(){
        system.debug('I am Future Method1');
    }
    @Future
    public static void myMethod2(){
        system.debug('I am Future Method2');
    }
    public static void myMethod3(){
        system.debug('I am Future Method3');
    }

}