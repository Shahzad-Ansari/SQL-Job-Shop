<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Query Result</title>
</head>
 <body>
 <%@page import="jsp_project.Shahzad_Ansari_IP_Task7_DataHandler"%>
 <%@page import="java.sql.ResultSet"%>
 <%@page import="java.sql.Array"%>
 <%
 // The handler is the one in charge of establishing the connection.
 DataHandler handler = new DataHandler();
 // Get the attribute values passed from the input form.
 String start = request.getParameter("start");
 String end = request.getParameter("end");

 // Now perform the query with the data from the form.
 ResultSet rs = handler.getCustomers(Integer.valueOf(start),Integer.valueOf(end));
 %>
 
 
  <!-- The table for displaying all the customer records -->
 <table cellspacing="2" cellpadding="2" border="1">
 <tr> <!-- The table headers row -->
 <td align="center">
 <h4>Name</h4>
 </td>
 <td align="center">
 <h4>Address</h4>
 </td>
 <td align="center">
 <h4>Category</h4>
 </td>

 </tr>
 <%
 while(rs.next()) { // For each customer 
 // Extract every row returned
final String name = rs.getString("name");
final String address = rs.getString("address");
final String category = rs.getString("category");
out.println("<tr>"); // Start printing out the new table row
out.println( // Print each attribute 
 "<td align=\"center\">" + name +
 "</td><td align=\"center\"> " + address +
 "</td><td align=\"center\"> " + category + "</td>");
 out.println("</tr>");
 }
 %>
 
 
  </body>
  
</html>

