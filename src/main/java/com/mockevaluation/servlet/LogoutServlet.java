package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.LoginActivityDAO;

public class LogoutServlet
extends HttpServlet {

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if(session != null) {

            Long activityId =
            (Long)session.getAttribute(
            "activityId");

            if(activityId != null) {

                LoginActivityDAO dao =
                        new LoginActivityDAO();

                dao.updateLogout(
                        activityId);
            }

            session.invalidate();
        }

        response.sendRedirect(
                "index.jsp");
    }
}