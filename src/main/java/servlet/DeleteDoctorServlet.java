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

@WebServlet("/DeleteDoctorServlet")
public class DeleteDoctorServlet extends HttpServlet{
	protected void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException {
		String delete="delete from doctor where id=?";
		
		try {
			Connection con=DBConnection.getConnection();
			PreparedStatement ps=con.prepareStatement(delete);
			ps.setInt(1, Integer.parseInt(req.getParameter("id")));
			ps.executeUpdate();
			res.sendRedirect("admin/dashboard.jsp");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
