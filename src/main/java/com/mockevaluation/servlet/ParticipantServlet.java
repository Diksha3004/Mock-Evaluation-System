package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.ParticipantDAO;
import com.mockevaluation.model.Participant;

public class ParticipantServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Participant p =
                new Participant();

        p.setFullName(
                request.getParameter("fullName"));

        p.setEmail(
                request.getParameter("email"));

        p.setPhone(
                request.getParameter("phone"));

        p.setBatchId(
                Long.parseLong(
                        request.getParameter("batchId")));

        p.setTechnologyId(
                Long.parseLong(
                        request.getParameter("technologyId")));

        ParticipantDAO dao =
                new ParticipantDAO();

        dao.addParticipant(p);

        response.sendRedirect(
                "admin/participant.jsp");
    }
}