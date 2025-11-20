package com.ammar.expenseManagerDemo.dao;

import com.ammar.expenseManagerDemo.model.Category;
import com.ammar.expenseManagerDemo.util.DBConnection;

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
}
