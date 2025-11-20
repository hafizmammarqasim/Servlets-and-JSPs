package com.ammar.expenseManagerDemo.dao;

import com.ammar.expenseManagerDemo.model.User;
import com.ammar.expenseManagerDemo.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    User user;

    public boolean saveUser(User user){
       boolean flag = false;

        try{
            Connection conn = DBConnection.getConnection();
            //Query to execute
            String query = "Insert into Users(username,email,password) values (?,?,?)";
            //Preparing statement to execute the query
            PreparedStatement ps = conn.prepareStatement(query);
            //Putting in userSpecified values in place of ? in our query
            ps.setString(1,user.getUserName());
            ps.setString(2,user.getEmail());
            ps.setString(3,user.getPassword());
            //Executing the statement (query)
            int i = ps.executeUpdate();

            if(i>0){
                flag = true;
            }
            //Close the connection
            conn.close();
        } catch (SQLException e){
            e.printStackTrace();
        }
        return flag;
    }


    public User LoginUser(String userName, String password){
        User user = null;
        try{
            Connection conn = DBConnection.getConnection();
            String query = "Select * from Users where userName=? and password=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1,userName);
            ps.setString(2,password);
            ResultSet rs = ps.executeQuery();


            if(rs.next()){
                 user = new User();
                 //User exact column names (as used in db) to retrieve data
                 user.setUserId(rs.getInt("userId"));
                 user.setUserName(rs.getString("userName"));
                 user.setEmail(rs.getString("email"));
                 user.setPassword(rs.getString("password"));

                System.out.println(user.getUserId());
                System.out.println(user.getUserName());
                System.out.println(user.getEmail());
            }
            conn.close();
        } catch (SQLException ex){
            ex.printStackTrace();
        }
        return user;
    }

}
