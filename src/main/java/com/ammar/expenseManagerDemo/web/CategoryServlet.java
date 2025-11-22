package com.ammar.expenseManagerDemo.web;

import com.ammar.expenseManagerDemo.dao.CategoryDAO;
import com.ammar.expenseManagerDemo.model.Category;
import com.ammar.expenseManagerDemo.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException{
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if(user == null){
            response.sendRedirect("login.jsp");
            return;
        }

        CategoryDAO catDAO = new CategoryDAO();
        Category category = new Category();
        String categoryName = request.getParameter("categoryName");
        category.setCategoryName(categoryName);
        category.setUserId(user.getUserId());
        boolean flag = catDAO.addCategory(category);
        String msg = "";
        if(flag){
            msg = "Category '"+categoryName+"' added successfully";
        } else {
            msg = "Error in saving the category";
        }
        session.setAttribute("msg",msg);
        //We need to reload things before the dashboard loads
        response.sendRedirect("category");

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if(user == null){
            response.sendRedirect("login.jsp");
            return;
        }

        CategoryDAO catDAO = new CategoryDAO();
        List<Category> categories = catDAO.getCategories(user.getUserId());
        request.setAttribute("categoryList",categories);

        request.getRequestDispatcher("addExpense.jsp").forward(request,response);

    }
}
