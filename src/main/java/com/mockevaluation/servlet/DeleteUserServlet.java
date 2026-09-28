package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.UserDAO;

public class DeleteUserServlet
extends HttpServlet {

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        long id =
        Long.parseLong(
        request.getParameter("id"));

        UserDAO dao =
                new UserDAO();

        dao.deleteUser(id);

        response.sendRedirect(
                "admin/user.jsp");
    }
}