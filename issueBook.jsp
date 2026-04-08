<style>
body { font-family: Arial; background:#f2f2f2; text-align:center; }
form { background:white; padding:20px; margin:20px auto; width:300px; }
button { padding:10px; background:#007bff; color:white; border:none; }
</style>
<h2>Issue Book</h2>

<form action="IssueServlet" method="post">
    Student ID: <input type="text" name="student_id"><br><br>
    Book ID: <input type="text" name="book_id"><br><br>
    Issue Date: <input type="date" name="issue_date"><br><br>

    <button type="submit">Issue</button>
</form>
<%
String issueId = request.getParameter("issueId");
if(issueId != null){
%>
    <h3 style="color:green;">Book Issued Successfully!</h3>
    <p>Your Issue ID is: <b><%= issueId %></b></p>
<%
}
%>