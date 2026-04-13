package controller;

import dao.IssueDAO;
import model.Issue;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Date;

public class ReturnServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("text/html;charset=UTF-8");
        res.setCharacterEncoding("UTF-8");

        try {
            int issueId = Integer.parseInt(req.getParameter("issue_id"));
            String returnDateStr = req.getParameter("return_date");

            if (returnDateStr == null || returnDateStr.isEmpty()) {
                res.getWriter().println("<h3>Please select return date</h3>");
                return;
            }

            Date retDate = Date.valueOf(returnDateStr);
            Date dueDate = IssueDAO.getDueDate(issueId);

            if (dueDate == null) {
                res.getWriter().println("<h3>Invalid Issue ID</h3>");
                return;
            }

            long diff = retDate.getTime() - dueDate.getTime();
            int daysLate = (int)(diff / (1000 * 60 * 60 * 24));
            int fine = Math.max(0, daysLate * 10);

            Issue marked = IssueDAO.markAsReturned(issueId, retDate, fine);

            if (marked != null) {
                res.getWriter().println("<div style='font-family: Arial; text-align: center; margin-top: 50px;'>");
                res.getWriter().println("<h2 style='color: #667eea;'>Book Returned Successfully</h2>");
                res.getWriter().println("<h3>Fine: &#8377;" + fine + "</h3>");
                res.getWriter().println("<br><a href='returnBook.jsp' style='padding: 10px 20px; background: #667eea; color: white; text-decoration: none; border-radius: 5px; display: inline-block;'>Back to Return Page</a>");
                res.getWriter().println("</div>");
            } else {
                res.getWriter().println("<h3>Failed to return book. Issue ID might be incorrect or already returned.</h3>");
            }

        } catch(Exception e){
            e.printStackTrace();
            res.getWriter().println("<h3>Error occurred. Check server logs.</h3>");
        }
    }
}