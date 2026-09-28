package com.mockevaluation.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.mockevaluation.dao.UserDAO;
import com.mockevaluation.model.User;

import com.mockevaluation.dao.LoginActivityDAO;

public class LoginServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        UserDAO dao =
                new UserDAO();

        User user =
                dao.login(email, password);

        if(user != null) {

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "user", user);
            
            LoginActivityDAO activityDAO =
            		new LoginActivityDAO();

            		long activityId =
            		activityDAO.saveLogin(
            		user.getUserId(),
            		user.getRole());

            		session.setAttribute(
            		"activityId",
            		activityId);
            
            

            if(user.getRole().equals("ADMIN")) {

                response.sendRedirect(
                        "admin/dashboard.jsp");
            }
            else {

                response.sendRedirect(
                        "evaluator/dashboard.jsp");
            }
        }
        else {

            response.sendRedirect(
                    "index.jsp");
        }
    }
}