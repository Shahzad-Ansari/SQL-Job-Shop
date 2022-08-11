import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class Shahzad_Ansari_IP_Task5b {
 // Database credentials
	 final static String HOSTNAME = "";
	 final static String DBNAME = " ";
	 final static String USERNAME = " ";
	 final static String PASSWORD = " ";
 // Database connection string
	 final static String URL =
String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;",
		HOSTNAME, DBNAME, USERNAME, PASSWORD);
	 // User input prompt//
	 final static String PROMPT =
			 "\nPlease select one of the options below: \n" +
					 "1) Enter a new customer; \n" +
					 "2) Enter a new department; \n" +
					 "3) Enter a new process-id and its department together with its type and information relevant to the type; \n" +
					 "4) Enter a new assembly with its customer-name, assembly-details, assembly-id, and date-ordered and associate it with one or more processes; \n" +
					 "5) Create a new account and associate it with the process, assembly, or department to which it is \r\n"
					 + "applicable; \n" +
					 "6) Enter a new job, given its job-no, assembly-id, process-id, and date the job commenced ; \n" +
					 "7) At the completion of a job, enter the date it completed and the information relevant to the type \r\n"
					 + "of job; \n" +
					 "8) Enter a transaction-no and its sup-cost and update all the costs (details) of the affected \r\n"
					 + "accounts by adding sup-cost to their current values of details; \n" +
					 "9) Retrieve the total cost incurred on an assembly-id; \n" +
					 "10) Retrieve the total labor time within a department for jobs completed in the department during a \r\n"
					 + "given date; \n" +
					 "11) Retrieve the processes through which a given assembly-id has passed so far (in date-commenced order) and the department responsible for each process; \n" +
					 "12) Retrieve the jobs (together with their type information and assembly-id) completed during a \r\n"
					 + "given date in a given department; \n" +
					 "13) Retrieve the customers (in name order) whose category is in a given range; \n" +
					 "14) Delete all cut-jobs whose job-no is in a given range; \n" +
					 "15) Change the color of a given paint job; \n" +
					 "16) Import: enter new customers from a data file until the file is empty; \n" +
					 "17) Export customers in a range; \n" +
					 "18) Quit";

	 
	 public static void main(String[] args) throws SQLException {
		 final Scanner mainSC = new Scanner(System.in); 
		 String option = ""; 
		 while (!option.equals("18")) { 
			 System.out.println(PROMPT); 
			 option = mainSC.next(); 

			 // switch board mechanisim
			 switch (option) { 
			 	//========================================================================================================
			 	case "1": 	
			 		insertCustomer();
			 		break;
			 	
			 	case "2": 
			 		insertDept();
			 		break;
			 	
			 	case "3": 
			 		Q3();
			 		break;
			 	case "4":
			 		Q4();
			 		break;
			 	case "5":
			 		Q5();
			 		break;
			 	case "6":
			 		Q6();
			 		break;
			 	case "7":
			 		Q7();
			 		break;
			 	case "8":
			 		Q8();
			 		break;
			 	case "9":
			 		Q9();
			 		break;
			 	case "10":
			 		Q10();
			 		break;
			 	case "11":
			 		Q11();
			 		break;
			 	case "12":
			 		Q12();
			 		break;
			 	case "13":
			 		Q13();
			 		break;
			 	case "14":
			 		Q14();
			 		break;
			 	case "15":
			 		Q15();
			 		break;
			 	case "16":
			 		Q16();
			 		break;
			 	case "17":
			 		Q17();
			 		break;
			 	case "18":
			 		System.out.println("Exiting! Goodbye!");
			 		break;
			 	default: 
			 		System.out.println(String.format("invalid input: %s\n" + "try again!",option));
			 	 break;
			 }
	 	}

	 
  }
 
	 

 
 	// first query 
  	// take in user input 
  	// establish connection to the sql server and run TSQL querry
	 public static void insertCustomer() throws SQLException {
		 
		 Scanner sc = new Scanner(System.in);
		 boolean addmore1 = true;
			
			//repeat until done
			while(addmore1) {
				//get user input
		 		System.out.println("Please enter a customer name:");
		 		final String CUSTOMER_NAME = sc.nextLine();
		 	
		 		System.out.println("Please enter the address:");
		 		final String ADDRESS = sc.nextLine();
		 		
		 		System.out.println("Please enter category from 1 to 10:");
		 		final Integer CATEGORY = sc.nextInt();
		 		
		 		//run query
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				final PreparedStatement statement = connection.prepareStatement("EXEC New_Customer @name = ?,@address = ? , @category = ?;")) {
		 				statement.setString(1, CUSTOMER_NAME);
		 				statement.setString(2, ADDRESS);
		 				statement.setInt(3, CATEGORY);
	
		 				int rows_inserted = statement.executeUpdate();
		 				System.out.println("Updating the table with user input...");
		 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
		 			}
		 		
		 		}
		 		
		 		System.out.println("Do you want to add more? type 0 or 1");
		 		Integer selection1 = sc.nextInt();
		 		if(selection1 == 0) {
		 			addmore1 = false;
		 			break;
		 		}
			}
				
	 }
 
 	// first query 
  	// take in user input 
  	// establish connection to the sql server and run TSQL querry
	 public static void insertDept() throws SQLException{
			boolean addmore2 = true;
			Scanner sc = new Scanner(System.in);

			//repeat until done
	 		while(addmore2) {
	 			//get user input
		 		System.out.println("Please enter a ID:");
		 		final Integer DeptID = sc.nextInt();
		 		
		 		System.out.println("Please enter the department data:");
		 		final String DeptData = sc.next(); 
		 		
		 		// establis connection and run TSQL query
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				final PreparedStatement statement = connection.prepareStatement("EXEC New_dept @deptId =? , @deptData = ?;")) {
		 				statement.setInt(1, DeptID);
		 				statement.setString(2, DeptData);
		 				int rows_inserted = statement.executeUpdate();
		 				System.out.println("Updating the table with user input...");
		 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
		 			}
		 		}
		 		
		 	
	 			
	 			System.out.println("Do you want to add more? type 0 or 1");
		 		Integer selection2 = sc.nextInt();
		 		if(selection2 == 0) {
		 			addmore2 = false;
		 			break;
		 		}
	 		}
	
	 }
 
	 /*
	 	Get user input for process id and department id, 
	 	associate them and enter them into the tables via sql querry
	 */

	 public static void Q3() throws SQLException{
		 boolean addmore3 = true;
		 Scanner sc = new Scanner(System.in);
	 		
	 		// repeat until done
	 		while(addmore3) {
	 			
	 			//get user input
	 			sc.nextLine();
		 		System.out.println("Please enter a Process ID:");
		 		final Integer Q3PID = sc.nextInt();
		 		
		 		sc.nextLine();
		 		System.out.println("Please enter the department ID:");
		 		final Integer Q3DID = sc.nextInt(); 
		 		
		 		sc.nextLine();
		 		System.out.println("Please enter the department Data:");
		 		final String Q3DEPTDATA = sc.next();
		 		
		 		// establis connections and run the TSQL queries 
		 		// insert new process and departmnet
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				final PreparedStatement statement = connection.prepareStatement("EXEC New_ProcDept @pid = ?, @deptId = ?,@deptData = ?;")) {
		 				statement.setInt(1, Q3PID);
		 				statement.setInt(2, Q3DID);
		 				statement.setString(3, Q3DEPTDATA);
		 				int rows_inserted = statement.executeUpdate();
		 				System.out.println("Updating the table with user input...");
		 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
		 				
		 			}
		 		}

		 		//assosicate process with a department
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				final PreparedStatement statement = connection.prepareStatement("supervisingTable @pid = ? , @deptId = ?;")) {
		 				statement.setInt(1, Q3PID);
		 				statement.setInt(2, Q3DID);
		 				int rows_inserted = statement.executeUpdate();
		 				System.out.println("Updating the table with user input...");
		 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
		 			}
		 		}
		 		
		 		
		 		// assign a processes sub type from user input
		 		sc.nextLine();
		 		System.out.println(" CHOOSE : \n"+ "1. Paint process \n 2. Cut Process \n 3. Fit Process");
		 		final Integer Q3ProcessSelect = sc.nextInt();
		 		
		 		
		 		
			// switch board 
		 		switch(Q3ProcessSelect) {
		 		
		 			// choose paint
			 		case(1):
			 			
			 			sc.nextLine();
			 			System.out.println("Please enter the Paint type:");
			 			final String Q3PAINTTYPE = sc.next();
			 			
			 			sc.nextLine();
			 			System.out.println("Please enter the Paint method:");
				 		final String Q3PAINTMETHOD = sc.next();
				 		
				 		sc.nextLine();
				 		System.out.println("Please enter the process Data:");
				 		final String Q3PROCDATA1 = sc.next();
				 		
				 		
			 			try (final Connection connection = DriverManager.getConnection(URL)) {
				 			try (
				 				// Run the stored procedure
				 				final PreparedStatement statement = connection.prepareStatement("EXEC paintProcessTable @pid = ? , @paintType = ?, @paintingMethod = ?,@process_data = ?;")) {
				 				statement.setInt(1, Q3PID);
				 				statement.setString(2, Q3PAINTTYPE);
				 				statement.setString(3, Q3PAINTMETHOD);
				 				statement.setString(4, Q3PROCDATA1);

				 				int rows_inserted = statement.executeUpdate();
				 				System.out.println("Updating the table with user input...");
				 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
				 			}
				 		}
			 		break;
			 		
			 		case(2):
			 			
			 			sc.nextLine();
			 			System.out.println("Please enter the Machine Type:");
			 			final String Q3MACHINETYPE = sc.next();
			 			
			 			sc.nextLine();
			 			System.out.println("Please enter the Cut type:");
				 		final String Q3CUTYTPE = sc.next();
				 		
				 		sc.nextLine();
				 		System.out.println("Please enter the process Data:");
				 		String Q3PROCDATA2 = sc.next();
				 		
				 		
			 			try (final Connection connection = DriverManager.getConnection(URL)) {
				 			try (
				 				// Run the stored procedure
				 				final PreparedStatement statement = connection.prepareStatement("EXEC cutProcessTable @pid = ?, @process_data = ?,@cutType = ? ,@machineType = ?;")) {
				 				statement.setInt(1, Q3PID);
				 				statement.setString(2, Q3PROCDATA2);
				 				statement.setString(3, Q3CUTYTPE);
				 				statement.setString(4, Q3MACHINETYPE);

				 				int rows_inserted = statement.executeUpdate();
				 				System.out.println("Updating the table with user input...");
				 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
				 			}
				 		}
			 		break;
			 		
			 		case(3):
			 			sc.nextLine();
				 		System.out.println("Please enter the fit type"
				 				+ ":");
			 			final String Q3FITTYPE = sc.next();
			 	
			 			sc.nextLine();
				 		System.out.println("Please enter the process Data:");
				 		final String Q3PROCDATA3 = sc.next();
				 		
				 		
			 			try (final Connection connection = DriverManager.getConnection(URL)) {
				 			try (
				 				// Run the stored procedure
				 				final PreparedStatement statement = connection.prepareStatement("EXEC fitProcessTable @pid = ?, @process_data = ?,@fitType = ?;")) {
				 				statement.setInt(1, Q3PID);
				 				statement.setString(2, Q3PROCDATA3);
				 				statement.setString(3, Q3FITTYPE);


				 				int rows_inserted = statement.executeUpdate();
				 				System.out.println("Updating the table with user input...");
				 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
				 			}
				 		}
			 		break;
		 		
		 		}
		 		
	 			
	 			System.out.println("Do you want to add more? type 0 or 1");
		 		Integer selection3 = sc.nextInt();
		 		if(selection3 == 0) {
		 			addmore3 = false;
		 			break;
		 		}
	 		}
	 		
	 }
	 
	 public static void Q4() throws SQLException{
		 Scanner sc = new Scanner(System.in);
		 boolean addmore4 = true;
	 		
	 		// get user input 
	 		while(addmore4) {	
	 			sc.nextLine();
	 			System.out.println("Please enter customer name:");
		 		final String Q4NAME = sc.next();
		 		
		 		sc.nextLine();
		 		System.out.println("Please enter customer address:");
		 		final String Q4ADDRESS = sc.next();
		 		
		 		sc.nextLine();
		 		System.out.println("Please enter a category from 1 to 10:");
		 		final Integer Q4CATEGORY = sc.nextInt();
		 		
		 		sc.nextLine();
		 		System.out.println("Please enter an assembly ID:");
		 		final Integer Q4ASMID = sc.nextInt();
		 		
		 		sc.nextLine();
		 		System.out.println("Please enter the date the order was made:");
		 		final Date Q4ORDERDATE = Date.valueOf(sc.next()); 
		 		
		 		sc.nextLine();
		 		System.out.println("Please enter in the assmebly details:");
		 		final String Q4ASMDETAILS = sc.next();
		 		
		 		//establis connection and run queries
		 		//new assembly and customer
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				final PreparedStatement statement = connection.prepareStatement("EXEC New_assembly_customer @name = ? , @address = ?, @category = ? , @asmID =? , @orderDate = ?, @details = ?")) {
		 				
		 				statement.setString(1,Q4NAME);
		 				statement.setString(2,Q4ADDRESS);
		 				statement.setInt(3,Q4CATEGORY);
		 				statement.setInt(4,Q4ASMID);
		 				statement.setDate(5,Q4ORDERDATE);
		 				statement.setString(6,Q4ASMDETAILS);

		 				int rows_inserted = statement.executeUpdate();
		 				System.out.println("Updating the table with user input...");
		 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
		 			}
		 		}
		 		
		 		// create association between asmebly and customer
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				final PreparedStatement statement = connection.prepareStatement("EXEC Associate_assembly_customer @asmID =?, @name = ?")) {
		 				statement.setInt(1, Q4ASMID);
		 				statement.setString(2, Q4NAME);
		 				int rows_inserted = statement.executeUpdate();
		 				System.out.println("Updating the table with user input...");
		 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
		 			}
		 		}
		 		
		 		
		 		
		 		boolean addmore = true;
		 		
		 		while(addmore){
		 			sc.nextLine();
		 			System.out.println("Enter in the PID to associate to:");
		 			final Integer Q4PID = sc.nextInt();
		 			
		 			
		 			// create association between assembly and process
			 		try (final Connection connection = DriverManager.getConnection(URL)) {
			 			try (
			 				// Run the stored procedure
			 				final PreparedStatement statement = connection.prepareStatement("EXEC Associate_assembly_process @asmID =? , @pid = ?")) {
			 				statement.setInt(1, Q4ASMID);
			 				statement.setInt(2, Q4PID);
			 				int rows_inserted = statement.executeUpdate();
			 				System.out.println("Updating the table with user input...");
			 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
			 			}
			 		}
			 		
			 		sc.nextLine();
			 		System.out.println("Do you want to add another association 1 or 0 for yes or no :");
		 			Integer selection = sc.nextInt();
		 			
		 			if(selection == 0) {
		 				addmore = false;
		 			}
			 		
			 		
		 		}
		 		
	 			
	 			System.out.println("Do you want to add more? type 0 or 1");
		 		Integer selection4 = sc.nextInt();
		 		if(selection4 == 0) {
		 			addmore4 = false;
		 			break;
		 		}
	 		}
	 
	 }
	 
	 public static void Q5() throws SQLException{
		 boolean addmore5 = true;
		 Scanner sc = new Scanner(System.in);

	 		
	 		while(addmore5) {
	 			// get user input
			 	System.out.println("Please enter a account number:");
		 		final String Q5ACOUNTNUMBER = sc.next();
		 		
		 		System.out.println("Please enter the start date:");
		 		final Date Q5STARTDATE = Date.valueOf(sc.next());
		 		
		 		// establis connections and run queries 
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				final PreparedStatement statement = connection.prepareStatement("EXEC createAccount @actNo =?;")) {
		 				statement.setString(1, Q5ACOUNTNUMBER);
	 
		 				int rows_inserted = statement.executeUpdate();
		 				System.out.println("Updating the table with user input...");
		 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
		 			}
		 		}

		 		// enter in sub account information
				System.out.println(" CHOOSE : \n" + "1. department acct \n 2. process acct \n 3. assembly acct");
	 			
	 			final Integer Q5ProcessSelect = sc.nextInt();
	 		
	 			// choose between each account type and fill in information for each type 
		 		switch(Q5ProcessSelect) {
		 		
			 		case(1):

			 		System.out.println("Please enter a dept id:");
			 		final String Q5DEPTID = sc.next(); 
			 		
			 			try (final Connection connection = DriverManager.getConnection(URL)) {
				 			try (
				 				// Run the stored procedure
				 				final PreparedStatement statement = connection.prepareStatement("EXEC createDeptAccount @actNo = ? , @deptId = ? , @startDate = ?;")) {

				 				statement.setString(1, Q5ACOUNTNUMBER);
				 				statement.setString(2, Q5DEPTID);
				 				statement.setDate(3, Q5STARTDATE);
				 				
				 				int rows_inserted = statement.executeUpdate();
				 				System.out.println("Updating the table with user input...");
				 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
				 			}
				 		}
			 		break;
			 		
			 		case(2):
			 			
		 			
			 		System.out.println("Please enter a process id:");
			 		final String Q5PID = sc.next(); 
			 		
			 			try (final Connection connection = DriverManager.getConnection(URL)) {
				 			try (
				 				// Run the stored procedure
				 				final PreparedStatement statement = connection.prepareStatement("EXEC createProcessAccount @actNo = ? , @pid = ? , @startDate = ?;")) {

				 				statement.setString(1, Q5ACOUNTNUMBER);
				 				statement.setString(2, Q5PID);
				 				statement.setDate(3, Q5STARTDATE);
				 				
				 				int rows_inserted = statement.executeUpdate();
				 				System.out.println("Updating the table with user input...");
				 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
				 			}
				 		}
			 		break;
			 		
			 		case(3):

				 		
				 		
				 		System.out.println("Please enter a assembly id:");
				 		final String Q5ASSEMBLYID = sc.next(); 
				 		
				 		
				 		try (final Connection connection = DriverManager.getConnection(URL)) {
				 			try (
				 				// Run the stored procedure
				 				final PreparedStatement statement = connection.prepareStatement("EXEC createAssemblyAccount @actNo = ? , @asmID = ? , @startDate = ?;")) {
				 				statement.setString(1, Q5ACOUNTNUMBER);
				 				statement.setString(2, Q5ASSEMBLYID);
				 				statement.setDate(3, Q5STARTDATE);
			 
				 				int rows_inserted = statement.executeUpdate();
				 				System.out.println("Updating the table with user input...");
				 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
				 			}
				 		}
			 		break;
		 		
		 		}

		 		System.out.println("Do you want to add more? type 0 or 1");
		 		Integer selection5 = sc.nextInt();
		 		if(selection5 == 0) {
		 			addmore5 = false;
		 			break;
		 		}
	 		}
		 		

	 }
	 
	 public static void Q6() throws SQLException{
		 	Scanner sc = new Scanner(System.in);
	 		boolean addmore6 = true;
	 		
	 		while(addmore6) {
	 			
	 			// get user input
 	 			System.out.println("Please enter the job id:");
		 		final Integer  Q6JOBID = sc.nextInt();

 	 			System.out.println("Please enter the process id:");
		 		final Integer  Q6PID = sc.nextInt();

 	 			System.out.println("Please enter the assembly id:");
		 		final Integer  Q6ASSEMBLYID = sc.nextInt();

 	 			System.out.println("Please enter the start date:");
		 		final Date Q6STARTDATE = Date.valueOf(sc.next());

		 		// get sql connection and run query
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				final PreparedStatement statement = connection.prepareStatement("EXEC New_Job @jobId = ?,@pid = ? , @asmID = ? , @startDate = ?;")) {
		 				statement.setInt(1, Q6JOBID);
		 				statement.setInt(2, Q6PID);
		 				statement.setInt(3, Q6ASSEMBLYID);
		 				statement.setDate(4, Q6STARTDATE);
	 
		 				int rows_inserted = statement.executeUpdate();
		 				System.out.println("Updating the table with user input...");
		 				if(rows_inserted == -1) {
		 					System.out.println("There is no association between PID and assmebly ID in the passthrough table, cannont enter in row");
		 				}else {
			 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));

		 				}
		 			}
		 		}
		 		
	 			System.out.println("Do you want to add more? type 0 or 1");
		 		Integer selection6 = sc.nextInt();
		 		if(selection6 == 0) {
		 			addmore6 = false;
		 			break;
		 		}
	 		}

	 }

	 public static void Q7() throws SQLException{
		 boolean addmore7 = true;
		 Scanner sc = new Scanner(System.in);
	 		
	 		while(addmore7) {
	 			//enter in user info 
 	 			System.out.println("Please enter the job id:");
		 		final Integer  Q7JOBID = sc.nextInt();

 		 		System.out.println("Please enter the end date:");
		 		final Date Q7ENDDATE = Date.valueOf(sc.next());
		 		
		 		// establish connection and run querry 
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				final PreparedStatement statement = connection.prepareStatement("EXEC completed_job @jobNo = ?, @endDate = ?;")) {
		 				statement.setInt(1, Q7JOBID);
		 				statement.setDate(2, Q7ENDDATE);
	 
		 				int rows_inserted = statement.executeUpdate();
		 				System.out.println("Updating the table with user input...");
		 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
		 			}
		 		}

		 		// select sub job type
		 		System.out.println(" CHOOSE : \n" + "1. Paint job \n 2. Cut job \n 3. Fit job");
	 			
 	 			final Integer Q7ProcessSelect = sc.nextInt();
	 		
	 			// switch board
		 		switch(Q7ProcessSelect) {
		 			// get user input for each subtype and run query 
			 		case(1):
 			 			System.out.println("Please enter the Paint color:");
			 			final String Q7PAINTCOLOR = sc.next();
			 			
 			 			System.out.println("Please enter the Paint volume:");
				 		final Integer Q7PAINTVOLUME = sc.nextInt();
				 		
 				 		System.out.println("Please enter the Paint labor :");
				 		final Integer Q7PAINTLABOR = sc.nextInt();

 				 		System.out.println("Please enter the department Data:");
				 		final String Q7PAINTDETIALS = sc.next();
				 		
				 		
			 			try (final Connection connection = DriverManager.getConnection(URL)) {
				 			try (
				 				// Run the stored procedure
				 				final PreparedStatement statement = connection.prepareStatement("EXEC paint_Job @jobNo = ?, @details = ?, @color = ?, @labor =? , @volume =? ;")) {
				 				statement.setInt(1, Q7JOBID);
				 				statement.setString(2, Q7PAINTDETIALS);
				 				statement.setString(3, Q7PAINTCOLOR);
				 				statement.setInt(4, Q7PAINTLABOR);
				 				statement.setInt(5, Q7PAINTVOLUME);

				 				int rows_inserted = statement.executeUpdate();
				 				System.out.println("Updating the table with user input...");
				 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
				 			}
				 		}
			 		break;
			 		
			 		case(2):
			 			
 						System.out.println("Please enter the machine type:");
			 			final String Q7CUTMACHINETYPE = sc.next();
			 			
			 			System.out.println("Please enter the materials used:");
				 		final String Q7CUTMATERIALS = sc.next();
				 		
				 		
				 		System.out.println("Please enter the Cut labor :");
				 		final Integer Q7CUTLABOR = sc.nextInt();

				 		
				 		System.out.println("Please enter the Cut time:");
				 		final Integer Q7CUTTIME = sc.nextInt();

				 		
				 		System.out.println("Please enter the Cut Data:");
				 		final String Q7CUTDETIALS = sc.next();
				 		
				 		
			 			try (final Connection connection = DriverManager.getConnection(URL)) {
				 			try (
				 				// Run the stored procedure
				 				final PreparedStatement statement = connection.prepareStatement("EXEC cut_Job @jobNo = ? , @details = ? , @materials = ?,@machineType = ?,@labor = ? , @timeTaken = ? ;")) {
				 				statement.setInt(1, Q7JOBID);
				 				statement.setString(2, Q7CUTDETIALS);
				 				statement.setString(3, Q7CUTMATERIALS);
				 				statement.setString(4, Q7CUTMACHINETYPE);
				 				statement.setInt(5, Q7CUTLABOR);
				 				statement.setInt(6, Q7CUTTIME);

				 				int rows_inserted = statement.executeUpdate();
				 				System.out.println("Updating the table with user input...");
				 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
				 			}
			 			}	
			 		break;
			 		
			 		case(3):
			 			
				 		System.out.println("Please enter the Fit labor:");
			 			final Integer Q7FITLABOR = sc.nextInt();
			 	
			 			
				 		System.out.println("Please enter the Fit details:");
				 		final String Q7FITDETIALS = sc.next();
				 		
				 		
			 			try (final Connection connection = DriverManager.getConnection(URL)) {
				 			try (
				 				// Run the stored procedure
				 				final PreparedStatement statement = connection.prepareStatement("EXEC fit_Job @jobNo = ? , @details = ? , @labor = ?;")) {
				 				statement.setInt(1, Q7JOBID);
				 				statement.setString(2, Q7FITDETIALS);
				 				statement.setInt(3, Q7FITLABOR);


				 				int rows_inserted = statement.executeUpdate();
				 				System.out.println("Updating the table with user input...");
				 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
				 			}
				 		}
			 		break;
		 		
		 		}
	 			System.out.println("Do you want to add more? type 0 or 1");
		 		Integer selection7 = sc.nextInt();
		 		if(selection7 == 0) {
		 			addmore7 = false;
		 			break;
		 		}
	 		}
	 		
	 }

	 public static void Q8() throws SQLException{
		 boolean addmore8 = true;
		 Scanner sc = new Scanner(System.in);
	 		while(addmore8) {
	 			System.out.println("--------------------------------------------------------------");
	 			
	 			System.out.println("Please enter a transation number:");
		 		final Integer Q8TRANSNUM = sc.nextInt();
		 		
		 		
	 			System.out.println("Please enter the sup cost:");
		 		final Integer Q8SUPCOST = sc.nextInt();

		 		
	 			System.out.println("Please enter the account number:");
		 		final Integer Q8ACTNUM = sc.nextInt();
		 		

		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				final PreparedStatement statement = connection.prepareStatement("EXEC recordTransaction @transNo = ? , @supCost = ? , @actNo = ?;")) {
		 				statement.setInt(1, Q8TRANSNUM);
		 				statement.setInt(2, Q8SUPCOST);
		 				statement.setInt(3, Q8ACTNUM);
	 
		 				int rows_inserted = statement.executeUpdate();
		 				System.out.println("Updating the table with user input...");
		 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
		 			}
		 		}

	 			
	 			System.out.println("Do you want to add more? type 0 or 1");
		 		Integer selection8 = sc.nextInt();
		 		if(selection8 == 0) {
		 			addmore8 = false;
		 			break;
		 		}
	 		}
	 
	 }
	 
	 public static void Q9() throws SQLException{
		 boolean addmore9 = true;
		 Scanner sc = new Scanner(System.in);
	 		while(addmore9) {
	 			System.out.println("--------------------------------------------------------------");

	 			// get user intput for assembly id 
	 			System.out.println("Please enter a assembly ID:");
		 		final Integer Q9ASSEMBLYID = sc.nextInt();
		 		
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				final PreparedStatement statement = connection.prepareStatement("EXEC totalCostOnAssembly @asmID =  ?;")) {
		 				statement.setInt(1, Q9ASSEMBLYID);
		 				ResultSet result = statement.executeQuery();
		 				while (result.next()) {
		 					System.out.println("Cost");
		 					System.out.println(String.format("%s ",
		 							result.getString(1)));
		 				}
	 
		 			}
		 		}
		 		

	 			
	 			System.out.println("Do you want to add more? type 0 or 1");
		 		Integer selection9 = sc.nextInt();
		 		if(selection9 == 0) {
		 			addmore9 = false;
		 			break;
		 		}
	 		}

	 }

	 public static void Q10() throws SQLException{

		 Scanner sc = new Scanner(System.in);
	 	
	 		boolean addmore10 = true;
	 		
	 		while(addmore10) {
	 			// get user input 
	 			System.out.println("--------------------------------------------------------------");
	 			System.out.println("Please enter a department ID:");
		 		final Integer Q10DEPTID = sc.nextInt();

	 			System.out.println("Please enter the end date:");
		 		final Date Q10ENDDATE = Date.valueOf(sc.next());
		 		
		 		//establis sql connection 
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				final PreparedStatement statement = connection.prepareStatement("EXEC totalLaborOneDept @deptId = ?, @endDate = ?;")) {
		 				statement.setInt(1, Q10DEPTID);
		 				statement.setDate(2, Q10ENDDATE);
		 				ResultSet result = statement.executeQuery();
		 				while (result.next()) {
		 					System.out.println("labor");
		 					System.out.println(String.format("%s ",
		 							result.getString(1)));
		 				}
	 
		 			}
		 		}
	 			
	 			System.out.println("Do you want to add more? type 0 or 1");
		 		Integer selection10 = sc.nextInt();
		 		if(selection10 == 0) {
		 			addmore10 = false;
		 			break;
		 		}
	 		}
	
	 }

	 public static void Q11() throws SQLException{
	 		boolean addmore11 = true;
	 		Scanner sc = new Scanner(System.in);
		 	
	 		while(addmore11) {
	 			System.out.println("--------------------------------------------------------------");
	 			// get user input
	 			System.out.println("Please enter a assembly ID:");
		 		final Integer Q10ASSEMBLYID = sc.nextInt();
		 		//establis sql connection
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				final PreparedStatement statement = connection.prepareStatement("EXEC getAssemblyProccesHistory @asmID =  ?;")) {
		 				statement.setInt(1, Q10ASSEMBLYID);
		 				ResultSet result = statement.executeQuery();
		 				System.out.println("asmID | start date | pid | did");
		 				while (result.next()) {
		 					
		 					System.out.println(String.format("%s    | %s | %s | %s ",
		 							result.getString(1),
		 							result.getString(2),
		 							result.getString(3),
		 							result.getString(4)

		 							
		 							));
		 				}
	 
		 			}
		 		}
	 			
	 			System.out.println("Do you want to add more? type 0 or 1");
		 		Integer selection11 = sc.nextInt();
		 		if(selection11 == 0) {
		 			addmore11 = false;
		 			break;
		 		}
	 		}
	 
	 }

	 public static void Q12() throws SQLException{
		 	Scanner sc = new Scanner(System.in);
	 		boolean addmore12 = true;
	 		while(addmore12) {
	 			System.out.println("--------------------------------------------------------------");
	 			//get user input
	 			System.out.println("Please enter a department ID:");
		 		final Integer Q12DEPTID = sc.nextInt();

	 			System.out.println("Please enter the end date:");
		 		final Date Q12ENDDATE = Date.valueOf(sc.next());
		 		
		 		//establis sql connection
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				// get paint history
		 				final PreparedStatement statement = connection.prepareStatement("EXEC getJobHistory_paint @deptId = ?, @endDate = ?;")) {
		 				statement.setInt(1, Q12DEPTID);
		 				statement.setDate(2, Q12ENDDATE);
	 					
	 					// get the result of the query 
		 				ResultSet result = statement.executeQuery();
		 				System.out.println("===================");

		 				// display results 
		 				System.out.println("PAINT JOBTS\n"
		 						+ "DID|PID|asmID|end date|job ID|Details|color|labor|volume");
		 				while (result.next()) {

		 					if(result.getString(1)=="NULL") {
		 						System.out.println("NO ROWS");
		 						break;
		 					}else {
		 						System.out.println(String.format("%s | %s | %s | %s |%s | %s | %s | %s | %s  ",
			 							result.getString(1),
			 							result.getString(2),
			 							result.getString(3),
			 							result.getString(4),
			 							result.getString(5),
			 							result.getString(6),
			 							result.getString(7),
			 							result.getString(8),
			 							result.getString(9)

			 							));
		 					}
		 					break;
		 				}
		 			}
		 		}
		 		
		 		// get job history of cut 
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				final PreparedStatement statement = connection.prepareStatement("EXEC getJobHistory_cut @deptId = ?, @endDate = ?;")) {
		 				statement.setInt(1, Q12DEPTID);
		 				statement.setDate(2, Q12ENDDATE);
		 				
		 				//get result and print them
		 				ResultSet result = statement.executeQuery();
		 				System.out.println("===================");
		 				System.out.println("CUT JOBS\n"
		 						+ "DID|PID|asmID|end date|job ID|Materials|labor|machine Type|time taken");
		 				while (result.next()) {
		 					
		 					if(result.getString(1)=="null") {
		 						System.out.println("NO ROWS");
		 						break;
		 					}else {
		 						System.out.println(String.format("%s | %s | %s | %s | %s | %s | %s | %s | %s ",
			 							result.getString(1),
			 							result.getString(2),
			 							result.getString(3),
			 							result.getString(4),
			 							result.getString(5),
			 							result.getString(6),
			 							result.getString(7),
			 							result.getString(8),
			 							result.getString(9)
			 							));
		 					}
		 					
		 					break;
		 				}
		 			}
		 		}
		 		
		 		// get job history of fit 
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				final PreparedStatement statement = connection.prepareStatement("EXEC getJobHistory_fit @deptId = ?, @endDate = ?;")) {
		 				statement.setInt(1, Q12DEPTID);
		 				statement.setDate(2, Q12ENDDATE);
		 				
		 				// get results and print them 
		 				ResultSet result = statement.executeQuery();
		 				System.out.println("===================");

		 				System.out.println("FIT JOBTS\n"
		 						+ "DID|PID|asmID|end date|job ID|Detials|labor");
		 				while (result.next()) {
		 					if(result.getString(1) == "null") {
		 						System.out.println("NO ROWS");
		 					}else {
			 					System.out.println(String.format("%s | %s | %s | %s | %s | %s | %s ",
			 							result.getString(1),
			 							result.getString(2),
			 							result.getString(3),
			 							result.getString(4),
			 							result.getString(5),
			 							result.getString(6),
			 							result.getString(7)
			 							));
		 					}

		 				}
		 			}
		 		}
	 			
	 			System.out.println("Do you want to add more? type 0 or 1");
		 		Integer selection12 = sc.nextInt();
		 		if(selection12 == 0) {
		 			addmore12 = false;
		 			break;
		 		}
	 		}
			 
	 }

	 public static void Q13() throws SQLException{


		 Scanner sc = new Scanner(System.in);
	 	
	 		boolean addmore13 = true;
	 		
	 		while(addmore13) {
	 			System.out.println("--------------------------------------------------------------");
	 			
	 			//get user input
				System.out.println("Please enter a start range:");
		 		final Integer Q13STARTRANGE = sc.nextInt();

	 			System.out.println("Please enter a end range:");
		 		final Integer Q13ENDRANGE = sc.nextInt();
		 		
		 		//establis connection
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				// get results 
		 				final PreparedStatement statement = connection.prepareStatement("getCustomers @startRange = ? ,@endRange = ?;")) {
		 				statement.setInt(1, Q13STARTRANGE);
		 				statement.setInt(2, Q13ENDRANGE );
		 				ResultSet result = statement.executeQuery();
		 				System.out.println("name | address | category");
		 				while (result.next()) {
		 					
		 					//print out results
		 					System.out.println(String.format("%s | %s | %s ",
		 							result.getString(1),
		 							result.getString(2),
		 							result.getString(3)

		 							
		 							));
		 				}
		 				
	 
		 			}
		 		}
	 			System.out.println("Do you want to add more? type 0 or 1");
		 		Integer selection13 = sc.nextInt();
		 		if(selection13 == 0) {
		 			addmore13 = false;
		 			break;
		 		}
	 		
	 		}
	
	 }
	 
	 public static void Q14() throws SQLException{

			boolean addmore14 = true;
			Scanner sc = new Scanner(System.in);

	 		while(addmore14) {
	 			System.out.println("--------------------------------------------------------------");
	 			// get user input
	 			System.out.println("Please enter a start range:");
		 		final Integer Q14STARTRANGE = sc.nextInt();

	 			System.out.println("Please enter a end range:");
		 		final Integer Q14ENDRANGE = sc.nextInt();
		 		
		 		// establish connection 
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				final PreparedStatement statement = connection.prepareStatement("EXEC deleteCutJob @startRange = ? ,@endRange = ?;")) {
		 				statement.setInt(1, Q14STARTRANGE);
		 				statement.setInt(2, Q14ENDRANGE );
		 				
		 				statement.executeUpdate();
	 
		 			}
		 		}

	 			
	 			System.out.println("Do you want to delete more? type 0 or 1");
		 		Integer selection14 = sc.nextInt();
		 		if(selection14 == 0) {
		 			addmore14 = false;
		 			break;
		 		}
	 		}

	 }
	 
	 public static void Q15() throws SQLException{

		 	Scanner sc = new Scanner(System.in);

			boolean addmore15 = true;
	 		
	 		while(addmore15) {
	 			// get user input
	 			System.out.println("Please enter a job ID:");
		 		final Integer Q15JOBID = sc.nextInt();

	 			System.out.println("Please enter a color:");
		 		final String Q15COLOR = sc.next();
		 		
		 		// get connection
		 		try (final Connection connection = DriverManager.getConnection(URL)) {
		 			try (
		 				// Run the stored procedure
		 				final PreparedStatement statement = connection.prepareStatement("EXEC changePaint @jobId = ?, @color = ?;")) {
		 				statement.setInt(1, Q15JOBID);
		 				statement.setString(2, Q15COLOR );
		 				
		 				statement.executeUpdate();

		 			}
		 		}
	 			
	 			System.out.println("Do you want to add more? type 0 or 1");
		 		Integer selection15 = sc.nextInt();
		 		if(selection15 == 0) {
		 			addmore15 = false;
		 			break;
		 		}
	 		}
	 		
	 }

	 public static void Q16() throws SQLException{
		 
		 	// get file name 
			System.out.println("Please enter the file info in this format location\\filename.csv format");
			
		 	Scanner sc = new Scanner(System.in);

		 	// parse the csv and tolkenize it 
	 		final String csvRead = sc.next(); 
			BufferedReader br = null;
	        String line = "";
	        String cvsSplitBy = ",";
	       try {//go through lines in the provided file
	            br = new BufferedReader(new FileReader(csvRead));
	            while ((line = br.readLine()) != null) {
	            	//split the columns
	                String[] CUSTOMER_DATA = line.split(cvsSplitBy);
	                //set attribute values from the csv file
	               String name = CUSTOMER_DATA[0]; 
	               String address = CUSTOMER_DATA[1];
	               String category = CUSTOMER_DATA[2];
	               
	               //input the information inot the query 
			 		try (final Connection connection = DriverManager.getConnection(URL)) {
			 			try (
			 				// Run the stored procedure
			 				final PreparedStatement statement = connection.prepareStatement("EXEC New_Customer @name = ?,@address = ? , @category = ?;")) {
			 				statement.setString(1, name);
			 				statement.setString(2, address);
			 				statement.setInt(3, Integer.parseInt(category));
		
							// update 
			 				int rows_inserted = statement.executeUpdate();
			 				System.out.println("Updating the table with user input...");
			 				System.out.println(String.format("Done. %d rows inserted.", rows_inserted));
			 			}
			 		
			 		}
			 		
	            }
	           } //check for file availability
	       		catch (FileNotFoundException e) {
	              e.printStackTrace();
	          } catch (IOException e) {
	              e.printStackTrace();
	          } finally {
	              if (br != null) {
	                  try {
	                      br.close();
	                  } catch (IOException e) {
	                      e.printStackTrace();
	                  }
	              }
	          }
	            	 
	 }

	 public static void Q17() throws SQLException{
		 
		 	Scanner sc = new Scanner(System.in);
		 	// get user input
			System.out.println("Please enter a start range:");
	 		final Integer Q13STARTRANGE = sc.nextInt();

 			System.out.println("Please enter a end range:");
	 		final Integer Q13ENDRANGE = sc.nextInt();
	 		
	 		System.out.println("Please enter the export location and file name in location\\filename.csv format");			
	 		// get the name of the csv you want to export 
	 		final String csvInfo = sc.next();
	 		
	 		try (final Connection connection = DriverManager.getConnection(URL)) {
	 			try (
	 				// Run the stored procedure
	 				final PreparedStatement statement = connection.prepareStatement("getCustomers @startRange = ? ,@endRange = ?;")) {
	 				statement.setInt(1, Q13STARTRANGE);
	 				statement.setInt(2, Q13ENDRANGE );
	 				ResultSet result = statement.executeQuery();
	 				
	 				BufferedWriter fileWriter = new BufferedWriter(new FileWriter(csvInfo));
	 	             
	 	            // write header line containing column names       
	 	            fileWriter.write("name,address,category");
	 	             
	 	            // write to file 
	 	            while (result.next()) {
	 	                String name = result.getString("name");
	 	                String address = result.getString("address");
	 	                Integer category = result.getInt("category");

	 	                 
	 	                String line = String.format("%s,%s,%s",
	 	                        name, address,category);
	 	                 
	 	                fileWriter.newLine();
	 	                fileWriter.write(line);            
	 	            }
	 	             
	 	            statement.close();
	 	            fileWriter.close();
	 	             
	 	        } catch (SQLException e) {
	 	            System.out.println("Datababse error:");
	 	            e.printStackTrace();
	 	        } catch (IOException e) {
	 	            System.out.println("File IO error:");
	 	            e.printStackTrace();
 
	 			}
	 			
	 			
	 		}
 
	 }


}


