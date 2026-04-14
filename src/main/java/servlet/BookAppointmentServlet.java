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
import jakarta.servlet.http.HttpSession;

@WebServlet("/BookAppointmentServlet")
public class BookAppointmentServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
		String insert="insert into appointment(patient_id,doctor_id,appointment_date,status) values (?,?,?,?)";
		HttpSession session =req.getSession(false);
		if(session == null) {
			res.sendRedirect("patient/login.jsp");
			return;
		}
		int patientId=(int)session.getAttribute("patientId");
		int doctorId=Integer.parseInt(req.getParameter("doctorId"));
		String date=req.getParameter("date");
		
		try {
			Connection con=DBConnection.getConnection();
			PreparedStatement ps=con.prepareStatement(insert);
			ps.setInt(1, patientId);
			ps.setInt(2, doctorId);
			ps.setString(3, date);
			ps.setString(4, "pending");
			ps.executeUpdate();
			res.sendRedirect("patient/myappointments.jsp");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
