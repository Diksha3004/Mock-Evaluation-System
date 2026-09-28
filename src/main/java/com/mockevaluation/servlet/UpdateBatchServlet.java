package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.BatchDAO;
import com.mockevaluation.model.Batch;

public class UpdateBatchServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Batch b =
                new Batch();

        b.setBatchId(
                Long.parseLong(
                request.getParameter("batchId")));

        b.setBatchName(
                request.getParameter("batchName"));

        b.setStartDate(
                request.getParameter("startDate"));

        b.setEndDate(
                request.getParameter("endDate"));

        BatchDAO dao =
                new BatchDAO();

        dao.updateBatch(b);

        response.sendRedirect(
                "admin/batch.jsp");
    }
}