package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.BatchDAO;
import com.mockevaluation.model.Batch;

public class BatchServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String batchName =
                request.getParameter("batchName");

        String startDate =
                request.getParameter("startDate");

        String endDate =
                request.getParameter("endDate");

        Batch batch = new Batch();

        batch.setBatchName(batchName);
        batch.setStartDate(startDate);
        batch.setEndDate(endDate);

        BatchDAO dao =
                new BatchDAO();

        dao.addBatch(batch);

        response.sendRedirect(
                "admin/batch.jsp");
    }
}