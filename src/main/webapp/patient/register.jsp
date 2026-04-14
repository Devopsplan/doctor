<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Patient Registration</title>
<link rel="stylesheet" href="../css/patient_registration.css">
</head>
<body>

    <form action="../PatientRegisterServlet" method="post">

        <h2>Patient Registration</h2>

        Name : <input type="text" name="name" required><br><br>
        Email: <input type="email" name="email" required><br><br>
        Password: <input type="password" name="password" required><br><br>
        Phone: <input type="text" name="phone" required><br><br>

        <button type="submit">Register</button>
        <a href="login.jsp">Already you have an account</a>

    </form>

</body>

</html>