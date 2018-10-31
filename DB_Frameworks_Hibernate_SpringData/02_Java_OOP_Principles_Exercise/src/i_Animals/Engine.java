package i_Animals;

import i_Animals.entities.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Engine implements Runnable {

    private Scanner scanner;

    public Engine(Scanner scanner) {
        this.scanner = scanner;
    }

    @Override
    public void run() {
        List<Saundable>animals = new ArrayList<>();


        while (true){
            String animalType = this.scanner.nextLine();

            if("Beast!".equals(animalType)){
                break;
            }
            else {
                String[] params = this.scanner.nextLine().split("\\s+");

                String name = params[0];
                int age = Integer.parseInt(params[1]);
                String gender = params[2];
                try {

                    switch (animalType) {
                        case "Dog":
                            Saundable dog = new Dog(name, age, gender);
                            animals.add(dog);
                            break;
                        case "Frog":
                            Saundable frog = new Frog(name, age, gender);
                            animals.add(frog);
                            break;
                        case "Cat":
                            Saundable cat = new Cat(name, age, gender);
                            animals.add(cat);
                            break;
                        case "Kitten":
                            Saundable kitten = new Kitten(name, age, "Female");
                            animals.add(kitten);
                            break;
                        case "Tomcat":
                            Saundable tomcat = new TomCat(name, age, "Male");
                            animals.add(tomcat);
                            break;
                        default:
                            throw new IllegalArgumentException("Invalid input!");

                    }
                }catch (IllegalArgumentException iae){
                    System.out.println(iae.getMessage());
                }
            }
        }
        for (Saundable animal : animals) {
            System.out.println(animal.toString());
            System.out.println(animal.produceSound());
        }
    }
}
