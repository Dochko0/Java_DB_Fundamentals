package secondExercise.Repositories;

import secondExercise.Employee;
import secondExercise.Repositories.base.DataRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public abstract class JdbcDataRepository<T> implements DataRepository<T> {

    private final Connection connection;

    public JdbcDataRepository(Connection connection){
        this.connection = connection;
    }


    @Override
    public List<T> getAll() throws SQLException {
        String queryString = "SELECT * FROM " + this.getTableName();
        PreparedStatement query = connection.prepareStatement(queryString);

        ResultSet resultSet = query.executeQuery();
        //List<T> list = toList(resultSet);
        return  toList(resultSet);
    }

    @Override
    public void insert(T object) {

    }

    private List<T> toList(ResultSet resultSet) throws SQLException {
        List<T> list = new ArrayList<>();
        while (resultSet.next()){
            T object = this.parseRow(resultSet);

            list.add(object);
        }
        return list;
    }


    protected abstract T parseRow(ResultSet resultSet) throws SQLException;


    protected abstract String getTableName();





}
