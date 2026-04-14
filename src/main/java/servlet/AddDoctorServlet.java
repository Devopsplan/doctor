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

@WebServlet("/AddDoctorServlet")
public class AddDoctorServlet extends HttpServlet{
	protected void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		String insert="insert into doctor(name,specialization,email,password) values(?,?,?,?)";
		
		try {
			Connection con=DBConnection.getConnection();
			PreparedStatement ps=con.prepareStatement(insert);
			ps.setString(1, req.getParameter("name"));
			ps.setString(2, req.getParameter("specialization"));
			ps.setString(3, req.getParameter("email"));
			ps.setString(4, req.getParameter("password"));
			ps.executeUpdate();
			res.sendRedirect("admin/dashboard.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
