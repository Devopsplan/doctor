package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.DBConnection;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PatientLoginServlet")
public class PatientLoginServlet extends HttpServlet{
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		String email=req.getParameter("email");
		String password=req.getParameter("password");
		String fetchData="select * from patient where email=? and password=?";
		
		
		try {
			Connection con=DBConnection.getConnection();
			PreparedStatement ps=con.prepareStatement(fetchData);
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				HttpSession session=req.getSession();
				session.setAttribute("patientId", rs.getInt("id"));
				res.sendRedirect("patient/dashboard.jsp");
			}else {
				res.sendRedirect("error.jsp?error=1");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
