<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Doctor Login</title>
<link rel="stylesheet" href="../css/doctor_login.css">
</head>
<body>

<h2>Doctor Login</h2>

<form action="../DoctorLoginServlet" method="post">
    Email: <input type="email" name="email" required><br><br>
    Password: <input type="password" name="password" required><br><br>
    <button type="submit">Login</button>
</form>

</body>
</html>
