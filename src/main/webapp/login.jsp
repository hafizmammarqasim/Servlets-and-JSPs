<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login - SpendSmart</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-color: #4e73df;
            --background-color: #f8f9fc;
            --text-color: #5a5c69;
            --error-bg: #fadbd8;
            --error-text: #721c24;
            --success-bg: #d4edda;
            --success-text: #155724;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--background-color);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: var(--text-color);
        }

        .card {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        h2 {
            color: var(--primary-color);
            margin-bottom: 20px;
            font-weight: 600;
        }

        form {
            display: flex;
            flex-direction: column;
            text-align: left;
        }

        label {
            font-size: 0.9rem;
            font-weight: 500;
            margin-bottom: 5px;
            margin-top: 15px;
        }

        input {
            padding: 12px;
            border: 1px solid #d1d3e2;
            border-radius: 5px;
            font-size: 1rem;
            font-family: inherit;
            outline: none;
            transition: border-color 0.3s;
        }

        input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(78, 115, 223, 0.2);
        }

        button {
            margin-top: 30px;
            padding: 12px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
        }

        button:hover {
            background-color: #2e59d9;
        }

        .link-container {
            margin-top: 20px;
            font-size: 0.9rem;
        }

        a {
            color: var(--primary-color);
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        /* Message Styles */
        .message-box p {
            margin: 0;
            padding: 10px;
            border-radius: 5px;
            font-size: 0.9rem;
            margin-bottom: 15px;
        }
        .error {
            background-color: var(--error-bg);
            color: var(--error-text);
            border: 1px solid #f5c6cb;
        }
        .success {
            background-color: var(--success-bg);
            color: var(--success-text);
            border: 1px solid #c3e6cb;
        }
    </style>
</head>
<body>
    <div class="card">
        <h2>Welcome Back</h2>

        <!-- Display messages area -->
        <div class="message-box">
            <%
                String msg = request.getParameter("msg");
                if("registered".equals(msg)) {
                    out.print("<p class='success'>Registration Successful! Please Login.</p>");
                } else if("invalid".equals(msg)) {
                    out.print("<p class='error'>Invalid Email or Password.</p>");
                } else if("logout".equals(msg)) {
                    out.print("<p class='success'>Logout Successful.</p>");
                }
            %>
        </div>

        <form action="auth" method="post">
            <input type="hidden" name="action" value="login">

            <label>Username</label>
            <input type="text" name="userName" required>

            <label>Password</label>
            <input type="password" name="password" required>

            <button type="submit">Login</button>
        </form>

        <div class="link-container">
            <a href="register.jsp">Create New Account</a>
        </div>
    </div>
</body>
</html>