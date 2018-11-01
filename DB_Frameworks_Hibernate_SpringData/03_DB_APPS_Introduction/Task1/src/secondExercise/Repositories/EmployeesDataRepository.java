package secondExercise.Repositories;

import secondExercise.Employee;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EmployeesDataRepository extends JdbcDataRepository<Employee> {
    public EmployeesDataRepository(Connection connection) {
        super(connection);
    }

    @Override
    protected Employee parseRow(ResultSet resultSet) throws SQLException {
        long id = resultSet.getLong("employee_id");
        String firstName = resultSet.getString("first_name");
        String lastName =resultSet.getString("last_name");
        return new Employee(id,firstName,lastName);
    }

    @Override
    protected String getTableName() {
        return "employees";
    }


}
