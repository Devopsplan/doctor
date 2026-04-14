<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,db.DBConnection" %>
<%
if(session.getAttribute("admin")==null){
    response.sendRedirect("../index.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>
<link rel="stylesheet" href="../css/admin_dashboard.css">
</head>
<body>

<h2>Admin Dashboard</h2>
<a href="../LogoutServlet">Logout</a>

<h3>Add Doctor</h3>
<form action="../AddDoctorServlet" method="post">
    Name: <input type="text" name="name"><br><br>
    Specialization: <input type="text" name="specialization"><br><br>
    Email: <input type="email" name="email"><br><br>
    Password: <input type="password" name="password"><br><br>
    <button type="submit">Add Doctor</button>
</form>

<h3>Doctors List</h3>
<table border="1">
<tr>
    <th>Name</th>
    <th>Specialization</th>
    <th>Email</th>
    <th>Delete</th>
</tr>

<%
Connection con = DBConnection.getConnection();
ResultSet rs = con.createStatement().executeQuery("SELECT * FROM doctor");
while(rs.next()){
%>
<tr>
<td><%=rs.getString("name")%></td>
<td><%=rs.getString("specialization")%></td>
<td><%=rs.getString("email")%></td>
<td>
<a href="../DeleteDoctorServlet?id=<%=rs.getInt("id")%>">Delete</a>
</td>
</tr>
<% } %>

</table>

</body>
</html>
