package secondExercise;

public class Employee {
    private long employee_id;
    private String firstName;
    private String lastName;

    public Employee(){

    }


    public Employee(String firstName, String lastName) {
       this(0, firstName, lastName);
    }

    public Employee(long employee_id, String firstName, String lastName) {
        setId(employee_id);
        setFirstName(firstName);
        setLastName(lastName);
    }


    public long getId() {
        return employee_id;
    }

    public void setId(long employee_id) {
        this.employee_id = employee_id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
}
