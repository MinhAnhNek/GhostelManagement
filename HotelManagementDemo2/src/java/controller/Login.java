/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;

import dao.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author ADMIN
 */
public class Login extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String username = request.getParameter("user");
        String password = request.getParameter("password");
        AccountDAO accountDAO = new AccountDAO();
        HttpSession session = request.getSession();
        if (accountDAO.checkLogin(username, password)) {
            session.setAttribute("username", username);
            int roleId = accountDAO.getAccount(username).getRoleId();
            if (roleId == 0) {
                session.setAttribute("role", "admin");
                response.sendRedirect("admin");
                return;
            } else if (roleId == 1) {
                session.setAttribute("role", "manager");
                response.sendRedirect("manager");
                return;
            }
            response.sendRedirect("employee");
        } else {
            request.setAttribute("warningL", "Invalid Username or Password");
            request.setAttribute("wrongAccount", new Account(username, password));
//            response.sendRedirect("login.jsp");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
