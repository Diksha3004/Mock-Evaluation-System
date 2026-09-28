package com.mockevaluation.dao;

import java.sql.*;
import java.util.ArrayList;

import com.mockevaluation.db.DBConnection;
import com.mockevaluation.model.Batch;

public class BatchDAO {

    public boolean addBatch(Batch batch) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "INSERT INTO batches(batch_name,start_date,end_date) VALUES(?,?,?)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, batch.getBatchName());
            ps.setString(2, batch.getStartDate());
            ps.setString(3, batch.getEndDate());

            int i = ps.executeUpdate();

            if(i > 0) {
                status = true;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public ArrayList<Batch> getAllBatches() {

        ArrayList<Batch> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement("SELECT * FROM batches");

            ResultSet rs = ps.executeQuery();

            while(rs.next()) {

                Batch b = new Batch();

                b.setBatchId(rs.getLong("batch_id"));
                b.setBatchName(rs.getString("batch_name"));
                b.setStartDate(rs.getString("start_date"));
                b.setEndDate(rs.getString("end_date"));

                list.add(b);
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
 // Update Batch
    public boolean updateBatch(Batch b) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            "UPDATE batches SET batch_name=?, start_date=?, end_date=? WHERE batch_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, b.getBatchName());
            ps.setDate(2,
                    java.sql.Date.valueOf(
                    b.getStartDate()));

            ps.setDate(3,
                    java.sql.Date.valueOf(
                    b.getEndDate()));

            ps.setLong(4, b.getBatchId());

            int i = ps.executeUpdate();

            if(i > 0)
                status = true;

        } catch(Exception e) {

            e.printStackTrace();
        }

        return status;
    }


    // Delete Batch
    public boolean deleteBatch(long batchId) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "DELETE FROM batches WHERE batch_id=?");

            ps.setLong(1, batchId);

            int i = ps.executeUpdate();

            if(i > 0)
                status = true;

        } catch(Exception e) {

            e.printStackTrace();
        }

        return status;
    }
    
    public Batch getBatchById(long id) {

        Batch b = null;

        try {

            Connection con =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    con.prepareStatement(
                    "SELECT * FROM batches WHERE batch_id=?");

            ps.setLong(1, id);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()) {

                b = new Batch();

                b.setBatchId(
                        rs.getLong("batch_id"));

                b.setBatchName(
                        rs.getString("batch_name"));

                b.setStartDate(
                        rs.getString("start_date"));

                b.setEndDate(
                        rs.getString("end_date"));
            }

        } catch(Exception e) {

            e.printStackTrace();
        }

        return b;
    }
}