package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.TechnologyDAO;
import com.mockevaluation.model.Technology;

public class UpdateTechnologyServlet
extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Technology t =
                new Technology();

        t.setTechnologyId(
                Long.parseLong(
                request.getParameter(
                "technologyId")));

        t.setTechnologyName(
                request.getParameter(
                "technologyName"));

        t.setDescription(
                request.getParameter(
                "description"));

        TechnologyDAO dao =
                new TechnologyDAO();

        dao.updateTechnology(t);

        response.sendRedirect(
                "admin/technology.jsp");
    }
}