package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.EvaluationRoundDAO;
import com.mockevaluation.model.EvaluationRound;

public class EvaluationRoundServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        EvaluationRound round =
                new EvaluationRound();

        round.setRoundName(
                request.getParameter("roundName"));

        round.setTechnologyId(
                Long.parseLong(
                        request.getParameter("technologyId")));

        EvaluationRoundDAO dao =
                new EvaluationRoundDAO();

        dao.addRound(round);

        response.sendRedirect(
                "admin/round.jsp");
    }
}