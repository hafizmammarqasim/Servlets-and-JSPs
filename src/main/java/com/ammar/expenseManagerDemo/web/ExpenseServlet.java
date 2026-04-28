package com.ammar.expenseManagerDemo.web;

import com.ammar.expenseManagerDemo.dao.CategoryDAO;
import com.ammar.expenseManagerDemo.dao.ExpenseDAO;
import com.ammar.expenseManagerDemo.model.Category;
import com.ammar.expenseManagerDemo.model.Expense;
import com.ammar.expenseManagerDemo.model.User;
import jakarta.servlet.Servlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/expenses")
public class ExpenseServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user = (User) request.getSession().getAttribute("user");
        if(user == null){
            response.sendRedirect("login.jsp");
            return;
        }
        CategoryDAO catDAO = new CategoryDAO();
        ExpenseDAO expDAO = new ExpenseDAO();
        List<Category> categories = catDAO.getCategories(user.getUserId());
        List<Expense> expenses = expDAO.getAllExpenses(user.getUserId());

        request.setAttribute("categoryList",categories);
        request.setAttribute("expenseList",expenses);

        try{
            request.getRequestDispatcher("dashboard.jsp").forward(request,response);
            System.out.println("Categories");

        } catch(ServletException ex){
            ex.printStackTrace();
        }

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if(user == null){
            response.sendRedirect("login.jsp");
            return;
        }

        Expense expense = new Expense();
        expense.setDescription(request.getParameter("description"));
        //getParameter returns String, so manually convert to int
        expense.setCategoryId(Integer.parseInt(request.getParameter("categoryId")));
        expense.setAmount(Integer.parseInt(request.getParameter("amount")));
        expense.setEntryDate(Date.valueOf(request.getParameter("entryDate")));
        expense.setUserId(user.getUserId());

        ExpenseDAO expDAO = new ExpenseDAO();
        boolean flag = expDAO.saveExpenses(expense);

        String msg = "";
        if(flag){
            msg = "Success! Record Successfully Updated";
        } else{
            msg = "Oops! Something went wrong";
        }

        session.setAttribute("msg",msg);
        response.sendRedirect("expenses");
    }
}
