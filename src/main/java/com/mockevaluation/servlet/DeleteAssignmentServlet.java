package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.AssignmentDAO;

public class DeleteAssignmentServlet
extends HttpServlet {

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        long id =
        Long.parseLong(
        request.getParameter("id"));

        AssignmentDAO dao =
                new AssignmentDAO();

        dao.deleteAssignment(id);

        response.sendRedirect(
                "admin/assignment.jsp");
    }
}