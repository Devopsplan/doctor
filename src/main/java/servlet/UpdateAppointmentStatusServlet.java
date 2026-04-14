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

@WebServlet("/UpdateAppointmentStatusServlet")
public class UpdateAppointmentStatusServlet extends HttpServlet{
	protected void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		String update="update appointment set status=? where id=?";
		
		try {
			Connection con=DBConnection.getConnection();
			PreparedStatement ps=con.prepareStatement(update);
			ps.setString(1, req.getParameter("status"));
			ps.setInt(2, Integer.parseInt(req.getParameter("id")));
			ps.executeUpdate();
			res.sendRedirect("doctor/dashboard.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
