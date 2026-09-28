package com.mockevaluation.dao;

import java.sql.*;
import java.util.ArrayList;

import com.mockevaluation.db.DBConnection;
import com.mockevaluation.model.EvaluationRound;

public class EvaluationRoundDAO {

    public boolean addRound(EvaluationRound round) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "INSERT INTO evaluation_rounds(round_name,technology_id) VALUES(?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, round.getRoundName());
            ps.setLong(2, round.getTechnologyId());

            int i = ps.executeUpdate();

            if(i > 0)
                status = true;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public ArrayList<EvaluationRound> getAllRounds() {

        ArrayList<EvaluationRound> list =
                new ArrayList<EvaluationRound>();

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT * FROM evaluation_rounds");

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                EvaluationRound r =
                        new EvaluationRound();

                r.setRoundId(
                        rs.getLong("round_id"));

                r.setRoundName(
                        rs.getString("round_name"));

                r.setTechnologyId(
                        rs.getLong("technology_id"));

                list.add(r);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}