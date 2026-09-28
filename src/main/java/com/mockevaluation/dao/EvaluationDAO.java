package com.mockevaluation.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.mockevaluation.db.DBConnection;
import com.mockevaluation.model.Evaluation;

public class EvaluationDAO {

    // Add Evaluation
    public boolean addEvaluation(Evaluation e) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "INSERT INTO evaluations(participant_id,evaluator_id,round_id,score,feedback) VALUES(?,?,?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setLong(1, e.getParticipantId());
            ps.setLong(2, e.getEvaluatorId());
            ps.setLong(3, e.getRoundId());
            ps.setInt(4, e.getScore());
            ps.setString(5, e.getFeedback());

            int i = ps.executeUpdate();

            if(i > 0) {
                status = true;
            }

        } catch(Exception ex) {
            ex.printStackTrace();
        }

        return status;
    }

    // Get All Evaluations
    public ArrayList<Evaluation> getAllEvaluations() {

        ArrayList<Evaluation> list =
                new ArrayList<Evaluation>();

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT * FROM evaluations ORDER BY evaluation_id ASC");

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                Evaluation e =
                        new Evaluation();

                e.setEvaluationId(
                        rs.getLong("evaluation_id"));

                e.setParticipantId(
                        rs.getLong("participant_id"));

                e.setEvaluatorId(
                        rs.getLong("evaluator_id"));

                e.setRoundId(
                        rs.getLong("round_id"));

                e.setScore(
                        rs.getInt("score"));

                e.setFeedback(
                        rs.getString("feedback"));

                list.add(e);
            }

        } catch(Exception ex) {
            ex.printStackTrace();
        }

        return list;
    }

    // Total Evaluations
    public int getTotalEvaluations() {

        int total = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT COUNT(*) FROM evaluations");

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

    // Average Score
    public double getAverageScore() {

        double avg = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT AVG(score) FROM evaluations");

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                avg = rs.getDouble(1);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return avg;
    }

    // Evaluator Total Evaluations
    public int getEvaluatorEvaluationCount(
            long evaluatorId) {

        int count = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT COUNT(*) FROM evaluations WHERE evaluator_id=?");

            ps.setLong(1, evaluatorId);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                count = rs.getInt(1);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    // Evaluator Average Score
    public double getEvaluatorAverageScore(
            long evaluatorId) {

        double avg = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT AVG(score) FROM evaluations WHERE evaluator_id=?");

            ps.setLong(1, evaluatorId);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                avg = rs.getDouble(1);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return avg;
    }

    // Evaluation History By Evaluator
    public ArrayList<Evaluation> getEvaluationsByEvaluator(
            long evaluatorId) {

        ArrayList<Evaluation> list =
                new ArrayList<Evaluation>();

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT * FROM evaluations WHERE evaluator_id=? ORDER BY evaluation_id ASC");

            ps.setLong(1, evaluatorId);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                Evaluation e =
                        new Evaluation();

                e.setEvaluationId(
                        rs.getLong("evaluation_id"));

                e.setParticipantId(
                        rs.getLong("participant_id"));

                e.setEvaluatorId(
                        rs.getLong("evaluator_id"));

                e.setRoundId(
                        rs.getLong("round_id"));

                e.setScore(
                        rs.getInt("score"));

                e.setFeedback(
                        rs.getString("feedback"));

                list.add(e);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Delete Evaluation
    public boolean deleteEvaluation(
            long evaluationId) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "DELETE FROM evaluations WHERE evaluation_id=?");

            ps.setLong(1, evaluationId);

            int i = ps.executeUpdate();

            if(i > 0) {

                status = true;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    
 // Batch Wise Report
    public ArrayList<String[]> getBatchWiseReport() {

        ArrayList<String[]> list =
                new ArrayList<String[]>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "SELECT b.batch_name, COUNT(e.evaluation_id) total_evaluations, AVG(e.score) avg_score " +
            "FROM evaluations e " +
            "JOIN participants p ON e.participant_id=p.participant_id " +
            "JOIN batches b ON p.batch_id=b.batch_id " +
            "GROUP BY b.batch_name";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                String[] row =
                        new String[3];

                row[0] = rs.getString("batch_name");
                row[1] = rs.getString("total_evaluations");
                row[2] = rs.getString("avg_score");

                list.add(row);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }

 // Technology Wise Report

    public ArrayList<String[]> getTechnologyWiseReport() {

        ArrayList<String[]> list =
                new ArrayList<String[]>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "SELECT t.technology_name, " +
            "COUNT(e.evaluation_id) total_evaluations, " +
            "AVG(e.score) avg_score " +
            "FROM evaluations e " +
            "JOIN participants p ON e.participant_id = p.participant_id " +
            "JOIN technologies t ON p.technology_id = t.technology_id " +
            "GROUP BY t.technology_name";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                String[] row =
                        new String[3];

                row[0] =
                        rs.getString("technology_name");

                row[1] =
                        rs.getString("total_evaluations");

                row[2] =
                        rs.getString("avg_score");

                list.add(row);
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return list;
    }
    
 // Top Performers Report

    public ArrayList<String[]> getTopPerformers() {

        ArrayList<String[]> list =
                new ArrayList<String[]>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =

            "SELECT p.full_name, " +
            "AVG(e.score) avg_score, " +
            "COUNT(e.evaluation_id) total_eval " +
            "FROM evaluations e " +
            "JOIN participants p " +
            "ON e.participant_id = p.participant_id " +
            "GROUP BY p.participant_id " +
            "ORDER BY avg_score DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                String row[] =
                {
                    rs.getString("full_name"),
                    String.format("%.2f",
                    rs.getDouble("avg_score")),
                    rs.getString("total_eval")
                };

                list.add(row);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
 // Participant Detailed Report

    public ArrayList<String[]> getParticipantDetailedReport() {

        ArrayList<String[]> list =
                new ArrayList<String[]>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =

            "SELECT " +
            "p.full_name, " +
            "b.batch_name, " +
            "t.technology_name, " +
            "COUNT(e.evaluation_id) total_eval, " +
            "IFNULL(AVG(e.score),0) avg_score " +
            "FROM participants p " +

            "LEFT JOIN batches b " +
            "ON p.batch_id=b.batch_id " +

            "LEFT JOIN technologies t " +
            "ON p.technology_id=t.technology_id " +

            "LEFT JOIN evaluations e " +
            "ON p.participant_id=e.participant_id " +

            "GROUP BY p.participant_id";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                String row[] =
                {
                    rs.getString("full_name"),
                    rs.getString("batch_name"),
                    rs.getString("technology_name"),
                    rs.getString("total_eval"),
                    String.format("%.2f",
                    rs.getDouble("avg_score"))
                };

                list.add(row);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
 // Evaluator Performance Report

    public ArrayList<String[]> getEvaluatorPerformanceReport() {

        ArrayList<String[]> list =
                new ArrayList<String[]>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =

            "SELECT " +
            "u.full_name, " +
            "COUNT(e.evaluation_id) total_eval, " +
            "IFNULL(AVG(e.score),0) avg_score " +
            "FROM users u " +

            "LEFT JOIN evaluations e " +
            "ON u.user_id = e.evaluator_id " +

            "WHERE u.role='EVALUATOR' " +

            "GROUP BY u.user_id " +

            "ORDER BY total_eval DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                String row[] =
                {
                    rs.getString("full_name"),
                    rs.getString("total_eval"),
                    String.format("%.2f",
                    rs.getDouble("avg_score"))
                };

                list.add(row);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public ArrayList<String[]> getEvaluationReport() {

        ArrayList<String[]> list =
                new ArrayList<String[]>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "SELECT e.evaluation_id, " +
            "p.full_name participant_name, " +
            "u.full_name evaluator_name, " +
            "r.round_name, " +
            "e.score " +
            "FROM evaluations e " +
            "JOIN participants p ON e.participant_id=p.participant_id " +
            "JOIN users u ON e.evaluator_id=u.user_id " +
            "JOIN evaluation_rounds r ON e.round_id=r.round_id";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                String[] row = new String[5];

                row[0] =
                        rs.getString("evaluation_id");

                row[1] =
                        rs.getString("participant_name");

                row[2] =
                        rs.getString("evaluator_name");

                row[3] =
                        rs.getString("round_name");

                row[4] =
                        rs.getString("score");

                list.add(row);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public ArrayList<String[]> getEvaluatorWorkload() {

        ArrayList<String[]> list =
                new ArrayList<String[]>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            		"SELECT u.full_name, " +
            		"COUNT(DISTINCT a.assignment_id) totalAssignments, " +
            		"COUNT(DISTINCT CASE " +
            		"WHEN e.evaluation_id IS NOT NULL " +
            		"THEN a.assignment_id END) completedEvaluations " +
            		"FROM users u " +
            		"LEFT JOIN evaluator_assignments a " +
            		"ON u.user_id=a.evaluator_id " +
            		"LEFT JOIN evaluations e " +
            		"ON a.participant_id=e.participant_id " +
            		"AND a.round_id=e.round_id " +
            		"AND a.evaluator_id=e.evaluator_id " +
            		"WHERE u.role='EVALUATOR' " +
            		"GROUP BY u.user_id,u.full_name";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                String[] row =
                        new String[4];

                row[0] =
                        rs.getString(1);

                row[1] =
                        rs.getString(2);

                row[2] =
                        rs.getString(3);

                int pending =
                        Math.max(
                        0,
                        rs.getInt(2) - rs.getInt(3));

                row[3] =
                        String.valueOf(pending);

                list.add(row);
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return list;
    }
    
    public ArrayList<String[]>
    getEvaluationHistory(long evaluatorId){

        ArrayList<String[]> list =
                new ArrayList<>();

        try{

            Connection con =
                    DBConnection.getConnection();

            String sql =
            		"SELECT " +
            		"e.evaluation_id, " +
            		"p.full_name, " +
            		"r.round_name, " +
            		"e.score, " +
            		"e.feedback, " +
            		"e.evaluation_date " +
            		"FROM evaluations e " +
            		"JOIN participants p ON e.participant_id=p.participant_id " +
            		"JOIN evaluation_rounds r ON e.round_id=r.round_id " +
            		"WHERE e.evaluator_id=? " +
            		"ORDER BY e.evaluation_id DESC";
            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setLong(1, evaluatorId);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

            	String[] row = new String[6];

            	row[0] = rs.getString("evaluation_id");
            	row[1] = rs.getString("full_name");
            	row[2] = rs.getString("round_name");
            	row[3] = String.valueOf(rs.getInt("score"));
            	row[4] = rs.getString("feedback");
            	row[5] = rs.getString("evaluation_date");

            	list.add(row);

            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    
    public boolean isAlreadyEvaluated(
            long participantId,
            long evaluatorId,
            long roundId) {

        boolean exists = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "SELECT evaluation_id " +
            "FROM evaluations " +
            "WHERE participant_id=? " +
            "AND evaluator_id=? " +
            "AND round_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setLong(1, participantId);
            ps.setLong(2, evaluatorId);
            ps.setLong(3, roundId);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                exists = true;
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return exists;
    }
    public int getTotalAssignments(long evaluatorId) {

        int total = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "SELECT COUNT(*) " +
            "FROM evaluator_assignments " +
            "WHERE evaluator_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setLong(1, evaluatorId);

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
    public int getCompletedEvaluations(
            long evaluatorId) {

        int total = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "SELECT COUNT(*) " +
            "FROM evaluations " +
            "WHERE evaluator_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setLong(1, evaluatorId);

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
    
    public int getPendingEvaluations(
            long evaluatorId) {

        int totalAssignments =
                getTotalAssignments(
                evaluatorId);

        int completed =
                getCompletedEvaluations(
                evaluatorId);

        return totalAssignments - completed;
    }
    
    public ArrayList<String[]>
    getEvaluatorLeaderboard() {

        ArrayList<String[]> list =
                new ArrayList<>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =

            "SELECT u.full_name, " +
            "COUNT(e.evaluation_id) total_eval, " +
            "IFNULL(AVG(e.score),0) avg_score " +
            "FROM users u " +
            "LEFT JOIN evaluations e " +
            "ON u.user_id=e.evaluator_id " +
            "WHERE u.role='EVALUATOR' " +
            "GROUP BY u.user_id " +
            "ORDER BY total_eval DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                String[] row =
                {
                    rs.getString(1),
                    rs.getString(2),
                    String.format("%.2f",
                    rs.getDouble(3))
                };

                list.add(row);
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return list;
    }
    
    public boolean updateEvaluation(Evaluation e){

    
    	boolean status = false;

    	try{

    	    Connection con =
    	            DBConnection.getConnection();

    	    String sql =
    	    "UPDATE evaluations " +
    	    "SET score=?, feedback=? " +
    	    "WHERE evaluation_id=?";

    	    PreparedStatement ps =
    	            con.prepareStatement(sql);

    	    ps.setInt(1, e.getScore());
    	    ps.setString(2, e.getFeedback());
    	    ps.setLong(3, e.getEvaluationId());

    	    int i = ps.executeUpdate();

    	    if(i > 0){
    	        status = true;
    	    }

    	}catch(Exception ex){
    	    ex.printStackTrace();
    	}

    	return status;
    

    	}
    
    public Evaluation getEvaluationById(long id){

    
    	Evaluation e = null;

    	try{

    	    Connection con =
    	            DBConnection.getConnection();

    	    PreparedStatement ps =
    	            con.prepareStatement(
    	            "SELECT * FROM evaluations WHERE evaluation_id=?");

    	    ps.setLong(1,id);

    	    ResultSet rs =
    	            ps.executeQuery();

    	    if(rs.next()){

    	        e = new Evaluation();

    	        e.setEvaluationId(
    	                rs.getLong("evaluation_id"));

    	        e.setParticipantId(
    	                rs.getLong("participant_id"));

    	        e.setEvaluatorId(
    	                rs.getLong("evaluator_id"));

    	        e.setRoundId(
    	                rs.getLong("round_id"));

    	        e.setScore(
    	                rs.getInt("score"));

    	        e.setFeedback(
    	                rs.getString("feedback"));
    	    }

    	}catch(Exception ex){
    	    ex.printStackTrace();
    	}

    	return e;
    	

    	}
    
    public int[] getScoreAnalytics() {

        int[] data = new int[4];

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "SELECT " +
            "SUM(CASE WHEN score>=80 THEN 1 ELSE 0 END) excellent, " +
            "SUM(CASE WHEN score>=60 AND score<80 THEN 1 ELSE 0 END) good, " +
            "SUM(CASE WHEN score>=40 AND score<60 THEN 1 ELSE 0 END) average, " +
            "SUM(CASE WHEN score<40 THEN 1 ELSE 0 END) poor " +
            "FROM evaluations";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()){

                data[0] = rs.getInt("excellent");
                data[1] = rs.getInt("good");
                data[2] = rs.getInt("average");
                data[3] = rs.getInt("poor");
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return data;
    }
    
    public int getExcellentCount() {

        return getCountByRange(80,100);
    }

    public int getGoodCount() {

        return getCountByRange(60,79);
    }

    public int getAverageCount() {

        return getCountByRange(40,59);
    }

    public int getPoorCount() {

        return getCountByRange(0,39);
    }

    private int getCountByRange(
            int min,
            int max) {

        int count = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "SELECT COUNT(*) " +
            "FROM evaluations " +
            "WHERE score BETWEEN ? AND ?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1,min);
            ps.setInt(2,max);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                count = rs.getInt(1);
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return count;
    }
    
    public ArrayList<String[]> getParticipantProgressReport() {

        ArrayList<String[]> list =
                new ArrayList<String[]>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =

            "SELECT " +
            "p.participant_id, " +
            "p.full_name, " +
            "COUNT(e.evaluation_id) total_evaluations, " +
            "IFNULL(AVG(e.score),0) average_score " +
            "FROM participants p " +
            "LEFT JOIN evaluations e " +
            "ON p.participant_id=e.participant_id " +
            "GROUP BY p.participant_id,p.full_name " +
            "ORDER BY average_score DESC";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                String[] row =
                        new String[5];

                row[0] =
                        rs.getString("participant_id");

                row[1] =
                        rs.getString("full_name");

                row[2] =
                        rs.getString("total_evaluations");

                row[3] =
                        String.format("%.2f",
                        rs.getDouble("average_score"));

                double avg =
                        rs.getDouble("average_score");

                if(avg >= 80) {

                    row[4] = "Excellent";

                } else if(avg >= 60) {

                    row[4] = "Good";

                } else if(avg >= 40) {

                    row[4] = "Average";

                } else {

                    row[4] = "Poor";
                }

                list.add(row);
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return list;
    }
    
    public ArrayList<String[]> getRoundWiseReport() {

        ArrayList<String[]> list =
                new ArrayList<String[]>();

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =

            "SELECT " +
            "r.round_name, " +
            "COUNT(e.evaluation_id) total_eval, " +
            "IFNULL(AVG(e.score),0) avg_score " +
            "FROM evaluation_rounds r " +

            "LEFT JOIN evaluations e " +
            "ON r.round_id=e.round_id " +

            "GROUP BY r.round_id,r.round_name";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {

                String row[] =
                {
                    rs.getString("round_name"),
                    rs.getString("total_eval"),
                    String.format("%.2f",
                    rs.getDouble("avg_score"))
                };

                list.add(row);
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return list;
    }
    

    
}