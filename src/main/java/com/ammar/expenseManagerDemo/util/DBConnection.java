package com.ammar.expenseManagerDemo.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String userName = "expenseManager";
    private static final String password = "expense123";
    private static final String url = "jdbc:sqlserver://localhost:1433;databaseName=expenseManagerDemo;encrypt=true;trustServerCertificate=true;";

    public static Connection getConnection(){
        Connection conn = null;

        try{
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(url,userName,password);
            System.out.println("Connection Successful");
        } catch(ClassNotFoundException | SQLException ex){
            ex.printStackTrace();
        }

        return conn;
    }
}
