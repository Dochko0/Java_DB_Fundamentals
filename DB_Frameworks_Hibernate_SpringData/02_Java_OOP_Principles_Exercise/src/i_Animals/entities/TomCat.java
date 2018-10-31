package i_Animals.entities;

public class TomCat extends Cat {


    public TomCat(String name, int age, String gender) {
        super(name, age, gender);
    }

    @Override
    public String produceSound() {
        return "Give me one million b***h";
    }
}
