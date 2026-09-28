package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.BatchDAO;

public class DeleteBatchServlet
extends HttpServlet {

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        long batchId =
                Long.parseLong(
                request.getParameter("id"));

        BatchDAO dao =
                new BatchDAO();

        dao.deleteBatch(batchId);

        response.sendRedirect(
                "admin/batch.jsp");
    }
}