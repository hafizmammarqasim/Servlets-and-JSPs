package com.ammar.expenseManagerDemo;

import com.ammar.expenseManagerDemo.dao.UserDAO;
import com.ammar.expenseManagerDemo.model.User;
import com.ammar.expenseManagerDemo.util.DBConnection;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {

        DBConnection.getConnection();
        UserDAO dao = new UserDAO();
        User user = dao.LoginUser("ihafizmammar","sp24bse");
        if(user==null) {
            System.out.println("No user Found");
            return;
        }
            System.out.println(user.getUserName());
    }
}