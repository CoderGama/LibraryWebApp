package dao;

import java.sql.*;
import java.util.*;
import java.sql.Date;
import model.Issue;
import model.Book;

public class IssueDAO {
    
    // In-memory store for issued books (used when DB is not connected)
    private static List<Issue> mockIssues = new ArrayList<>();
    private static int nextIssueId = 1001;

    public static int issueBook(Issue issue) throws Exception {
        Connection con = DBConnection.getConnection();
        
        if (con == null) {
            System.out.println("[WARNING] DB CONNECTION FAILED - Saving issue to mock data.");
            
            // Try to find the book title from Mock DB
            try {
                List<Book> books = BookDAO.getAllBooks();
                for (Book b : books) {
                    if (b.getId() == issue.getBookId()) {
                        issue.setBookTitle(b.getTitle());
                        break;
                    }
                }
            } catch (Exception e) {}
            
            if(issue.getBookTitle() == null) {
                issue.setBookTitle("Unknown Book (ID: " + issue.getBookId() + ")");
            }

            issue.setIssueId(nextIssueId++);
            mockIssues.add(issue);
            return issue.getIssueId();
        }

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO issue(student_id, book_id, issue_date, due_date) VALUES (?, ?, ?, DATE_ADD(?, INTERVAL 7 DAY))",
            Statement.RETURN_GENERATED_KEYS
        );
        ps.setInt(1, issue.getStudentId());
        ps.setInt(2, issue.getBookId());
        ps.setDate(3, issue.getIssueDate());
        ps.setDate(4, issue.getIssueDate());

        ps.executeUpdate();
        ResultSet rs = ps.getGeneratedKeys();
        int issueId = 0;
        if (rs.next()) {
            issueId = rs.getInt(1);
        }
        
        rs.close();
        ps.close();
        con.close();
        
        return issueId;
    }

    public static Issue markAsReturned(int issueId, Date returnDate, int fine) throws Exception {
        Connection con = DBConnection.getConnection();
        
        if (con == null) {
            System.out.println("[WARNING] DB CONNECTION FAILED - Marking return in mock data.");
            for (Issue issue : mockIssues) {
                if (issue.getIssueId() == issueId && issue.getReturnDate() == null) {
                    issue.setReturnDate(returnDate);
                    issue.setFine(fine);
                    return issue;
                }
            }
            // Issue not found in memory (e.g. after Tomcat restart) — still allow return gracefully
            System.out.println("[INFO] Issue ID " + issueId + " not in memory (restart?). Allowing return anyway.");
            Issue ghost = new Issue();
            ghost.setIssueId(issueId);
            ghost.setReturnDate(returnDate);
            ghost.setFine(fine);
            return ghost;
        }

        PreparedStatement ps2 = con.prepareStatement("UPDATE issue SET return_date=?, fine=? WHERE issue_id=?");
        ps2.setDate(1, returnDate);
        ps2.setInt(2, fine);
        ps2.setInt(3, issueId);
        ps2.executeUpdate();
        ps2.close();
        con.close();
        
        return new Issue(); // Just returning a non-null object to indicate success
    }

    public static Date getDueDate(int issueId) throws Exception {
        Connection con = DBConnection.getConnection();
        
        if (con == null) {
            for (Issue issue : mockIssues) {
                if (issue.getIssueId() == issueId) {
                    return issue.getDueDate();
                }
            }
            // Issue not found in memory (e.g. after Tomcat restart) — return today so fine = 0
            System.out.println("[INFO] Issue ID " + issueId + " not in memory. Returning today as due date.");
            return new Date(System.currentTimeMillis());
        }

        PreparedStatement ps1 = con.prepareStatement("SELECT due_date FROM issue WHERE issue_id=?");
        ps1.setInt(1, issueId);
        ResultSet rs = ps1.executeQuery();
        Date dueDate = null;
        if (rs.next()) {
            dueDate = rs.getDate("due_date");
        }
        rs.close();
        ps1.close();
        con.close();
        
        return dueDate;
    }

    public static List<Issue> getPendingIssues() throws Exception {
        Connection con = DBConnection.getConnection();
        List<Issue> list = new ArrayList<>();
        
        if (con == null) {
            for (Issue issue : mockIssues) {
                if (issue.getReturnDate() == null) {
                    list.add(issue);
                }
            }
            return list;
        }

        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery(
            "SELECT i.issue_id, i.student_id, i.book_id, b.title as book_title, i.issue_date, i.due_date " +
            "FROM issue i " +
            "JOIN book b ON i.book_id = b.id " +
            "WHERE i.return_date IS NULL " +
            "ORDER BY i.issue_id DESC"
        );

        while (rs.next()) {
            Issue issue = new Issue();
            issue.setIssueId(rs.getInt("issue_id"));
            issue.setStudentId(rs.getInt("student_id"));
            issue.setBookId(rs.getInt("book_id"));
            issue.setBookTitle(rs.getString("book_title"));
            issue.setIssueDate(rs.getDate("issue_date"));
            issue.setDueDate(rs.getDate("due_date"));
            list.add(issue);
        }
        
        rs.close();
        st.close();
        con.close();

        return list;
    }
}
