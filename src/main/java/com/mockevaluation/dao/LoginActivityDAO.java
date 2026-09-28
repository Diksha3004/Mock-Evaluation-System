package com.mockevaluation.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.mockevaluation.db.DBConnection;

public class LoginActivityDAO {

    public long saveLogin(
            long userId,
            String role) {

        long activityId = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "INSERT INTO login_activity(user_id,role,login_time) VALUES(?,?,NOW())";

            PreparedStatement ps =
                    con.prepareStatement(
                    sql,
                    PreparedStatement.RETURN_GENERATED_KEYS);

            ps.setLong(1, userId);
            ps.setString(2, role);

            ps.executeUpdate();

            ResultSet rs =
                    ps.getGeneratedKeys();

            if(rs.next()) {

                activityId =
                        rs.getLong(1);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return activityId;
    }

    public void updateLogout(
            long activityId) {

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "UPDATE login_activity " +
            "SET logout_time = NOW() " +
            "WHERE activity_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setLong(1, activityId);

            ps.executeUpdate();

        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    public int getTotalLogins() {

        int total = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT COUNT(*) FROM login_activity");

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