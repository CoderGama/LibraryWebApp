<style>
body { font-family: Arial; background:#f2f2f2; text-align:center; }
form { background:white; padding:20px; margin:20px auto; width:300px; }
button { padding:10px; background:#007bff; color:white; border:none; }
</style>
<h2>Add Book</h2>

<form action="BookServlet" method="post">
    <%-- Book ID: <input type="text" name="id"><br><br> --%>
    Title: <input type="text" name="title"><br><br>
    Author ID: <input type="text" name="author_id"><br><br>
    Category ID: <input type="text" name="category_id"><br><br>
    Copies: <input type="text" name="copies"><br><br>

    <button type="submit">Add Book</button>
</form>