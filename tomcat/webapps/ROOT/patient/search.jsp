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
<title>Search Doctor</title>
<link rel="stylesheet" href="../css/patient_search.css">
</head>
<body>

<h2>Search Doctors by Specialization</h2>

<form method="get">
    <input type="text" name="specialization" placeholder="Enter specialization">
    <button type="submit">Search</button>
</form>

<table border="1">
<tr>
    <th>Name</th>
    <th>Specialization</th>
</tr>

<%
String spec = request.getParameter("specialization");

Connection con = DBConnection.getConnection();
PreparedStatement ps;

if(spec != null && !spec.trim().isEmpty()){
    ps = con.prepareStatement(
        "SELECT * FROM doctor WHERE specialization LIKE ?"
    );
    ps.setString(1, "%" + spec + "%");
} else {
    ps = con.prepareStatement("SELECT * FROM doctor");
}

ResultSet rs = ps.executeQuery();

boolean found = false;
while(rs.next()){
    found = true;
%>
<tr>
    <td><%=rs.getString("name")%></td>
    <td><%=rs.getString("specialization")%></td>
</tr>
<% }

if(!found){ %>
<tr>
    <td colspan="2">No doctors found</td>
</tr>
<% }

rs.close();
ps.close();
con.close();
%>

</table>

</body>
</html>
