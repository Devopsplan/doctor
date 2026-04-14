package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import db.DBConnection;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/PatientRegisterServlet")
public class PatientRegistrerServlet extends HttpServlet{
	protected void doPost(HttpServletRequest req,HttpServletResponse res) {
		String insert="insert into patient(name,email,password,phone)values(?,?,?,?)";
		String name=req.getParameter("name");
		String email=req.getParameter("email");
		String password=req.getParameter("password");
		String phone=req.getParameter("phone");
		try {
			Connection con=DBConnection.getConnection();
			if(con != null) {
				PreparedStatement ps=con.prepareStatement(insert);
				ps.setString(1, name);
				ps.setString(2, email);
				ps.setString(3, password);
				ps.setString(4, phone);
				int rs=ps.executeUpdate();
				if(rs>0) {
					res.sendRedirect("patient/login.jsp");
				}else {
					res.sendRedirect("patient/register.jsp");
				}
			}
		} catch (SQLException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
