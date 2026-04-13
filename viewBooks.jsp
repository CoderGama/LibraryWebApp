<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Books - Library Management System</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; color: #333; }
        header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 20px 0; box-shadow: 0 4px 6px rgba(0,0,0,0.1); margin-bottom: 30px; }
        .container { max-width: 1200px; margin: 0 auto; padding: 0 20px; }
        header .container { display: flex; justify-content: space-between; align-items: center; }
        .header-title { font-size: 28px; font-weight: bold; letter-spacing: 1px; }
        .nav-links { display: flex; gap: 20px; list-style: none; }
        .nav-links a { color: white; text-decoration: none; padding: 8px 15px; border-radius: 5px; transition: all 0.3s; font-weight: 500; }
        .nav-links a:hover { background: rgba(255,255,255,0.2); transform: translateY(-2px); }
        main { min-height: calc(100vh - 200px); }
        .content-wrapper { background: white; border-radius: 10px; padding: 40px; box-shadow: 0 8px 32px rgba(0,0,0,0.1); margin-bottom: 40px; }
        h1, h2, h3 { color: #667eea; margin-bottom: 25px; font-weight: 600; }
        h2 { font-size: 28px; text-align: center; border-bottom: 3px solid #667eea; padding-bottom: 15px; }
        .cards-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; margin: 30px 0; }
        .card { background: white; border-radius: 10px; padding: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); transition: all 0.3s; border: 2px solid #f0f0f0; }
        .card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.15); border-color: #667eea; }
        .card b { color: #667eea; display: block; margin-top: 12px; }
        .card a { color: #667eea; text-decoration: none; }
        .card a:hover { text-decoration: underline; }
        .alert { padding: 15px 20px; border-radius: 5px; margin-bottom: 20px; display: flex; align-items: center; gap: 15px; }
        .alert-info { background: #d1ecf1; color: #0c5460; border: 1px solid #bee5eb; }
        .alert-error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .btn, button { padding: 12px 30px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 5px; font-size: 15px; font-weight: 600; cursor: pointer; transition: all 0.3s; text-decoration: none; display: inline-block; text-align: center; }
        .btn:hover, button:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(102,126,234,0.4); }
        .btn.secondary { background: #f0f0f0; color: #333; border: 2px solid #ddd; }
        .btn.secondary:hover { border-color: #667eea; background: #f9f9f9; }
        footer { background: rgba(0,0,0,0.2); color: white; text-align: center; padding: 20px; margin-top: 50px; }
        .text-center { text-align: center; }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div class="header-title">Library Management System</div>
            <ul class="nav-links">
                <li><a href="dashboard.jsp">Dashboard</a></li>
                <li><a href="#" onclick="logout()">Logout</a></li>
            </ul>
        </div>
    </header>

    <main>
        <div class="container">
            <div class="content-wrapper">
                <h2>All Books in Library</h2>

                <%@ page import="java.util.*, dao.BookDAO, model.Book" %>

                <%
                try {
                    List<Book> list = BookDAO.getAllBooks();

                    if (list != null && !list.isEmpty()) {
                %>
                    <p style="text-align: center; color: #666; margin-bottom: 30px;">
                        Total Books: <strong><%= list.size() %></strong>
                    </p>

                    <div class="cards-grid">
                <%
                        for(Book b : list) {
                %>
                        <div class="card">
                            <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 15px; border-radius: 5px 5px 0 0; margin: -20px -20px 15px -20px;">
                                <strong style="font-size: 18px;"><%= b.getTitle() %></strong>
                            </div>
                            <b>Book ID:</b> <span style="color: #667eea; font-weight: bold;"><%= b.getId() %></span>
                            <b>Author ID:</b> <%= b.getAuthorId() %>
                            <b>Category ID:</b> <%= b.getCategoryId() %>
                            <b>Available Copies:</b> 
                            <span style="color: <%= b.getAvailableCopies() > 0 ? "#28a745" : "#dc3545" %>; font-weight: bold;">
                                <%= b.getAvailableCopies() %>
                            </span>
                        </div>
                <%
                        }
                %>
                    </div>
                <%
                    } else {
                %>
                    <div class="alert alert-info">
                        <span>ℹ️</span>
                        <div>No books found in the library. <a href="addBook.jsp">Add books now</a></div>
                    </div>
                <%
                    }
                } catch(Exception e) {
                %>
                    <div class="alert alert-error">
                        <span>❌</span>
                        <div>Error loading books: <%= e.getMessage() %></div>
                    </div>
                <%
                }
                %>

                <div style="margin-top: 30px; text-align: center;">
                    <a href="dashboard.jsp" class="btn secondary">Back to Dashboard</a>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <p>&copy; 2024 Library Management System. All rights reserved.</p>
    </footer>

    <script>
        function logout() {
            if (confirm('Are you sure you want to logout?')) {
                window.location.href = 'index.jsp';
            }
        }
    </script>
</body>
</html>