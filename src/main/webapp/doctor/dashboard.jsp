<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,db.DBConnection" %>
<%
if(session.getAttribute("doctorId")==null){
    response.sendRedirect("../index.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Doctor Dashboard</title>
<link rel="stylesheet" href="../css/doctor_dashboard.css">
</head>
<body>

<h2>Doctor Dashboard</h2>
<a href="../LogoutServlet">Logout</a>

<table border="1">
<tr>
    <th>Patient</th>
    <th>Date</th>
    <th>Status</th>
    <th>Action</th>
</tr>

<%
int doctorId = (int)session.getAttribute("doctorId");
Connection con = DBConnection.getConnection();
PreparedStatement ps = con.prepareStatement(
    "SELECT a.id,p.name,a.appointment_date,a.status FROM appointment a JOIN patient p ON a.patient_id=p.id WHERE a.doctor_id=?"
);
ps.setInt(1, doctorId);
ResultSet rs = ps.executeQuery();

while(rs.next()){
%>
<tr>
<td><%=rs.getString(2)%></td>
<td><%=rs.getString(3)%></td>
<td><%=rs.getString(4)%></td>
<td>
<form action="../UpdateAppointmentStatusServlet" method="post">
    <input type="hidden" name="id" value="<%=rs.getInt(1)%>">
    <select name="status">
        <option>Approved</option>
        <option>Rejected</option>
    </select>
    <button type="submit">Update</button>
</form>
</td>
</tr>
<% } %>

</table>

</body>
</html>
    