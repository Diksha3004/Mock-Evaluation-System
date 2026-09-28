package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.UserDAO;
import com.mockevaluation.model.User;

public class UserServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        User user = new User();

        user.setFullName(
                request.getParameter("fullName"));

        user.setEmail(
                request.getParameter("email"));

        user.setPassword(
                request.getParameter("password"));

        user.setRole(
                request.getParameter("role"));

        UserDAO dao =
                new UserDAO();

        dao.addUser(user);

        response.sendRedirect(
                "admin/user.jsp");
    }
}