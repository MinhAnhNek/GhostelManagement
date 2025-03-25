

package controller;

import java.io.IOException;

import dao.AccountDAO;
import dao.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Account;
import model.Employee;

/**
 *
 * @author ADMIN
 */
public class ForgotPasswordServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.sendRedirect("login");
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String username = request.getParameter("username");
        String phoneNum = request.getParameter("phoneNum");
        String id = request.getParameter("id");
        AccountDAO accountDAO = new AccountDAO();
        Account account = accountDAO.getAccount("Username", username);
        request.setAttribute("usernameFG", username);
        request.setAttribute("phoneNumFG", phoneNum);
        request.setAttribute("idFG", id);

        if (account == null) {
            request.setAttribute("warningFG", "Account not found");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            EmployeeDAO employeeDAO = new EmployeeDAO();
            Employee employee = employeeDAO.getEmployeeByUsername(username);

            if (employee.getPhoneNum().equals(phoneNum) && employee.getId() == Integer.parseInt(id)) {
                String password = request.getParameter("password");
                if (password.equals(request.getParameter("cfpass"))) {
                    accountDAO.updateAccount(new Account(username, password));
                    request.setAttribute("confirmFG", "Account successfully updated! Please login again");
                    request.setAttribute("toForgotPass", true);
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    request.setAttribute("warningFG", "Password mismatch!");
                    request.setAttribute("toForgotPass", true);
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("warningFG", "Invalid information!");
                request.setAttribute("toForgotPass", true);
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
