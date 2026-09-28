package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.EvaluationDAO;
import com.mockevaluation.model.Evaluation;
import com.mockevaluation.model.User;

public class EvaluationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            long participantId =
                    Long.parseLong(
                    request.getParameter("participantId"));

            long evaluatorId =
                    Long.parseLong(
                    request.getParameter("evaluatorId"));

            long roundId =
                    Long.parseLong(
                    request.getParameter("roundId"));

            int score =
                    Integer.parseInt(
                    request.getParameter("score"));

            String feedback =
                    request.getParameter("feedback");

            EvaluationDAO dao =
                    new EvaluationDAO();

            // Duplicate Check

            if(dao.isAlreadyEvaluated(
                    participantId,
                    evaluatorId,
                    roundId)) {

                response.sendRedirect(
                "evaluator/evaluation.jsp?participantId="
                + participantId
                + "&roundId="
                + roundId
                + "&error=duplicate");

                return;
            }

            Evaluation e =
                    new Evaluation();

            e.setParticipantId(participantId);
            e.setEvaluatorId(evaluatorId);
            e.setRoundId(roundId);
            e.setScore(score);
            e.setFeedback(feedback);

            boolean status =
                    dao.addEvaluation(e);

            HttpSession session =
                    request.getSession(false);

            if(session == null) {

                response.sendRedirect(
                        "index.jsp");

                return;
            }

            User user =
                    (User)session.getAttribute("user");

            if(user == null) {

                response.sendRedirect(
                        "index.jsp");

                return;
            }

            System.out.println(
                    "Role = "
                    + user.getRole());

            System.out.println(
                    "User = "
                    + user.getFullName());

            if(status) {

                if("ADMIN".equalsIgnoreCase(
                        user.getRole().trim())) {

                    response.sendRedirect(
                    "admin/evaluation.jsp?success=1");

                } else {

                    response.sendRedirect(
                    "evaluator/evaluationHistory.jsp?success=1");
                }

            } else {

                if("ADMIN".equalsIgnoreCase(
                        user.getRole().trim())) {

                    response.sendRedirect(
                    "admin/evaluation.jsp?error=1");

                } else {

                    response.sendRedirect(
                    "evaluator/evaluation.jsp?error=1");
                }
            }

        } catch(Exception ex) {

            ex.printStackTrace();

            response.getWriter().println(
                    "ERROR : "
                    + ex.getMessage());
        }
    }
}