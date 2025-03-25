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
        String loginMethod = request.getParameter("loginMethod");
        String loginValue = request.getParameter(loginMethod);
//        System.out.println(loginMethod);
//        System.out.println(loginValue);
        if (loginValue == null) {
            request.setAttribute("noLoginValue", "Please enter either an username or a phone number!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        String password = request.getParameter("password");
        AccountDAO accountDAO = new AccountDAO();
        HttpSession session = request.getSession();
        request.setAttribute(loginMethod, loginValue);
        if (accountDAO.checkLogin(loginMethod, loginValue, password)) {
            Account account = accountDAO.getAccount(loginMethod, loginValue);
            if (account.getStatusID() == 2) {
                request.setAttribute("deactiveAcc", "This account is deactivated");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
            session.setAttribute("account", account);
            int roleId = account.getRoleId();
            System.out.println("role id: " + roleId);
            if (roleId == 0) {
                session.setAttribute("role", "admin");
                response.sendRedirect("admin");
                return;
//            }
//            else if (roleId == 1) {
//                session.setAttribute("role", "manager");
//                response.sendRedirect("manager");
//                return;
            } else {
                response.sendRedirect("employee");
            }
        } else {
            request.setAttribute("warningL", "Invalid Username or Password");
//            request.setAttribute("wrongAccount", new Account(username, password));
            request.setAttribute("password", password);
//            response.sendRedirect("login.jsp");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
