<style>
body { font-family: Arial; background:#f2f2f2; text-align:center; }
form { background:white; padding:20px; margin:20px auto; width:300px; }
button { padding:10px; background:#007bff; color:white; border:none; }
</style>
<h2>Login</h2>

<form action="LoginServlet" method="post">
    Username: <input type="text" name="username"><br><br>
    Password: <input type="password" name="password"><br><br>
    <button type="submit">Login</button>
</form>