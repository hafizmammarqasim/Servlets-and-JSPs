<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.ammar.expenseManagerDemo.model.User" %>

<%
    // Security Check
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SpendSmart Dashboard</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-color: #4e73df;
            --secondary-color: #858796;
            --success-color: #1cc88a;
            --background-color: #f8f9fc;
            --card-bg: #ffffff;
            --text-dark: #5a5c69;
            --border-radius: 10px;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--background-color);
            margin: 0;
            padding: 0;
            color: var(--text-dark);
        }

        /* Navbar */
        .navbar {
            background-color: var(--primary-color);
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .navbar h2 { margin: 0; font-weight: 500; font-size: 1.5rem; }

        .btn-logout {
            background-color: rgba(255,255,255,0.2);
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 0.9rem;
            transition: background 0.3s;
        }
        .btn-logout:hover { background-color: rgba(255,255,255,0.4); }

        /* Main Layout */
        .main-container {
            display: flex;
            gap: 30px;
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
            flex-wrap: wrap; /* Makes it responsive */
        }

        /* Cards */
        .card {
            background: var(--card-bg);
            border-radius: var(--border-radius);
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            padding: 30px;
        }

        .left-panel { flex: 1; min-width: 300px; }
        .right-panel { flex: 2; min-width: 400px; }

        h3 {
            margin-top: 0;
            color: var(--primary-color);
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        /* Form Styles */
        label { font-weight: 500; font-size: 0.9rem; margin-bottom: 5px; display: block; }

        input[type="text"], input[type="number"], input[type="date"], select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #d1d3e2;
            border-radius: 5px;
            font-family: inherit;
            box-sizing: border-box; /* Fixes padding width issues */
        }

        input:focus, select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(78, 115, 223, 0.25);
        }

        .btn-submit {
            width: 100%;
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.3s;
            font-weight: 600;
        }

        .btn-submit:hover { background-color: #2e59d9; }

        /* Table Styles */
        table { width: 100%; border-collapse: collapse; }

        th {
            background-color: #f8f9fc;
            color: var(--primary-color);
            font-weight: 600;
            padding: 12px 15px;
            text-align: left;
            border-bottom: 2px solid #e3e6f0;
        }

        td {
            padding: 12px 15px;
            border-bottom: 1px solid #e3e6f0;
            vertical-align: middle;
        }

        tr:hover { background-color: #fafafa; }

        .amount-cell {
            font-weight: 600;
            color: var(--text-dark);
        }

        .date-cell { color: #858796; font-size: 0.9rem; }

        .category-badge {
            background-color: #eaecf4;
            color: #5a5c69;
            padding: 4px 10px;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        /* Alerts */
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            border: 1px solid #c3e6cb;
            text-align: center;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <h2>SpendSmart 💸</h2>
        <div>
            <span style="margin-right: 15px; font-size: 0.9rem;">Hello, <%= user.getUserName() %></span>
            <a href="auth?action=logout" class="btn-logout">Logout</a>
        </div>
    </div>

    <div class="main-container">

        <!-- Success Message Notification -->
        <c:if test="${not empty sessionScope.msg}">
            <div style="width: 100%;">
                <div class="alert-success">
                    ${sessionScope.msg}
                </div>
                <c:remove var="msg" scope="session"/>
            </div>
        </c:if>

        <!-- LEFT SIDE: ADD FORM -->
        <div class="card left-panel">
            <h3>Add New Expense</h3>
            <form action="expenses" method="post">
                <label>Category</label>
                <select name="categoryId" required>
                    <option value="">Select a Category...</option>
                    <c:forEach items="${categoryList}" var="c">
                        <option value="${c.categoryId}">${c.categoryName}</option>
                    </c:forEach>
                </select>

                <label>Description</label>
                <input type="text" name="description" placeholder="e.g. Lunch, Uber, Rent" required>

                <label>Amount ($)</label>
                <input type="number" name="amount" placeholder="0.00" required>

                <label>Date</label>
                <input type="date" name="entryDate" required>

                <button type="submit" class="btn-submit">Save Expense</button>
            </form>
        </div>

        <!-- RIGHT SIDE: TABLE -->
        <div class="card right-panel">
            <h3>Transaction History</h3>

            <!-- Check if list is empty -->
            <c:if test="${empty expenseList}">
                <p style="text-align: center; color: #888; margin-top: 20px;">No expenses found. Add one to get started!</p>
            </c:if>

            <c:if test="${not empty expenseList}">
                <table>
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Category</th>
                            <th>Description</th>
                            <th style="text-align: right;">Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${expenseList}" var="ex">
                            <tr>
                                <td class="date-cell">${ex.entryDate}</td>
                                <td><span class="category-badge">${ex.categoryName}</span></td>
                                <td>${ex.description}</td>
                                <td class="amount-cell" style="text-align: right;">$${ex.amount}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>

</body>
</html>