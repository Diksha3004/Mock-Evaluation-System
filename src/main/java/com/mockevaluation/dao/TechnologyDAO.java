package com.mockevaluation.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.mockevaluation.db.DBConnection;
import com.mockevaluation.model.Technology;

public class TechnologyDAO {

    public boolean addTechnology(Technology tech) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "INSERT INTO technologies(technology_name,description) VALUES(?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1,
                    tech.getTechnologyName());

            ps.setString(2,
                    tech.getDescription());

            int i = ps.executeUpdate();

            if(i > 0) {
                status = true;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public ArrayList<Technology> getAllTechnologies() {

        ArrayList<Technology> list =
                new ArrayList<Technology>();

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT * FROM technologies");

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                Technology t =
                        new Technology();

                t.setTechnologyId(
                        rs.getLong("technology_id"));

                t.setTechnologyName(
                        rs.getString("technology_name"));

                t.setDescription(
                        rs.getString("description"));

                list.add(t);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
 // Get Technology By ID
    public Technology getTechnologyById(long id) {

        Technology t = null;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT * FROM technologies WHERE technology_id=?");

            ps.setLong(1, id);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                t = new Technology();

                t.setTechnologyId(
                        rs.getLong("technology_id"));

                t.setTechnologyName(
                        rs.getString("technology_name"));

                t.setDescription(
                        rs.getString("description"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return t;
    }

    // Update Technology
    public boolean updateTechnology(
            Technology t) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "UPDATE technologies SET technology_name=?, description=? WHERE technology_id=?");

            ps.setString(1,
                    t.getTechnologyName());

            ps.setString(2,
                    t.getDescription());

            ps.setLong(3,
                    t.getTechnologyId());

            int i = ps.executeUpdate();

            if(i > 0) {
                status = true;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // Delete Technology
    public boolean deleteTechnology(
            long id) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "DELETE FROM technologies WHERE technology_id=?");

            ps.setLong(1, id);

            int i = ps.executeUpdate();

            if(i > 0) {
                status = true;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    
    public int getTotalTechnologies() {

        int total = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT COUNT(*) FROM technologies");

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