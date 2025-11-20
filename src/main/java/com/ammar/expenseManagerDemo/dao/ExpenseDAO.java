package com.ammar.expenseManagerDemo.dao;

import com.ammar.expenseManagerDemo.model.Expense;
import com.ammar.expenseManagerDemo.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ExpenseDAO {
    public List<Expense> getAllExpenses(int userId){

        List<Expense> expenseList = new ArrayList<>();
        try{
            Connection conn = DBConnection.getConnection();
            String query = "Select e.*, c.categoryName from expenses e " +
                    "join categories c on e.categoryId = c.categoryId " +
                    "where e.userId=?";

            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1,userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()){
                Expense expense = new Expense();
                expense.setExpenseId(rs.getInt("expenseId"));
                expense.setDescription(rs.getString("description"));
                expense.setAmount(rs.getInt("amount"));
                expense.setCategoryName(rs.getString("categoryName"));
                expense.setCategoryId(rs.getInt("categoryId"));
                expense.setEntryDate(rs.getDate("entryDate"));
                expenseList.add(expense);
            }
        } catch(SQLException ex){
            ex.printStackTrace();
        }
        return expenseList;
    }

    public boolean saveExpenses(Expense expense){
        try{
            Connection conn = DBConnection.getConnection();
            String query = "insert into expenses(description, amount, entryDate, categoryId, userId) values(?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1,expense.getDescription());
            ps.setInt(2,expense.getAmount());
            ps.setDate(3,expense.getEntryDate());
            ps.setInt(4,expense.getCategoryId());
            ps.setInt(5,expense.getUserId());

            int i = ps.executeUpdate();

            if(i > 0){
                return true;
            }
        } catch(SQLException ex){
            ex.printStackTrace();
        }
        return false;
    }

}
