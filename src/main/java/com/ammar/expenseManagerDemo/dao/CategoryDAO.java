package com.ammar.expenseManagerDemo.dao;

import com.ammar.expenseManagerDemo.model.Category;
import com.ammar.expenseManagerDemo.util.DBConnection;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    public List<Category> getCategories(int userId) {
        List<Category> categories = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String query = "Select * from Categories where userId = ?";

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Category c = new Category();
                c.setCategoryId(rs.getInt("categoryId"));
                c.setCategoryName(rs.getString("categoryName"));
                c.setUserId(rs.getInt("userId"));
                categories.add(c);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return categories;
    }

    public boolean addCategory(Category category){
        try{
            Connection conn = DBConnection.getConnection();
            String query = "Insert into Categories(categoryName, userId) values(?,?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1,category.getCategoryName());
            ps.setInt(2,category.getUserId());
            int f = ps.executeUpdate();

            if(f > 0)
                return true;

        } catch (SQLException ex){
            ex.printStackTrace();
        }
        return false;
    }
}
