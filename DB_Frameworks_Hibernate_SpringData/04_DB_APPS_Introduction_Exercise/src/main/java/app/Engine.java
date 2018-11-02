package app;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

//make Statement
public class Engine implements  Runnable{

    private Connection connection;
    private BufferedReader reader;

    public Engine(Connection connection) {
        this.connection = connection;
    }

    public void run() {
        try {
            this.getVillainsNames();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    /**
     * Problem 2. GetVillainsNames
     */
    private void getVillainsNames() throws SQLException {
        String query ="SELECT v.name, count(v2.minion_id) from villains v JOIN minions_villains v2 on v.id = v2.villain_id group by v.name HAVING count(v2.minion_id)> ? order by count(v2.minion_id) desc";
        PreparedStatement preparedStatement = this.connection.prepareStatement(query);
        preparedStatement.setInt(1, 10);
        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            System.out.println(String.format("%s %d", resultSet.getString(1), resultSet.getInt(2)));
        }
    }

    /**
     * Problem 3. GetМinionсNames
     */
    private void getMinionNames() throws IOException, SQLException {
        int requiredVillainId = Integer.parseInt(this.reader.readLine());

        String query = String.format("" +
                        "SELECT DISTINCT(m.name) AS mname, m.age, v.name AS vname " +
                        "FROM minions_db.villains AS v " +
                        "LEFT JOIN minions_db.minions_villains AS mv ON v.id = mv.villain_id " +
                        "LEFT JOIN minions_db.minions AS m ON mv.minion_id = m.id " +
                        "WHERE v.id = %d"
                , requiredVillainId);

        PreparedStatement preparedStatement = this.connection.prepareStatement(query);

        ResultSet resultSet = preparedStatement.executeQuery();

        if (!resultSet.next()) {
            System.out.println(String.format("No villain with ID %d exists in the database.", requiredVillainId));
            return;
        }

        StringBuilder sb = new StringBuilder();

        int counter = 1;

        sb
                .append("Villain: ")
                .append(resultSet.getString("vname"))
                .append(System.lineSeparator())
                .append(counter).append(". ");

        if (resultSet.getString("mname") == null) {
            sb.append("<no minions>");
            System.out.println(sb);
            return;
        }

        sb
                .append(resultSet.getString("mname")).append(" ")
                .append(resultSet.getInt("age"))
                .append(System.lineSeparator());

        while (resultSet.next()) {
            counter++;

            sb
                    .append(counter).append(". ")
                    .append(resultSet.getString("mname")).append(" ")
                    .append(resultSet.getInt("age"))
                    .append(System.lineSeparator());
        }

        System.out.println(sb);
    }

    /**
     * Problem 4. AddMinion
     */
    private void addMinion() throws IOException, SQLException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

        String[] minionParams = reader.readLine().split("\\s+");
        String[] villainParams = reader.readLine().split("\\s+");

        String minionName = minionParams[1];
        int minionAge = Integer.parseInt(minionParams[2]);
        String townName = minionParams[3];

        String villainName = villainParams[1];

        if (!this.checkIfEntityExists(townName, "towns")) {
            this.insertTown(townName);
            System.out.println(String.format("Town %s was added to the database.", townName));
        }

        if (!this.checkIfEntityExists(villainName, "villains")) {
            this.insertVillain(villainName);
            System.out.println(String.format("Villain %s was added to the database.", villainName));
        }

        int townId = this.getEntity(townName, "towns");

        this.insertMinion(minionName, minionAge, townId);

        int minionId = this.getEntity(minionName, "minions");
        int villainId = this.getEntity(villainName, "villains");

        this.hireMinion(minionId, villainId);

        System.out.println(String.format("Successfully added %s to be minion of %s"
                , minionName, villainName));
    }

    private boolean checkIfEntityExists(String name, String tableName) throws SQLException {
        String query = String.format("SELECT * FROM %s WHERE name = \'%s\'", tableName, name);
        PreparedStatement preparedStatement = this.connection.prepareStatement(query);

        ResultSet resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            return true;
        }
        return false;
    }

    private void insertTown(String townName) throws SQLException {
        String query = String.format("INSERT INTO towns(name, country) VALUES('%s', NULL)", townName);

        PreparedStatement preparedStatement = this.connection.prepareStatement(query);

        preparedStatement.execute();
    }

    private void insertVillain(String villainName) throws SQLException {
        String query = String.format("INSERT INTO villains(name, evilness_factor) VALUES('%s', 'evil')", villainName);

        PreparedStatement preparedStatement = this.connection.prepareStatement(query);

        preparedStatement.execute();
    }

    private int getEntity(String name, String tableName) throws SQLException {
        String query = String.format("SELECT id FROM %s WHERE name = '%s'"
                , tableName, name);

        PreparedStatement preparedStatement = this.connection.prepareStatement(query);

        ResultSet resultSet = preparedStatement.executeQuery();

        resultSet.next();
        return resultSet.getInt(1);
    }

    private void insertMinion(String minionName, int age, int townId) throws SQLException {
        String query = String.format("INSERT INTO minions(name, age, town_id) VALUES('%s', '%d', '%d')"
                , minionName, age, townId);

        PreparedStatement preparedStatement = this.connection.prepareStatement(query);

        preparedStatement.execute();
    }

    private void hireMinion(int minionId, int villainId) throws SQLException {
        String query = String.format("INSERT INTO minions_villains(minion_id, villain_id) VALUES(%d, %d)"
                , minionId, villainId);

        PreparedStatement preparedStatement = this.connection.prepareStatement(query);

        preparedStatement.execute();
    }

    /**
     * Problem 5 Change Town Names Casing
     */
    private void changeTownNamesCasing() throws IOException, SQLException {
        String country = reader.readLine();

        String query = String.format("UPDATE minions_db.towns AS t SET  t.name = UPPER (t.name) WHERE t.country = '%s'"
                , country);

        PreparedStatement preparedStatement = this.connection.prepareStatement(query);

        preparedStatement.execute();

        query = String.format("SELECT  * FROM minions_db.towns AS t where t.country = '%s'"
                , country);

        preparedStatement = this.connection.prepareStatement(query);

        ResultSet resultSet = preparedStatement.executeQuery();

        List<String> results = new ArrayList<>();

        while (resultSet.next()) {
            results.add(resultSet.getString("name"));
        }

        if (results.size() > 0) {
            System.out.println(results.size() + " town names were affected.");
            System.out.println(results);
        } else {
            System.out.println("No town names were affected.");
        }
    }

    /**
     * Problem 7 Print All Minion Names
     */
    private void printAllMinionNames() throws SQLException {
        String query = "SELECT name FROM minions_db.minions";

        PreparedStatement pr = this.connection.prepareStatement(query);

        ResultSet rs = pr.executeQuery();

        List<String> names = new ArrayList<>();

        while(rs.next()){
            names.add(rs.getString("name"));
        }

        for (int i = 1; i < names.size() / 2; i+=2) {
            String temp = names.get(i);
            names.set(i, names.get(names.size() - i));
            names.set(names.size() - i, temp);
        }

        StringBuilder sb = new StringBuilder();
        for (String name : names) {
            sb.append(name).append(System.lineSeparator());
        }
        System.out.println(sb);
    }

    /**
     * Problem 8 Increase Minions Age
     */
    private void increaseMinionsAge(){
        //TODO
    }
}
