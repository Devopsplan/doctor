<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,db.DBConnection" %>
<%
if(session.getAttribute("patientId")==null){
    response.sendRedirect("../index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>My Appointments</title>
<link rel="stylesheet" href="../css/patient_myappointments.css">
</head>
<body>

<h2>My Appointments</h2>
<a href="dashboard.jsp">Back</a> |
<a href="../LogoutServlet">Logout</a>

<table border="1">
<tr>
    <th>Doctor Name</th>
    <th>Appointment Date</th>
    <th>Status</th>
</tr>

<%
int patientId = (int)session.getAttribute("patientId");
Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
    "SELECT d.name, a.appointment_date, a.status " +
    "FROM appointment a JOIN doctor d ON a.doctor_id = d.id " +
    "WHERE a.patient_id = ?"
);
ps.setInt(1, patientId);
ResultSet rs = ps.executeQuery();

while(rs.next()){
%>
<tr>
    <td><%= rs.getString(1) %></td>
    <td><%= rs.getDate(2) %></td>
    <td><%= rs.getString(3) %></td>
</tr>
<% } %>

</table>

</body>
</html>
