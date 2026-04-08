package controller;

import dao.DBConnection;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class ReturnServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // FIX: Proper encoding (solves ₹ issue)
        res.setContentType("text/html;charset=UTF-8");
        res.setCharacterEncoding("UTF-8");

        try {
            int issueId = Integer.parseInt(req.getParameter("issue_id"));
            String returnDateStr = req.getParameter("return_date");

            System.out.println("Return called");
            System.out.println("Issue ID: " + issueId);
            System.out.println("Return Date: " + returnDateStr);

            // Safety check (avoid null/empty crash)
            if (returnDateStr == null || returnDateStr.isEmpty()) {
                res.getWriter().println("<h3>Please select return date</h3>");
                return;
            }

            Connection con = DBConnection.getConnection();

            // 1. Get due date
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT due_date FROM issue WHERE issue_id=?"
            );
            ps1.setInt(1, issueId);

            ResultSet rs = ps1.executeQuery();

            if (!rs.next()) {
                res.getWriter().println("<h3>Invalid Issue ID</h3>");
                return;
            }

            Date dueDate = rs.getDate("due_date");
            Date retDate = Date.valueOf(returnDateStr);

            System.out.println("Due Date: " + dueDate);
            System.out.println("Return Date: " + retDate);

            // 2. Calculate fine
            long diff = retDate.getTime() - dueDate.getTime();
            int daysLate = (int)(diff / (1000 * 60 * 60 * 24));

            int fine = Math.max(0, daysLate * 10);

            System.out.println("Days Late: " + daysLate);
            System.out.println("Fine: " + fine);

            // 3. Update DB
            PreparedStatement ps2 = con.prepareStatement(
                "UPDATE issue SET return_date=?, fine=? WHERE issue_id=?"
            );
            ps2.setDate(1, retDate);
            ps2.setInt(2, fine);
            ps2.setInt(3, issueId);

            int rows = ps2.executeUpdate();
            System.out.println("Rows updated: " + rows);

            // 4. Output (₹ fixed)
            res.getWriter().println("<h2>Book Returned Successfully</h2>");
            res.getWriter().println("<h3>Fine: &#8377;" + fine + "</h3>");

            // Close resources (important)
            rs.close();
            ps1.close();
            ps2.close();
            con.close();

        } catch(Exception e){
            e.printStackTrace();
            res.getWriter().println("<h3>Error occurred. Check server logs.</h3>");
        }
    }
}