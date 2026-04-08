<style>
body { font-family: Arial; background:#f2f2f2; text-align:center; }
form { background:white; padding:20px; margin:20px auto; width:300px; }
button { padding:10px; background:#007bff; color:white; border:none; }
</style>
<h2>Return Book</h2>

<form action="ReturnServlet" method="post">
    Issue ID: <input type="text" name="issue_id"><br><br>
    Return Date: <input type="date" name="return_date" required><br><br>

    <button type="submit">Return</button>
</form>