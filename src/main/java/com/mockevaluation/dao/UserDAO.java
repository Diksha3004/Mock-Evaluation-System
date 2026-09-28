package com.mockevaluation.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.mockevaluation.db.DBConnection;
import com.mockevaluation.model.User;
import org.mindrot.jbcrypt.BCrypt;

public class UserDAO {

    // LOGIN
	public User login(String email, String password) {

	    User user = null;

	    try {

	        Connection con =
	                DBConnection.getConnection();

	        String sql =
	                "SELECT * FROM users WHERE email=?";

	        PreparedStatement ps =
	                con.prepareStatement(sql);

	        ps.setString(1, email);

	        ResultSet rs =
	                ps.executeQuery();

	        if(rs.next()) {

	            String dbPassword =
	                    rs.getString("password");

	            boolean valid = false;

	            if(dbPassword.startsWith("$2a$")) {

	                valid =
	                BCrypt.checkpw(
	                password,
	                dbPassword);

	            } else {

	                valid =
	                password.equals(dbPassword);
	            }

	            if(valid) {

	                user = new User();

	                user.setUserId(
	                        rs.getLong("user_id"));

	                user.setFullName(
	                        rs.getString("full_name"));

	                user.setEmail(
	                        rs.getString("email"));

	                user.setRole(
	                        rs.getString("role"));
	            }
	        }

	    } catch(Exception e) {

	        e.printStackTrace();
	    }

	    return user;
	}
	

    // ADD USER
    public boolean addUser(User user) {
    	
    	

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "INSERT INTO users(full_name,email,password,role) VALUES(?,?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1,
                    user.getFullName());

            ps.setString(2,
                    user.getEmail());

            String hashedPassword =
            		BCrypt.hashpw(
            		user.getPassword(),
            		BCrypt.gensalt());

            		ps.setString(
            		3,
            		hashedPassword);

            ps.setString(4,
                    user.getRole());

            int i = ps.executeUpdate();

            if(i > 0) {
                status = true;
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return status;
    }

    // GET ALL USERS
    public ArrayList<User> getAllUsers() {

        ArrayList<User> list =
                new ArrayList<User>();

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT * FROM users ORDER BY user_id");

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                User user =
                        new User();

                user.setUserId(
                        rs.getLong("user_id"));

                user.setFullName(
                        rs.getString("full_name"));

                user.setEmail(
                        rs.getString("email"));

                user.setRole(
                        rs.getString("role"));

                list.add(user);
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return list;
    }

    // GET ONLY EVALUATORS
    public ArrayList<User> getEvaluators() {

        ArrayList<User> list =
                new ArrayList<User>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM users WHERE role='EVALUATOR'";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                User user =
                        new User();

                user.setUserId(
                        rs.getLong("user_id"));

                user.setFullName(
                        rs.getString("full_name"));

                user.setEmail(
                        rs.getString("email"));

                user.setRole(
                        rs.getString("role"));

                list.add(user);
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return list;
    }
    
 // Get User By ID
    public User getUserById(long id) {

        User u = null;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT * FROM users WHERE user_id=?");

            ps.setLong(1, id);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                u = new User();

                u.setUserId(
                        rs.getLong("user_id"));

                u.setFullName(
                        rs.getString("full_name"));

                u.setEmail(
                        rs.getString("email"));

                u.setPassword(
                        rs.getString("password"));

                u.setRole(
                        rs.getString("role"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return u;
    }


    // Update User
    public boolean updateUser(User u) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "UPDATE users SET full_name=?, email=?, password=?, role=? WHERE user_id=?");

            ps.setString(1,
                    u.getFullName());

            ps.setString(2,
                    u.getEmail());

            String hashedPassword =
            		BCrypt.hashpw(
            		u.getPassword(),
            		BCrypt.gensalt());

            		ps.setString(
            		3,
            		hashedPassword);

            ps.setString(4,
                    u.getRole());

            ps.setLong(5,
                    u.getUserId());

            int i = ps.executeUpdate();

            if(i > 0)
                status = true;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }


    // Delete User
    public boolean deleteUser(long id) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "DELETE FROM users WHERE user_id=?");

            ps.setLong(1, id);

            int i = ps.executeUpdate();

            if(i > 0)
                status = true;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    
 // Total Evaluators
    public int getTotalEvaluators() {

        int total = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT COUNT(*) FROM users WHERE role='EVALUATOR'");

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                total = rs.getInt(1);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return total;
    }

    // Total Admins
    public int getTotalAdmins() {

        int total = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT COUNT(*) FROM users WHERE role='ADMIN'");

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                total = rs.getInt(1);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return total;
    }
    
}