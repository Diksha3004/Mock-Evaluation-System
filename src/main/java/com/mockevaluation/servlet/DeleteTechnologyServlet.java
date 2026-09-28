package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.TechnologyDAO;

public class DeleteTechnologyServlet
extends HttpServlet {

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        long id =
        Long.parseLong(
        request.getParameter("id"));

        TechnologyDAO dao =
                new TechnologyDAO();

        dao.deleteTechnology(id);

        response.sendRedirect(
                "admin/technology.jsp");
    }
}
