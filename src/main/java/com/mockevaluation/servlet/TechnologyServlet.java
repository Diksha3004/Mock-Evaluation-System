package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.TechnologyDAO;
import com.mockevaluation.model.Technology;

public class TechnologyServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String technologyName =
                request.getParameter("technologyName");

        String description =
                request.getParameter("description");

        Technology tech =
                new Technology();

        tech.setTechnologyName(
                technologyName);

        tech.setDescription(
                description);

        TechnologyDAO dao =
                new TechnologyDAO();

        dao.addTechnology(tech);

        response.sendRedirect(
                "admin/technology.jsp");
    }
}