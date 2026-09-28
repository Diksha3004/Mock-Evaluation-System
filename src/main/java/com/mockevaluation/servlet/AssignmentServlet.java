package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.AssignmentDAO;
import com.mockevaluation.model.Assignment;

public class AssignmentServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Assignment a =
                new Assignment();

        a.setParticipantId(
                Long.parseLong(
                request.getParameter(
                "participantId")));

        a.setEvaluatorId(
                Long.parseLong(
                request.getParameter(
                "evaluatorId")));

        a.setRoundId(
                Long.parseLong(
                request.getParameter(
                "roundId")));

        AssignmentDAO dao =
                new AssignmentDAO();

        dao.addAssignment(a);

        response.sendRedirect(
                "admin/assignment.jsp");
    }
}