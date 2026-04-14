<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Login</title>
<link rel="stylesheet" href="../css/patient_login.css">
</head>
<body>
	<h2>Patient Login</h2>
	
	<form action="../PatientLoginServlet" method="post">
		Email: <input type="email" name="email" required><br><br>
		Password: <input type="password" name="password" required><br><br>
		<button type="submit">Login</button>
	</form>
	<a href="register.jsp">New Patient? Register</a>
</body>
</html>