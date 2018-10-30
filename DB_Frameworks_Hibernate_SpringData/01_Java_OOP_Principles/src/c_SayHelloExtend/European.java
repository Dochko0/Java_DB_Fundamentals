package c_SayHelloExtend;

public class European extends BasePerson {

    public European(String name) {
        super(name);
    }

    @Override
    public void sayHello() {
        System.out.println("Hello!");
    }
}
