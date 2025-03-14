

package controller.admin.EmployeeManagement;

import java.io.IOException;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

import dao.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.*;

/**
 *
 * @author ADMIN
 */
public class SearchServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        LinkedList<String> filterTypes = FilterType.getEmployeeFilterTypes();
        Map<String, String> selected = new HashMap<>();
        String minSalary = request.getParameter("minSalary");
        if (minSalary != null && !minSalary.isEmpty()) {
            filterTypes.add("minSalary");
            filterTypes.add("maxSalary");
        }               //FilterType.getFilterTypeMap();
        for (String filterType : filterTypes) {
            selected.put(filterType, request.getParameter(filterType));
            session.setAttribute(filterType, request.getParameter(filterType));
        }

        EmployeeDAO employeeDAO = new EmployeeDAO();
        String type = request.getParameter("type");
        LinkedList<Employee> list = (LinkedList<Employee>) employeeDAO.getEmployeesByTypes(selected, type);

//        response.sendRedirect("admin/home.jsp");
        request.setAttribute("type", type);
        session.setAttribute("employees", list);
        request.getRequestDispatcher("admin/home.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
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
