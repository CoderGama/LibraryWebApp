<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Issue Book - Library Management System</title>
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
        form { max-width: 500px; margin: 30px auto; display: flex; flex-direction: column; }
        .form-group { margin-bottom: 20px; display: flex; flex-direction: column; }
        label { font-weight: 600; color: #333; margin-bottom: 8px; font-size: 14px; text-transform: uppercase; letter-spacing: 0.5px; }
        input { padding: 12px 15px; border: 2px solid #e0e0e0; border-radius: 5px; font-size: 14px; font-family: inherit; transition: all 0.3s; }
        input:focus { outline: none; border-color: #667eea; box-shadow: 0 0 0 3px rgba(102,126,234,0.1); }
        button, .btn { padding: 12px 30px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 5px; font-size: 15px; font-weight: 600; cursor: pointer; transition: all 0.3s; text-decoration: none; display: inline-block; text-align: center; }
        button:hover, .btn:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(102,126,234,0.4); }
        .btn.secondary { background: #f0f0f0; color: #333; border: 2px solid #ddd; }
        .btn.secondary:hover { border-color: #667eea; background: #f9f9f9; }
        .alert { padding: 15px 20px; border-radius: 5px; margin-bottom: 20px; display: flex; align-items: center; gap: 15px; }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
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
                <%
                String issueId = request.getParameter("issueId");
                if(issueId != null) {
                %>
                    <div class="alert alert-success" style="margin-bottom: 30px;">
                        <span>SUCCESS</span>
                        <div>
                            <strong>Book Issued Successfully!</strong><br>
                            Your Issue ID is: <strong><%= issueId %></strong>
                        </div>
                    </div>
                <%
                }
                %>

                <h2>Issue Book to Student</h2>
                <p style="text-align: center; color: #666; margin-bottom: 30px;">
                    Record a book issue transaction
                </p>

                <form action="IssueServlet" method="post">
                    <div class="form-group">
                        <label for="student_id">Student ID</label>
                        <input type="text" id="student_id" name="student_id" placeholder="Enter student ID" required>
                    </div>

                    <div class="form-group">
                        <label for="book_id">Book ID</label>
                        <input type="text" id="book_id" name="book_id" placeholder="Enter book ID" required>
                    </div>

                    <div class="form-group">
                        <label for="issue_date">Issue Date</label>
                        <input type="date" id="issue_date" name="issue_date" required>
                    </div>

                    <button type="submit" class="btn">Issue Book</button>
                    <a href="dashboard.jsp" class="btn secondary" style="margin-top: 10px;">Back to Dashboard</a>
                </form>
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

        // Set today's date as default
        document.getElementById('issue_date').valueAsDate = new Date();
    </script>
</body>
</html>