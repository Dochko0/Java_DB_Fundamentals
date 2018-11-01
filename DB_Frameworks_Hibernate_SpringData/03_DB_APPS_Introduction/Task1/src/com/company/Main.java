package com.company;

import java.sql.*;

public class Main {

    public static void main(String[] args) throws SQLException {
        String connectionString = "jdbc:mysql://localhost:3306/soft_uni" ;

        Connection connection = DriverManager.getConnection(connectionString, "root", "1234");

        PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM  employees WHERE salary > ?" +
                "order BY first_name");

        preparedStatement.setDouble(1, 50000);

        ResultSet resultSet = preparedStatement.executeQuery();
        while (resultSet.next()){
            System.out.println(resultSet.getString("first_name"));
        }
    }
}
