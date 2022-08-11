package jsp_project;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
public class DataHandler {
 private Connection conn;
 // Azure SQL connection credentials
 final static String HOSTNAME = " ";
 final static String DBNAME = " ";
 final static String USERNAME = " ";
 final static String PASSWORD = "";
 
 // Resulting connection string
 final private String url =
String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;",
		HOSTNAME, DBNAME, USERNAME, PASSWORD);
 
 
 private void getDBConnection() throws SQLException {
	 if (conn != null) {
		 return;
	 }
	 this.conn = DriverManager.getConnection(url);
 }
 
//----------------------------------------------------------------------------
// Establish a database connection, create sql query to insert customer  

 public boolean addCustomer(
 String name, String address, Integer category) throws SQLException {
 getDBConnection(); 
 final String sqlQuery =
 "INSERT INTO customer " +
 "(name, address , category) " +
 "VALUES " +
 "(?, ?, ?)";
 final PreparedStatement statement = conn.prepareStatement(sqlQuery);

 statement.setString(1, name);
 statement.setString(2, address);
 statement.setInt(3, category);
 return statement.executeUpdate() == 1;
 }
 
//----------------------------------------------------------------------------
// Establish a database connection and get customers 
 public ResultSet getCustomers(Integer start, Integer end) throws SQLException {
 getDBConnection();
 final PreparedStatement statement = conn.prepareStatement("SELECT * FROM customer where category >= ? AND category <= ? ORDER BY name ;");
 statement.setInt(1, start);
 statement.setInt(2, end);
 ResultSet result = statement.executeQuery();
 return result ;
 }
}
