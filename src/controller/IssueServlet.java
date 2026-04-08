package controller;

import dao.DBConnection;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class IssueServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            int studentId = Integer.parseInt(req.getParameter("student_id"));
            int bookId = Integer.parseInt(req.getParameter("book_id"));
            String issueDate = req.getParameter("issue_date");

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO issue(student_id, book_id, issue_date, due_date) VALUES (?, ?, ?, DATE_ADD(?, INTERVAL 7 DAY))",
                Statement.RETURN_GENERATED_KEYS
            );

            ps.setInt(1, studentId);
            ps.setInt(2, bookId);
            ps.setString(3, issueDate);
            ps.setString(4, issueDate);

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            int issueId = 0;

            if (rs.next()) {
                issueId = rs.getInt(1);
            }

            res.sendRedirect("issueBook.jsp?issueId=" + issueId);

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}