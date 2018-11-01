package secondExercise;

import secondExercise.Repositories.EmployeesDataRepository;
import secondExercise.Repositories.JdbcDataRepository;
import secondExercise.Repositories.base.DataRepository;

import java.sql.*;

public class Main {

    public static void main(String[] args) throws SQLException {
        String connectionString = "jdbc:mysql://localhost:3306/soft_uni";

        Connection connection = DriverManager.getConnection(connectionString, "root", "1234");

        DataRepository<Employee> repository = new EmployeesDataRepository(connection);
        repository.getAll()
                .stream()
                .map(Employee::getFirstName)
                .forEach(System.out::println);


        //connection.close();
    }
}

