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
 DataHandler handler = new DataHandler();
 String name = request.getParameter("name");
 String address = request.getParameter("address");
 String category = request.getParameter("category");

 boolean inserted = handler.addCustomer(name, address, Integer.valueOf(category));
 if (!inserted) { 
 %>
 <h2>There was a problem inserting the course</h2>
 <%
 } else { 
 %>
 <h2>Customer:</h2>
 <ul>
	 <li>Name: <%=name%></li>
	 <li>Address: <%=address%></li>
	 <li>Category: <%=category%></li>
 </ul>
 <h2>Was successfully inserted.</h2>


 <%
 }
 
 %>
 </body>
</html>