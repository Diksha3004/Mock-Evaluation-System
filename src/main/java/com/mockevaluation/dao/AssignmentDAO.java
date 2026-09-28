package com.mockevaluation.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.mockevaluation.db.DBConnection;
import com.mockevaluation.model.Assignment;

public class AssignmentDAO {

    // Add Assignment
    public boolean addAssignment(
            Assignment a) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "INSERT INTO evaluator_assignments(participant_id,evaluator_id,round_id) VALUES(?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setLong(1,
                    a.getParticipantId());

            ps.setLong(2,
                    a.getEvaluatorId());

            ps.setLong(3,
                    a.getRoundId());

            int i = ps.executeUpdate();

            if(i > 0)
                status = true;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // Get All Assignments
    public ArrayList<Assignment> getAllAssignments() {

        ArrayList<Assignment> list =
                new ArrayList<Assignment>();

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT * FROM evaluator_assignments");

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                Assignment a =
                        new Assignment();

                a.setAssignmentId(
                        rs.getLong("assignment_id"));

                a.setParticipantId(
                        rs.getLong("participant_id"));

                a.setEvaluatorId(
                        rs.getLong("evaluator_id"));

                a.setRoundId(
                        rs.getLong("round_id"));

                list.add(a);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    
    // Total Assignments
    public int getTotalAssignments() {

        int total = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT COUNT(*) FROM evaluator_assignments");

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
    
 // Get Assignment By ID
    public Assignment getAssignmentById(
            long id) {

        Assignment a = null;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT * FROM evaluator_assignments WHERE assignment_id=?");

            ps.setLong(1, id);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                a = new Assignment();

                a.setAssignmentId(
                        rs.getLong("assignment_id"));

                a.setParticipantId(
                        rs.getLong("participant_id"));

                a.setEvaluatorId(
                        rs.getLong("evaluator_id"));

                a.setRoundId(
                        rs.getLong("round_id"));
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return a;
    }


    // Update Assignment
    public boolean updateAssignment(
            Assignment a) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "UPDATE evaluator_assignments SET evaluator_id=?, round_id=? WHERE assignment_id=?");

            ps.setLong(1,
                    a.getEvaluatorId());

            ps.setLong(2,
                    a.getRoundId());

            ps.setLong(3,
                    a.getAssignmentId());

            int i = ps.executeUpdate();

            if(i > 0)
                status = true;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }


    // Delete Assignment
    public boolean deleteAssignment(
            long id) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "DELETE FROM evaluator_assignments WHERE assignment_id=?");

            ps.setLong(1, id);

            int i = ps.executeUpdate();

            if(i > 0)
                status = true;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    
    public ArrayList<String[]> getAssignmentsByEvaluator(
            long evaluatorId) {

        ArrayList<String[]> list =
                new ArrayList<>();

        try {

            Connection con =
                    DBConnection.getConnection();
            String sql =

            		"SELECT " +
            		"p.participant_id, " +
            		"p.full_name, " +
            		"p.email, " +
            		"p.phone, " +
            		"IFNULL(b.batch_name,'N/A') batch_name, " +
            		"IFNULL(t.technology_name,'N/A') technology_name, " +
            		"IFNULL(r.round_name,'N/A') round_name, " +
            		"ea.assignment_date, " +
            		"ea.round_id, " +

            		"CASE " +
            		"WHEN EXISTS ( " +
            		"SELECT 1 FROM evaluations e " +
            		"WHERE e.participant_id=ea.participant_id " +
            		"AND e.round_id=ea.round_id " +
            		"AND e.evaluator_id=ea.evaluator_id " +
            		") " +
            		"THEN 'Completed' " +
            		"ELSE 'Pending' " +
            		"END status " +

            		"FROM evaluator_assignments ea " +
            		"JOIN participants p ON ea.participant_id=p.participant_id " +
            		"LEFT JOIN batches b ON p.batch_id=b.batch_id " +
            		"LEFT JOIN technologies t ON p.technology_id=t.technology_id " +
            		"LEFT JOIN evaluation_rounds r ON ea.round_id=r.round_id " +
            		"WHERE ea.evaluator_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setLong(1, evaluatorId);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                String[] row =
                        new String[10];

                row[0] =
                        rs.getString("participant_id");

                row[1] =
                        rs.getString("full_name");

                row[2] =
                        rs.getString("email");

                row[3] =
                        rs.getString("phone");

                row[4] =
                        rs.getString("batch_name");

                row[5] =
                        rs.getString("technology_name");

                row[6] =
                        rs.getString("round_name");

                row[7] =
                        rs.getString("assignment_date");
                
                row[8] =
                		rs.getString("round_id");
                
                row[9] =
                		rs.getString("status");

                list.add(row);

              
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return list;
    }
    
    
}