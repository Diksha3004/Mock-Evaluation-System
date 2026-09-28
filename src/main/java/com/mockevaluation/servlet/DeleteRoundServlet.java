package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.RoundDAO;

public class DeleteRoundServlet
extends HttpServlet {

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        long id =
        Long.parseLong(
        request.getParameter("id"));

        RoundDAO dao =
                new RoundDAO();

        dao.deleteRound(id);

        response.sendRedirect(
                "admin/round.jsp");
    }
}