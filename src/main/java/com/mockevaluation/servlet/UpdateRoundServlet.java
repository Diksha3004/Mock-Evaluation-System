package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.RoundDAO;
import com.mockevaluation.model.Round;

public class UpdateRoundServlet
extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Round r =
                new Round();

        r.setRoundId(
                Long.parseLong(
                request.getParameter(
                "roundId")));

        r.setRoundName(
                request.getParameter(
                "roundName"));

        r.setTechnologyId(
                Long.parseLong(
                request.getParameter(
                "technologyId")));

        RoundDAO dao =
                new RoundDAO();

        dao.updateRound(r);

        response.sendRedirect(
                "admin/round.jsp");
    }
}