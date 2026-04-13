<%@ page import="dao.IssueDAO, model.Issue, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Return Book - Library Management System</title>
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
        
        .split-layout { display: grid; grid-template-columns: 350px 1fr; gap: 30px; margin-bottom: 40px; }
        .sidebar, .main-form-panel { background: white; border-radius: 10px; padding: 30px; box-shadow: 0 8px 32px rgba(0,0,0,0.1); }
        
        h1, h2, h3 { color: #667eea; margin-bottom: 25px; font-weight: 600; }
        h2 { font-size: 24px; text-align: center; border-bottom: 3px solid #667eea; padding-bottom: 15px; margin-bottom: 20px;}
        form { max-width: 500px; margin: 20px auto; display: flex; flex-direction: column; }
        .form-group { margin-bottom: 20px; display: flex; flex-direction: column; }
        label { font-weight: 600; color: #333; margin-bottom: 8px; font-size: 14px; text-transform: uppercase; letter-spacing: 0.5px; }
        input { padding: 12px 15px; border: 2px solid #e0e0e0; border-radius: 5px; font-size: 14px; font-family: inherit; transition: all 0.3s; width: 100%;}
        input:focus { outline: none; border-color: #667eea; box-shadow: 0 0 0 3px rgba(102,126,234,0.1); }
        button, .btn { padding: 12px 30px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 5px; font-size: 15px; font-weight: 600; cursor: pointer; transition: all 0.3s; text-decoration: none; display: block; text-align: center; width: 100%;}
        button:hover, .btn:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(102,126,234,0.4); }
        .btn.secondary { background: #f0f0f0; color: #333; border: 2px solid #ddd; margin-top: 10px; }
        .btn.secondary:hover { border-color: #667eea; background: #f9f9f9; }
        footer { background: rgba(0,0,0,0.2); color: white; text-align: center; padding: 20px; margin-top: 50px; }
        
        /* Sidebar styles */
        .issue-card { border: 1px solid #e0e0e0; border-radius: 8px; padding: 15px; margin-bottom: 15px; cursor: pointer; transition: all 0.2s; border-left: 4px solid #667eea; }
        .issue-card:hover { transform: translateX(5px); box-shadow: 0 4px 10px rgba(0,0,0,0.05); border-left-color: #764ba2; }
        .issue-card h4 { margin: 0 0 5px 0; color: #333; font-size: 15px; font-weight: 600; line-height: 1.3;}
        .issue-card p { margin: 3px 0; font-size: 13px; color: #666; }
        .issue-card .badge { display: inline-block; padding: 2px 8px; background: #e0eafc; color: #4a90e2; border-radius: 12px; font-size: 11px; font-weight: bold; margin-top: 5px; }
        .empty-state { text-align: center; color: #888; padding: 30px 10px; font-style: italic; }
        .scrollable-list { max-height: 500px; overflow-y: auto; padding-right: 10px; }
        .scrollable-list::-webkit-scrollbar { width: 6px; }
        .scrollable-list::-webkit-scrollbar-track { background: #f1f1f1; border-radius: 10px; }
        .scrollable-list::-webkit-scrollbar-thumb { background: #ccc; border-radius: 10px; }
        .scrollable-list::-webkit-scrollbar-thumb:hover { background: #aaa; }
        
        @media(max-width: 800px) {
            .split-layout { grid-template-columns: 1fr; }
        }
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
            <div class="split-layout">
                <div class="sidebar">
                    <h2>Pending Issues</h2>
                    <p style="text-align: center; color: #666; margin-bottom: 20px; font-size: 14px;">Select a book below to return</p>
                    
                    <div class="scrollable-list">
                        <%
                            try {
                                List<Issue> issues = IssueDAO.getPendingIssues();
                                if (issues == null || issues.isEmpty()) {
                        %>
                                    <div class="empty-state">No pending books to return.</div>
                        <%
                                } else {
                                    for (Issue issue : issues) {
                        %>
                                        <div class="issue-card" onclick="selectIssue(<%= issue.getIssueId() %>)">
                                            <h4><%= issue.getBookTitle() %></h4>
                                            <p><strong>Student ID:</strong> <%= issue.getStudentId() %></p>
                                            <p><strong>Issue ID:</strong> <%= issue.getIssueId() %></p>
                                            <p><strong>Issued on:</strong> <%= issue.getIssueDate() %></p>
                                            <div class="badge">Due: <%= issue.getDueDate() %></div>
                                        </div>
                        <%
                                    }
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                        %>
                                <div class="empty-state">Unable to load pending issues.</div>
                        <%  } %>
                    </div>
                </div>
                
                <div class="main-form-panel">
                    <h2>Return Book</h2>
                    <p style="text-align: center; color: #666; margin-bottom: 30px;">
                        Record a book return transaction
                    </p>

                    <form action="ReturnServlet" method="post">
                        <div class="form-group">
                            <label for="issue_id">Issue ID</label>
                            <input type="text" id="issue_id" name="issue_id" placeholder="Enter the issue ID" required>
                        </div>

                        <div class="form-group">
                            <label for="return_date">Return Date</label>
                            <input type="date" id="return_date" name="return_date" required>
                        </div>

                        <button type="submit" class="btn">Process Return</button>
                        <a href="dashboard.jsp" class="btn secondary">Back to Dashboard</a>
                    </form>
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

        // Auto-fill form when a card is clicked
        function selectIssue(issueId) {
            document.getElementById('issue_id').value = issueId;
            // Provide a quick feedback effect
            const issueInput = document.getElementById('issue_id');
            issueInput.style.backgroundColor = '#e0eafc';
            setTimeout(() => {
                issueInput.style.backgroundColor = 'white';
            }, 300);
        }

        // Set today's date as default
        document.getElementById('return_date').valueAsDate = new Date();
    </script>
</body>
</html>