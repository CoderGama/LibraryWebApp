<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management System - Login</title>
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
        footer { background: rgba(0,0,0,0.2); color: white; text-align: center; padding: 20px; margin-top: 50px; }
        .text-center { text-align: center; }
        .mt-20 { margin-top: 20px; }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div class="header-title">Library Management System</div>
        </div>
    </header>

    <main>
        <div class="container">
            <div class="content-wrapper">
                <h2>Login to Your Account</h2>
                
                <form action="LoginServlet" method="post">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" placeholder="Enter your username" required>
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" placeholder="Enter your password" required>
                    </div>

                    <button type="submit" class="btn">Login</button>
                </form>

                <div class="text-center mt-20">
                    <p style="color: #666;">Don't have an account? Contact your administrator.</p>
                </div>
            </div>
        </div>
    </main>

    <footer>
        <p>&copy; 2024 Library Management System. All rights reserved.</p>
    </footer>
</body>
</html>