package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.EvaluationDAO;
import com.mockevaluation.model.User;

public class DeleteEvaluationServlet
extends HttpServlet{

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try{

            long evaluationId =
            Long.parseLong(
            request.getParameter("id"));

            EvaluationDAO dao =
            new EvaluationDAO();

            boolean status =
            dao.deleteEvaluation(
            evaluationId);

            HttpSession session =
            request.getSession(false);

            User user =
            (User)session.getAttribute("user");

            if(status){

                if(user.getRole()
                        .equals("ADMIN")){

                    response.sendRedirect(
                    "admin/evaluation.jsp?deleted=1");

                }else{

                    response.sendRedirect(
                    "evaluator/evaluationHistory.jsp?deleted=1");
                }

            }else{

                response.sendRedirect(
                "evaluator/evaluationHistory.jsp?error=1");
            }

        }catch(Exception e){

            e.printStackTrace();
        }
    }
}