package com.mockevaluation.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.mockevaluation.db.DBConnection;
import com.mockevaluation.model.Round;

public class RoundDAO {

    public ArrayList<Round> getAllRounds() {

        ArrayList<Round> list =
                new ArrayList<Round>();

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT * FROM evaluation_rounds");

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                Round r =
                        new Round();

                r.setRoundId(
                        rs.getLong("round_id"));

                r.setRoundName(
                        rs.getString("round_name"));

                list.add(r);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
 // Get Round By ID
    public Round getRoundById(long id) {

        Round r = null;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT * FROM evaluation_rounds WHERE round_id=?");

            ps.setLong(1, id);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                r = new Round();

                r.setRoundId(
                        rs.getLong("round_id"));

                r.setRoundName(
                        rs.getString("round_name"));

                r.setTechnologyId(
                        rs.getLong("technology_id"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return r;
    }


    // Update Round
    public boolean updateRound(
            Round r) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "UPDATE evaluation_rounds SET round_name=?, technology_id=? WHERE round_id=?");

            ps.setString(1,
                    r.getRoundName());

            ps.setLong(2,
                    r.getTechnologyId());

            ps.setLong(3,
                    r.getRoundId());

            int i = ps.executeUpdate();

            if(i > 0)
                status = true;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }


    // Delete Round
    public boolean deleteRound(
            long id) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "DELETE FROM evaluation_rounds WHERE round_id=?");

            ps.setLong(1, id);

            int i = ps.executeUpdate();

            if(i > 0)
                status = true;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}