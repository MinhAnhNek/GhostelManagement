/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.admin.EmployeeManagement;

import java.io.IOException;
import java.util.*;

import dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Attendance;
import model.Employee;
import model.FilterType;

/**
 *
 * @author ADMIN
 */
public class EmployeeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        EmployeeRoleDAO erDAO = new EmployeeRoleDAO();
        EmployeeStatusDAO esDAO = new EmployeeStatusDAO();
        HotelDAO hotelDAO = new HotelDAO();
        AttendanceDAO attendanceDAO = new AttendanceDAO();
        HttpSession session = request.getSession();
        session.setAttribute("roles", erDAO.getAll());
        session.setAttribute("employeeStatuses", esDAO.getAll());
        session.setAttribute("hotels", hotelDAO.getAll());
        session.setAttribute("attendance", attendanceDAO.getAll());

        EmployeeDAO employeeDAO = new EmployeeDAO();
        // dieu huong sang trang EmployeeDetails.jsp de hien thi thong tin chi tiet cua nhan vien neu id khac null
        String id = request.getParameter("id");
        if (id != null) {
            LinkedList<Attendance> list = (LinkedList<Attendance>)  attendanceDAO.getByEmployeeID(Integer.parseInt(id));
            System.out.println(list.isEmpty());
            session.setAttribute("attendance", list);
            session.setAttribute("emp", employeeDAO.getEmployeeById(Integer.parseInt(id)));
            request.getRequestDispatcher("admin/EmployeeDetails.jsp").forward(request, response);
            return;
        }


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

        String sortType = request.getParameter("sortType");
        LinkedList<Employee> list = (LinkedList<Employee>) employeeDAO.getEmployeesByTypes(selected, sortType == null? "" : sortType);
        request.setAttribute("maxPage", (list.size() % 6 == 0) ? (list.size() / 6) : (list.size() / 6 + 1));
        request.setAttribute("sortType", sortType);

        // phan trang danh sach tat ca nhan vien, dieu huong den cac page tuong ung
        String pageNo = request.getParameter("pageNo");
        if (pageNo == null || pageNo.isEmpty() || Integer.parseInt(pageNo) < 1) {
            session.setAttribute("employees", Employee.getPage(1, list));
            request.setAttribute("pageNo", 1);
        } else {
            session.setAttribute("employees", Employee.getPage(Integer.parseInt(pageNo), list));
            request.setAttribute("pageNo", Integer.parseInt(pageNo));
        }
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
