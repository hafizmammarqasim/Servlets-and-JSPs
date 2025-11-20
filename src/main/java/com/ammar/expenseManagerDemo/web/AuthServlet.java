package com.ammar.expenseManagerDemo.web;
import com.ammar.expenseManagerDemo.dao.UserDAO;
import com.ammar.expenseManagerDemo.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet{

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException{

        String input = request.getParameter("action");
        UserDAO dao = new UserDAO();
        if("register".equals(input)){
            String userName = request.getParameter("userName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            User user = new User();
            user.setUserName(userName);
            user.setEmail(email);
            user.setPassword(password);

            //Saving user in the database through User Data Access Object Class
            if(dao.saveUser(user)){
                response.sendRedirect("login.jsp?msg=registered");
            } else{
                response.sendRedirect("register.jsp?msg=error");
            }
        } else if("login".equals(input)){
            String userName = request.getParameter("userName");
            String password = request.getParameter("password");

           User user = dao.LoginUser(userName,password);

           if(user!=null){
               //Create Session and go to Dashboard
               HttpSession session = request.getSession();
               session.setAttribute("user",user);
               response.sendRedirect("expenses");
           } else{
               response.sendRedirect("login.jsp?msg=invalid");
           }

        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException{
        String input = request.getParameter("action");
        if("logout".equals(input)){
            HttpSession session = request.getSession();
            session.removeAttribute("user");
            session.invalidate(); //Kill Session
            response.sendRedirect("login.jsp?msg=logout");
        }
    }
}
