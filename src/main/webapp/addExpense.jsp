<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.ammar.expenseManagerDemo.model.User" %>

<%
    User user = (User) session.getAttribute("user");
    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Transaction - SpendSmart</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-color: #4e73df;
            --primary-light: #eef2ff; /* New soft blue */
            --primary-dark: #2e59d9;
            --text-dark: #5a5c69;
            --background-color: #f8f9fc;
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
        .btn-back { color: white; text-decoration: none; font-size: 0.9rem; opacity: 0.9; transition: 0.3s; }
        .btn-back:hover { opacity: 1; transform: translateX(-5px); display: inline-block; }

        /* Main Layout */
        .main-container {
            max-width: 1050px;
            margin: 40px auto;
            padding: 0 20px;
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
            align-items: flex-start; /* Aligns cards to top */
        }

        /* Card Logic */
        .card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
            padding: 35px;
            transition: transform 0.3s ease;
        }

        /* --- LEFT CARD (Main Form) --- */
        .expense-card {
            flex: 3;
            min-width: 320px;
            border-top: 4px solid var(--primary-color); /* Subtle accent on top */
        }

        /* --- RIGHT CARD (Category) --- */
        .category-card {
            flex: 2;
            min-width: 280px;
            background-color: #ffffff;
            border: 1px solid #e3e6f0; /* Subtle border */
            position: relative;
            overflow: hidden;
        }

        /* Decorative circle behind category icon */
        .category-card::before {
            content: '';
            position: absolute;
            top: -20px;
            right: -20px;
            width: 100px;
            height: 100px;
            background: var(--primary-light);
            border-radius: 50%;
            z-index: 0;
        }

        h3 { margin: 0 0 25px 0; color: var(--primary-color); font-weight: 600; }

        /* Inputs */
        label { font-weight: 500; font-size: 0.9rem; margin-bottom: 8px; display: block; color: #444; }

        input, select {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #d1d3e2;
            border-radius: 8px; /* Softer corners */
            font-family: inherit;
            box-sizing: border-box;
            transition: 0.2s;
            font-size: 0.95rem;
        }

        input:focus, select:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 4px rgba(78, 115, 223, 0.1);
        }

        /* --- BUTTONS --- */

        /* Main Submit Button */
        .btn-submit {
            width: 100%;
            background: linear-gradient(45deg, var(--primary-color), var(--primary-dark));
            color: white;
            border: none;
            padding: 14px;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(78, 115, 223, 0.3);
            transition: 0.3s;
        }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(78, 115, 223, 0.4); }

        /* Category Button (The Fix) */
        .btn-soft {
            width: 100%;
            background-color: var(--primary-light); /* Light Blue Background */
            color: var(--primary-dark); /* Dark Blue Text */
            border: 1px solid transparent;
            padding: 12px;
            border-radius: 8px;
            font-size: 0.95rem;
            cursor: pointer;
            font-weight: 600;
            transition: 0.3s;
            position: relative;
            z-index: 1;
        }

        .btn-soft:hover {
            background-color: var(--primary-color);
            color: white;
            transform: translateY(-1px);
        }

        /* Header inside Category Card */
        .cat-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
            position: relative;
            z-index: 1;
        }
        .cat-header span { font-size: 1.5rem; }
        .cat-header h4 { margin: 0; font-size: 1.1rem; color: #333; }

        .helper-text {
            font-size: 0.85rem;
            color: #858796;
            margin-bottom: 20px;
            line-height: 1.5;
            position: relative;
            z-index: 1;
        }

        /* Alerts */
        .alert-box {
            width: 100%;
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            border: 1px solid #c3e6cb;
            display: flex;
            align-items: center;
            font-weight: 500;
        }
        .alert-box::before { content: '✅'; margin-right: 10px; }
    </style>
</head>
<body>

    <div class="navbar">
        <h2>SpendSmart 💸</h2>
        <a href="expenses" class="btn-back">← Back to Dashboard</a>
    </div>

    <div class="main-container">

        <!-- Global Success Message -->
        <c:if test="${not empty sessionScope.msg}">
            <div class="alert-box">
                ${sessionScope.msg}
            </div>
            <c:remove var="msg" scope="session"/>
        </c:if>

        <!-- CARD 1: Add Expense (The Hero) -->
        <div class="card expense-card">
            <h3>Add New Transaction</h3>
            <form action="expenses" method="post">
                <label>Category</label>
                <select name="categoryId" required>
                    <option value="">-- Select Category --</option>
                    <c:forEach items="${categoryList}" var="c">
                        <option value="${c.categoryId}">${c.categoryName}</option>
                    </c:forEach>
                </select>

                <div style="display: flex; gap: 20px;">
                    <div style="flex: 1;">
                        <label>Amount (PKR)</label>
                        <input name="amount" type="number" placeholder="0.00" required>
                    </div>
                    <div style="flex: 1;">
                        <label>Date</label>
                        <input name="entryDate" type="date" required>
                    </div>
                </div>

                <label>Description</label>
                <input name="description" type="text" placeholder="e.g. Lunch with Sarah" required>

                <button type="submit" class="btn-submit">Save Transaction</button>
            </form>
        </div>

        <!-- CARD 2: Add Category (The Stylish Sidekick) -->
        <div class="card category-card">
            <div class="cat-header">
                <span>🏷️</span>
                <h4>New Category</h4>
            </div>

            <p class="helper-text">
                Don't see what you need? Create a custom tag to organize your spending better.
            </p>

            <form action="category" method="post">
                <label>Category Name</label>
                <input type="text" name="categoryName" placeholder="e.g. Netflix, Gym, Crypto" required>

                <button type="submit" class="btn-soft">Create Tag</button>
            </form>
        </div>

    </div>

</body>
</html>