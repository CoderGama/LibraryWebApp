<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Library Management System</title>
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
        h1 { font-size: 32px; text-align: center; }
        h2 { font-size: 28px; text-align: center; border-bottom: 3px solid #667eea; padding-bottom: 15px; }
        .dashboard-nav { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 25px; margin-top: 40px; }
        .nav-card { background: white; border-radius: 10px; padding: 30px; text-align: center; box-shadow: 0 4px 15px rgba(0,0,0,0.1); transition: all 0.3s; text-decoration: none; color: inherit; border: 2px solid transparent; }
        .nav-card:hover { transform: translateY(-8px); box-shadow: 0 8px 25px rgba(0,0,0,0.15); border-color: #667eea; }
        .nav-card-icon { font-size: 48px; margin-bottom: 15px; display: block; }
        .nav-card h3 { margin-bottom: 10px; color: #667eea; }
        .nav-card p { color: #666; font-size: 14px; }
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
                <h1>Welcome to Dashboard</h1>
                <p style="text-align: center; color: #666; margin-bottom: 40px;">
                    Manage your library operations efficiently
                </p>

                <div class="dashboard-nav">
                    <a href="addBook.jsp" class="nav-card">
                        <span class="nav-card-icon">+</span>
                        <h3>Add Book</h3>
                        <p>Add new books to the library collection</p>
                    </a>

                    <a href="viewBooks.jsp" class="nav-card">
                        <span class="nav-card-icon">B</span>
                        <h3>View Books</h3>
                        <p>Browse all available books in the library</p>
                    </a>

                    <a href="issueBook.jsp" class="nav-card">
                        <span class="nav-card-icon">I</span>
                        <h3>Issue Book</h3>
                        <p>Issue books to students</p>
                    </a>

                    <a href="returnBook.jsp" class="nav-card">
                        <span class="nav-card-icon">R</span>
                        <h3>Return Book</h3>
                        <p>Process book returns</p>
                    </a>
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