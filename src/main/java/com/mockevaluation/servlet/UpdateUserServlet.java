package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.UserDAO;
import com.mockevaluation.model.User;

public class UpdateUserServlet
extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        User u =
                new User();

        u.setUserId(
                Long.parseLong(
                request.getParameter(
                "userId")));

        u.setFullName(
                request.getParameter(
                "fullName"));

        u.setEmail(
                request.getParameter(
                "email"));

        u.setPassword(
                request.getParameter(
                "password"));

        u.setRole(
                request.getParameter(
                "role"));

        UserDAO dao =
                new UserDAO();

        dao.updateUser(u);

        response.sendRedirect(
                "admin/user.jsp");
    }
}