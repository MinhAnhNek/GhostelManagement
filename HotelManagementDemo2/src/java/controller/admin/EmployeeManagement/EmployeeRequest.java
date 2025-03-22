/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.EmployeeManagement;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

import dao.EmployeeDAO;
import dao.HotelDAO;
import dao.RequestDAO;
import dao.RequestTypeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Employee;
import model.FilterType;
import model.Request;

/**
 *
 * @author ADMIN
 */
public class EmployeeRequest extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

        HttpSession session = request.getSession();
        HotelDAO hotelDAO = new HotelDAO();
        RequestDAO requestDAO = new RequestDAO();
        RequestTypeDAO requestTypeDAO = new RequestTypeDAO();
        EmployeeDAO employeeDAO = new EmployeeDAO();

        session.setAttribute("hotels", hotelDAO.getAll());
        session.setAttribute("requestTypes", requestTypeDAO.getAll());

        Map<String, String> filter = new HashMap<>();
        LinkedList<String> filterTypes = FilterType.getRequestFilterTypes();
        for (String filterType : filterTypes) {
            filter.put(filterType, request.getParameter(filterType));
            request.setAttribute(filterType, request.getParameter(filterType));
        }

        session.setAttribute("totalEmp", employeeDAO.getAll(""));
        session.setAttribute("requestTypesDistribution", requestDAO.getRequestDistributionBy("RequestTypeID", "", ""));
        session.setAttribute("requestStatusDistribution", requestDAO.getRequestDistributionBy("status","", ""));
        session.setAttribute("totalRequest", requestDAO.getAll());
        session.setAttribute("hotelRequestDistribution", requestDAO.getRequestDistributionBy("e.HotelID", "left join Employee e on e.EmployeeID = r.EmployeeID", ""));
        session.setAttribute("todayRequest", requestDAO.getRequestDistributionBy("cast (applied_at as date)", "", "having cast(getdate() as date) = cast (applied_at as date)"));
        LinkedList<Integer> requestStatusDistributionToday = (LinkedList<Integer>) requestDAO.getRequestDistributionBy("status, cast (applied_at as date) ","", "having cast(getdate() as date) = cast (applied_at as date)");
        if (requestStatusDistributionToday.size() < 2) {
            requestStatusDistributionToday.add(0);
            requestStatusDistributionToday.add(0);
        } else if (requestStatusDistributionToday.size() == 2) {
            requestStatusDistributionToday.add(0);
        }
        session.setAttribute("requestStatusDistributionToday", requestStatusDistributionToday);

        LinkedList<String> requestStatus = new LinkedList<>();
        requestStatus.add("Approved");
        requestStatus.add("Rejected");
        requestStatus.add("Pending");
        session.setAttribute("requestStatuses", requestStatus);

        LinkedList<Request> list = (LinkedList<Request>) requestDAO.getRequestsByFilter(filter);

        int pageSize = 6;
        int maxPage = (list.size() % pageSize == 0) ? (list.size() / pageSize) : (list.size() / pageSize + 1);
        request.setAttribute("maxPage", maxPage);
        String pageNo = request.getParameter("pageNo");

        if (pageNo == null || pageNo.isEmpty() || Integer.parseInt(pageNo) < 1 || Integer.parseInt(pageNo) > maxPage) {
            session.setAttribute("requests", Request.getPage(1, list, pageSize));
            request.setAttribute("pageNo", 1);
        } else {
            session.setAttribute("requests", Request.getPage(Integer.parseInt(pageNo), list, pageSize));
//            System.out.println(Employee.getPage(Integer.parseInt(pageNo), list, pageSize).getLast().getId());
            request.setAttribute("pageNo", Integer.parseInt(pageNo));
        }

        session.setAttribute("employees", employeeDAO.getAll(""));
        request.getRequestDispatcher("admin/EmployeeRequests.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String employeeID = request.getParameter("employeeID");
        String requestType = request.getParameter("requestType");
        String reason = request.getParameter("reason");
        RequestDAO requestDAO = new RequestDAO();
        requestDAO.add(Integer.parseInt(employeeID), Integer.parseInt(requestType), reason);
        response.sendRedirect("employee");
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
