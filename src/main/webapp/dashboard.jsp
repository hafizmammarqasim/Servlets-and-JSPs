<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.ammar.expenseManagerDemo.model.User" %>

<%
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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-color: #4e73df;
            --background-color: #f8f9fc;
            --card-bg: #ffffff;
            --text-dark: #5a5c69;
            --success-bg: #d4edda;
            --success-text: #155724;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--background-color);
            margin: 0;
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

        .navbar h2 { margin: 0; font-size: 1.5rem; }
        .btn-logout { color: white; text-decoration: none; font-size: 0.9rem; opacity: 0.8; transition: 0.3s; }
        .btn-logout:hover { opacity: 1; text-decoration: underline; }

        /* Container */
        .main-container {
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .card {
            background: var(--card-bg);
            border-radius: 10px;
            box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
            padding: 30px;
        }

        /* Header Section inside Card */
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }

        h3 { margin: 0; color: var(--primary-color); }

        /* The "Add New" Button */
        .btn-add-new {
            background-color: var(--primary-color);
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-weight: 500;
            transition: background 0.3s;
            display: inline-block;
        }
        .btn-add-new:hover { background-color: #2e59d9; }

        /* Table Styles */
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th { background-color: #f8f9fc; color: var(--primary-color); padding: 15px; text-align: left; border-bottom: 2px solid #e3e6f0; }
        td { padding: 15px; border-bottom: 1px solid #e3e6f0; }
        tr:hover { background-color: #fafafa; }

        .category-badge {
            background-color: #eaecf4;
            color: #5a5c69;
            padding: 5px 12px;
            border-radius: 15px;
            font-size: 0.85rem;
            font-weight: 500;
        }

        .amount-cell { font-weight: 600; color: var(--text-dark); text-align: right; }
        .empty-state { text-align: center; color: #888; margin: 40px 0; }
    </style>
</head>
<body>

    <div class="navbar">
        <h2>SpendSmart 💸</h2>
        <div>
            <span style="margin-right: 15px; font-size: 0.9rem;">Hello, <%= user.getUserName() %></span>
            <a href="auth?action=logout" class="btn-logout">Logout</a>
        </div>
    </div>

    <div class="main-container">

        <!-- Success Notification -->
        <c:if test="${not empty sessionScope.msg}">
            <div style="background: #d4edda; color: #155724; padding: 15px; border-radius: 5px; margin-bottom: 20px; border: 1px solid #c3e6cb;">
                ${sessionScope.msg}
            </div>
            <c:remove var="msg" scope="session"/>
        </c:if>

        <div class="card">
            <div class="card-header">
                <h3>Transaction History</h3>
                <!-- This link goes to CategoryServlet (doGet) which loads addExpense.jsp -->
                <a href="category" class="btn-add-new">+ Add Expense</a>
            </div>

            <c:if test="${empty expenseList}">
                <div class="empty-state">
                    <h3>No expenses yet!</h3>
                    <p>Click the button above to track your first expense.</p>
                </div>
            </c:if>

            <c:if test="${not empty expenseList}">
                <table>
                    <thead>
                        <tr>
                            <th>Date</th>
                            <th>Category</th>
                            <th>Description</th>
                            <th style="text-align: right;">Amount (PKR)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${expenseList}" var="ex">
                            <tr>
                                <td style="color: #858796;">${ex.entryDate}</td>
                                <td><span class="category-badge">${ex.categoryName}</span></td>
                                <td>${ex.description}</td>
                                <td class="amount-cell">${ex.amount}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>

</body>
</html>