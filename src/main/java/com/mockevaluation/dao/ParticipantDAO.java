package com.mockevaluation.dao;

import java.sql.*;
import java.util.ArrayList;

import com.mockevaluation.db.DBConnection;
import com.mockevaluation.model.Participant;

public class ParticipantDAO {

    public boolean addParticipant(Participant p) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "INSERT INTO participants(full_name,email,phone,batch_id,technology_id) VALUES(?,?,?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, p.getFullName());
            ps.setString(2, p.getEmail());
            ps.setString(3, p.getPhone());
            ps.setLong(4, p.getBatchId());
            ps.setLong(5, p.getTechnologyId());

            int i = ps.executeUpdate();

            if(i > 0) {
                status = true;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public ArrayList<Participant> getAllParticipants() {

        ArrayList<Participant> list =
                new ArrayList<Participant>();

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT * FROM participants");

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                Participant p =
                        new Participant();

                p.setParticipantId(
                        rs.getLong("participant_id"));

                p.setFullName(
                        rs.getString("full_name"));

                p.setEmail(
                        rs.getString("email"));

                p.setPhone(
                        rs.getString("phone"));

                p.setBatchId(
                        rs.getLong("batch_id"));

                p.setTechnologyId(
                        rs.getLong("technology_id"));

                list.add(p);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // REPORT DASHBOARD METHOD
    public int getTotalParticipants() {

        int total = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT COUNT(*) FROM participants");

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