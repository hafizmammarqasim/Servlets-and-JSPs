<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - SpendSmart</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-color: #4e73df;
            --background-color: #f8f9fc;
            --text-color: #5a5c69;
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
            margin-bottom: 30px;
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
    </style>
</head>

<body>
    <div class="card">
        <h2>Create Account</h2>

        <form action="auth" method="post">
            <input type="hidden" name="action" value="register">

            <label for="userName">Username</label>
            <input type="text" name="userName" id="userName" required>

            <label for="email">Email Address</label>
            <input type="email" name="email" id="email" required>

            <label for="password">Password</label>
            <input type="password" name="password" id="password" required>

            <button type="submit">Register</button>
        </form>

        <div class="link-container">
            <a href="login.jsp">Already have an account? Login here</a>
        </div>
    </div>
</body>
</html>