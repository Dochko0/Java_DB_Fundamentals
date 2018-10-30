package c_SayHelloExtend;

public class Bulgarian extends BasePerson {
    public Bulgarian(String name){
        super(name);
    }


    @Override
    public void sayHello() {
        System.out.println("Maraba");
    }
}


