public class RectangleWithConstructor {
    
     Decimal length, breadth;
    Public RectangleWithConstructor(Decimal l , Decimal b){
         length = l;
         breadth = b;
    }
    
     Public void area(){
        Decimal area = length * breadth;
        system.debug('Total area is: '+area);
        
    }
    
    Public void Perimeter(){
        Decimal peri;
        peri = 2* (length + breadth);
        system.debug('$$ '+peri);
        
    }
    
    public static void formula(){
        Decimal principle = 5000.50;
        Integer rate = 5;
        Integer t = 2;
        
        Decimal SI = (principle * rate * t)/100;
        
        system.debug(SI);
    }

}