package i_Animals.entities;

import i_Animals.entities.Saundable;

public abstract class Animal  implements Saundable {

    private String name;
    private int age;
    private String gender;

    public Animal(String name, int age, String gender) {
        this.setName(name);
        this.setAge(age);
        this.setGender(gender);
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        if (name==null || name.equals("")){
            throw new IllegalArgumentException("Invalid input!");
        }
        this.name=name;
    }

    public int getAge() {
        return this.age;
    }

    public void setAge(int age) {
        if (age<1){
            throw new IllegalArgumentException("Invalid input!");
        }
        this.age = age;
    }

    public String getGender() {
        return this.gender;
    }

    public void setGender(String gender) {
        if(!gender.equals("Male") && !gender.equals("Female")){
            throw new IllegalArgumentException("Invalid input!");
        }

        this.gender=gender;
    }

    public String produceSound(){
        return "Not implemented!";
    }

    @Override
    public String toString() {
        return String.format("%s%n%s %d %s",
                this.getClass().getSimpleName(),
                this.getName() ,
                this.getAge() ,
                this.getGender());
    }
}
