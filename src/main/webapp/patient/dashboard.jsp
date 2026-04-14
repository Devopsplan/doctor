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
<title>Patient Dashboard</title>
<link rel="stylesheet" href="../css/patient_dashboard.css">
</head>
<body>

<h2>Welcome Patient</h2>
<a href="../LogoutServlet">Logout</a>

<h3>Book Appointment</h3>

<form action="../BookAppointmentServlet" method="post">

    Select Doctor:
    <select name="doctorId" required>
        <%
        Connection con = DBConnection.getConnection();
        ResultSet rs = con.createStatement().executeQuery("SELECT * FROM doctor");
        while(rs.next()){
        %>
        <option value="<%=rs.getInt("id")%>">
            <%=rs.getString("name")%> - <%=rs.getString("specialization")%>
        </option>
        <% }
           rs.close();
           con.close();
        %>
    </select>
    <br><br>

    Date:
    <input type="date"
           name="date"
           min="<%= java.time.LocalDate.now() %>"
           required>
    <br><br>

    <button type="submit">Book</button>
</form>

<br>
<a href="search.jsp">Search Doctors</a>
<a href="myappointments.jsp">View My Appointments</a>


</body>
</html>
