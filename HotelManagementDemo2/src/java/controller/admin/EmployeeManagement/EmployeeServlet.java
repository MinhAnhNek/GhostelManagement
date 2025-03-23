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
        RequestTypeDAO requestTypeDAO = new RequestTypeDAO();
        PayrollDAO payrollDAO = new PayrollDAO();
        EmployeeDAO employeeDAO = new EmployeeDAO();
        RequestDAO requestDAO = new RequestDAO();

        HttpSession session = request.getSession();
        session.setAttribute("roles", erDAO.getAll());
        session.setAttribute("employeeStatuses", esDAO.getAll());
        session.setAttribute("hotels", hotelDAO.getAll());
        session.setAttribute("attendance", attendanceDAO.getAll());
        session.setAttribute("totalEmp", employeeDAO.getAll(""));
        session.setAttribute("activeEmp", employeeDAO.countEmployeesByStatus("active"));
        session.setAttribute("deactiveEmp", employeeDAO.countEmployeesByStatus("deactive"));
        session.setAttribute("onVacation", employeeDAO.countEmployeesByStatus("Currently on Vacation"));
        session.setAttribute("lateEmp", attendanceDAO.countByDateAndStatus("", "late"));
        session.setAttribute("presentEmp", attendanceDAO.countByDateAndStatus("", "present"));
        session.setAttribute("absentEmp", attendanceDAO.getByDateAndStatus("", "absent", ""));
        session.setAttribute("dayoff", attendanceDAO.getByDateAndStatus("", "Day Off", ""));
        session.setAttribute("payrolls", payrollDAO.getByMonth("", ""));
        session.setAttribute("pendingRequests", requestDAO.getRequestsByType("status", "Pending"));
//        System.out.println(requestDAO.getRequestsByType("Pending").getFirst().getStatus());
        session.setAttribute("requestTypes", requestTypeDAO.getAll());


//        System.out.println( payrollDAO.getByMonth("", "").size());


        // dieu huong sang trang EmployeeDetails.jsp de hien thi thong tin chi tiet cua nhan vien neu id khac null
        String id = request.getParameter("id");
        if (id != null) {
            LinkedList<Attendance> list = (LinkedList<Attendance>)  attendanceDAO.getByEmployeeID(Integer.parseInt(id), "");
//            System.out.println(list.isEmpty());
            session.setAttribute("attendance", list);
            session.setAttribute("emp", employeeDAO.getEmployeeById(Integer.parseInt(id)));
            String month = request.getParameter("month");
            session.setAttribute("payroll", payrollDAO.getByEmpIDAndMonth(Integer.parseInt(id), month == null ? "" : month));
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
        int pageSize = 6;
        int maxPage = (list.size() % pageSize == 0) ? (list.size() / pageSize) : (list.size() / pageSize + 1);
        request.setAttribute("maxPage", maxPage);
        request.setAttribute("sortType", sortType);

        // phan trang danh sach tat ca nhan vien, dieu huong den cac page tuong ung
        String pageNo = request.getParameter("pageNo");
        if (pageNo == null || pageNo.isEmpty() || Integer.parseInt(pageNo) < 1 || Integer.parseInt(pageNo) > maxPage) {
            session.setAttribute("employees", Employee.getPage(1, list, pageSize));
            request.setAttribute("pageNo", 1);
        } else {
            session.setAttribute("employees", Employee.getPage(Integer.parseInt(pageNo), list, pageSize));
//            System.out.println(Employee.getPage(Integer.parseInt(pageNo), list, pageSize).getLast().getId());
            request.setAttribute("pageNo", Integer.parseInt(pageNo));
        }
        request.getRequestDispatcher("admin/EmployeeDashboard.jsp").forward(request, response);
    }





    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String name = request.getParameter("name");
        String role = request.getParameter("role");
        String hotelName = request.getParameter("hotelName");
        String mail = request.getParameter("mail");
        String phoneNum = request.getParameter("phoneNum");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String salary = request.getParameter("salary");
        String overtimePay = request.getParameter("overtime_pay");

        AccountDAO accountDAO = new AccountDAO();
        HttpSession session = request.getSession();
        if (accountDAO.getAccount("Username", mail) != null) {
            request.setAttribute("error", "This email already exists!");
            request.setAttribute("name", name);
            request.setAttribute("role", role);
            request.setAttribute("hotelName", hotelName);
            request.setAttribute("mail", mail);
            request.setAttribute("phoneNum", phoneNum);
            request.setAttribute("address", address);
            request.setAttribute("password", password);
            request.setAttribute("salary", salary);
            request.setAttribute("overtime_pay", overtimePay);
        } else {
            Employee newEmp = new Employee(name, role, hotelName, mail, phoneNum, address, Float.parseFloat(salary));
            EmployeeDAO eDAO = new EmployeeDAO();
            eDAO.addNew(newEmp, Float.parseFloat(overtimePay), password);
        }
        request.getRequestDispatcher("admin/EmployeeDashboard.jsp").forward(request, response);
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
