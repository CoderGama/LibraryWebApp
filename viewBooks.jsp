<style>
body { font-family: Arial; background:#f2f2f2; text-align:center; }
.card { background:white; padding:15px; margin:15px auto; width:300px; border-radius:10px; }
</style>

<%@ page import="java.util.*, dao.BookDAO, model.Book" %>

<h2>All Books</h2>

<%
try {
    List<Book> list = BookDAO.getAllBooks();

    for(Book b : list){
%>

<div class="card">
    <b>Book ID:</b> <%= b.getId() %><br>
    <b>Title:</b> <%= b.getTitle() %><br>
    <b>Copies:</b> <%= b.getAvailableCopies() %><br>
    <b>Author ID:</b> <%= b.getAuthorId() %><br>
    <b>Category ID:</b> <%= b.getCategoryId() %>
</div>

<%
    }
} catch(Exception e){
    out.println("Error: " + e.getMessage());
}
%>