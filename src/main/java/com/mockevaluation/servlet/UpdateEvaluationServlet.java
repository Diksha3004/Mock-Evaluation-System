package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.http.*;

import com.mockevaluation.dao.EvaluationDAO;
import com.mockevaluation.model.Evaluation;

public class UpdateEvaluationServlet
extends HttpServlet{

	
protected void doPost(
        HttpServletRequest request,
        HttpServletResponse response)
        throws ServletException,IOException{

    try{

        Evaluation e =
                new Evaluation();

        e.setEvaluationId(
        Long.parseLong(
        request.getParameter(
        "evaluationId")));

        e.setScore(
        Integer.parseInt(
        request.getParameter(
        "score")));

        e.setFeedback(
        request.getParameter(
        "feedback"));

        EvaluationDAO dao =
                new EvaluationDAO();

        dao.updateEvaluation(e);

        response.sendRedirect(
        "evaluator/evaluationHistory.jsp?updated=1");

    }catch(Exception ex){

        ex.printStackTrace();
    }
}

}

