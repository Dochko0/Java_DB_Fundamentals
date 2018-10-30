package c_SayHelloExtend;

public interface Person {
    String getName();
    default void sayHello(){
        System.out.println("ZDR");
    };

}
