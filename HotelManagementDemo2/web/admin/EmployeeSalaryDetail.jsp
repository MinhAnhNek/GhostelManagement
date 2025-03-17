<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
    Document   : EmployeeSalaryDashboard
    Created on : Mar 16, 2025, 11:54:07 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Salary Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="admin/css/employeeSalaryDetail.css">
</head>
<body>

<div class="d-flex">
    <div class="sidebar bg-dark p-3">
        <div class="logo mb-4">
            <a href="">
                <img src="https://images.unsplash.com/photo-1571896349842-33c89424de2d" alt="Hotel Logo" class="img-fluid rounded-circle">
            </a>
        </div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="" style="border-top-left-radius: var(--radius); border-top-right-radius: var(--radius);"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/admin"><i class="bi bi-people me-2"></i>Employee Dashboard</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/RoomManagement"><i class="bi bi-door-open me-2"></i>Room Details</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/EmployeeSalaryDetail"><i class="bi bi-calendar-check me-2"></i>Employee Salary Detail</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"  style="border-bottom-left-radius: var(--radius); border-bottom-right-radius: var(--radius);"><i class="bi bi-graph-up me-2"></i>Finance Overview</a>
            </li>

        </ul>
    </div>

    <div class="main-content p-4 w-100">

        <div class="row mb-4">
            <div class="col-12">
                <h2 class="dashboard-title">Employee Salary Dashboard</h2>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="stat-card">
                    <h4>Total Employees</h4>
                    <p class="stat-number">${sessionScope.totalEmp.size()}</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card">
                    <h4>Total Salary Paid</h4>
                    <p class="stat-number">$${sessionScope.totalPaidSalary}</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card">
                    <h4>Pending Payments</h4>
                    <p class="stat-number">${sessionScope.pendingPayrolls.size()}</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card">
                    <h4>Average Salary</h4>
                    <p class="stat-number">$4,200</p>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <div class="nav d-flex flex-row nav-pills me-4" style="min-width: 200px;" role="tablist">
<%--                           --%>
                            <a class="nav-link ${empty sessionScope.hotelID ? 'active' : ''} text-start mb-3 col-md-4" href="${pageContext.request.contextPath}/EmployeeSalaryDetail">
                                <i class="bi bi-building me-2"></i>All Hotel
                            </a>

                            <c:forEach var="hotel" items="${sessionScope.hotels}">
                                <a class="nav-link text-start mb-3 col-md-4 ${sessionScope.hotelID eq hotel.getHotelId() ? 'active' : ''}"  href="${pageContext.request.contextPath}/EmployeeSalaryDetail?hotelID=${hotel.getHotelId()}">
                                    <i class="bi bi-building me-2"></i>${hotel.getName()}
                                </a>
                            </c:forEach>

<%--                            <button class="nav-link text-start mb-3" data-bs-toggle="pill" data-bs-target="#hotel2">--%>
<%--                                <i class="bi bi-building me-2"></i>Sunset Resort--%>
<%--                            </button>--%>
<%--                            <button class="nav-link text-start mb-3" data-bs-toggle="pill" data-bs-target="#hotel3">--%>
<%--                                <i class="bi bi-building me-2"></i>Ocean View Inn--%>
<%--                            </button>--%>
<%--                            <button class="nav-link text-start mb-3" data-bs-toggle="pill" data-bs-target="#hotel4">--%>
<%--                                <i class="bi bi-building me-2"></i>Mountain Lodge--%>
<%--                            </button>--%>
<%--                            <button class="nav-link text-start mb-3" data-bs-toggle="pill" data-bs-target="#hotel5">--%>
<%--                                <i class="bi bi-building me-2"></i>City Comfort Hotel--%>
<%--                            </button>--%>
                        </div>

<%--                        <c:forEach var="hotel" items="${sessionScope.hotels}">--%>
<%--                            <c:set var="employees" value="${sessionScope.empListByHotel.get(hotel.getHotelId()-1)}"/>--%>
<%--                            <c:set var="payrolls" value="${sessionScope.payListByHotel.get(hotel.getHotelId())}"/>--%>

                        <c:set var="hotel" value="${requestScope.hotelID}"/>
                        <div class="tab-content flex-grow-1">
                            <div class="tab-pane fade show active" id="hotel">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h4 class="mb-0">${sessionScope.hotels.get(hotel).getName()}</h4>
                                    <div>
                                        <button class="btn btn-primary me-2"><i class="bi bi-download"></i> Export</button>
                                        <button class="btn btn-secondary"><i class="bi bi-printer"></i> Print</button>
                                    </div>
                                </div>
                                <div class="col-12">
                                        <%--                                    <div class="card">--%>
                                        <%--                                        <div class="card-body">--%>
                                    <ul class="nav nav-tabs" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active" data-bs-toggle="tab" href="#monthly">View by Month</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" data-bs-toggle="tab" href="#yearly">View by Year</a>
                                        </li>
                                    </ul>

                                    <div class="tab-content mt-3">
                                        <div class="tab-pane fade show active" id="monthly">
                                            <div class="row mb-3">
                                                <div class="col-md-3">
                                                    <select class="form-select" onchange="redirectToServlet('${pageContext.request.contextPath}', 'EmployeeSalaryDetail?hotelID=${sessionScope.hotelID}&month=' + this.value)">
                                                        <option value="">All Month</option>
                                                        <option value="3" ${requestScope.month eq '3' ? 'selected' : ''}>March 2024</option>
                                                        <option value="2" ${requestScope.month eq '2' ? 'selected' : ''}>February 2024</option>
                                                        <option value="1" ${requestScope.month eq '1' ? 'selected' : ''}>January 2024</option>
                                                    </select>
                                                </div>
<%--                                                <div class="col-md-6">--%>
<%--                                                    <input type="text" name="name" class="form-control" placeholder="Search employees...">--%>
<%--                                                </div>--%>
<%--                                                        <div class="col-md-3 text-end">--%>
<%--                                                            <button class="btn btn-primary me-2"><i class="bi bi-download"></i> Export</button>--%>
<%--                                                            <button class="btn btn-secondary"><i class="bi bi-printer"></i> Print</button>--%>
<%--                                                        </div>--%>
                                            </div>

                                            <div class="table-responsive">
                                                <table class="table table-hover">
                                                    <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Name</th>
                                                        <th>Hours</th>
                                                        <th>Days</th>
                                                        <th>OT Hours</th>
                                                        <th>Base Salary</th>
                                                        <th>OT Pay</th>
                                                        <th>Status</th>
<%--                                                            <th>Deductions</th>--%>
<%--                                                            <th>Bonus</th>--%>
                                                        <th>Net Salary</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:forEach var="payroll" items="${sessionScope.payrolls}">
                                                        <c:set var="emp" value="${sessionScope.totalEmp.get(payroll.getEmployeeID())}"/>
                                                        <tr>
                                                            <td>${emp.getId()}</td>
                                                            <td>${emp.getName()}</td>
                                                            <td>${payroll.getTotalHours()}</td>
                                                            <td>${payroll.getTotalWorkingDays()}</td>
                                                            <td>${payroll.getOvertimeHours()}</td>
                                                            <td>${payroll.getBaseSalary()}</td>
                                                            <td>$${payroll.getOvertimePay()}</td>
                                                            <td>
                                                                <span class="badge  ${payroll.getStatus() eq 'Paid' ? 'bg-success' : 'bg-warning'}">
                                                                        ${payroll.getStatus()}
                                                                </span>
                                                            </td>
<%--                                                                <td>$200</td>--%>
<%--                                                                <td>$300</td>--%>
                                                            <td>$${payroll.getTotalSalary()}</td>
                                                            <td>
                                                                <button class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#viewEmpSalaryModel${payroll.getEmployeeID()}">
                                                                    <i class="bi bi-pencil"></i>
                                                                </button>
<%--                                                                <button class="btn btn-sm btn-primary"><i class="bi bi-download"></i></button>--%>
                                                            </td>
                                                            <div class="modal fade" id="viewEmpSalaryModel${emp.getId()}" tabindex="-1">
                                                                <div class="modal-dialog">
                                                                    <div class="modal-content">
                                                                        <div class="modal-header">
                                                                            <h5 class="modal-title">Employee Salary Detail</h5>
                                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                                        </div>
                                                                        <div class="modal-body">
                                                                            <form id="addRoomForm" action="${pageContext.request.contextPath}/EmployeeSalaryDetail" method="post">
                                                                                <div class="row mb-3 d-flex">
                                                                                    <div class="col-md-6">
                                                                                        <label class="form-label">Employee ID</label>
                                                                                        <input type="text" class="form-control" name="employeeID" value="${emp.getId()}" readonly>
                                                                                    </div>
                                                                                    <div class="col-md-6">
                                                                                        <label class="form-label">Employee Name</label>
                                                                                        <input type="text" class="form-control" name="employeeName" value="${emp.getName()}" readonly>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row mb-3 d-flex">
                                                                                    <div class="col-md-3">
                                                                                        <label class="form-label">Month</label>
                                                                                        <input type="number" class="form-control" name="month" value="${payroll.getSalaryMonth()}" readonly>
                                                                                    </div>
                                                                                    <div class="col-md-3">
                                                                                        <label class="form-label">Year</label>
                                                                                        <input type="number" class="form-control" name="month" value="${payroll.getSalaryYear()}" readonly>
                                                                                    </div>
                                                                                    <div class="col-md-6">
                                                                                        <label class="form-label">Total Working Days</label>
                                                                                        <input name="totalWorkingDays" type="number" class="form-control" value="${payroll.getTotalWorkingDays()}">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row mb-3 d-flex">
                                                                                    <div class="col-md-6">
                                                                                        <label class="form-label">Total Hours</label>
                                                                                        <input name="totalHours" type="number" class="form-control" value="${payroll.getTotalHours()}">
                                                                                    </div>
                                                                                    <div class="col-md-6">
                                                                                        <label class="form-label">Base Salary</label>
                                                                                        <input name="baseSalary" type="number" class="form-control" value="${payroll.getBaseSalary()}">
                                                                                    </div>

                                                                                </div>
                                                                                <div class="row mb-3 d-flex">
                                                                                    <div class="col-md-6">
                                                                                        <label class="form-label">Overtime Hours</label>
                                                                                        <input name="overtimeHours" type="number" class="form-control" value="${payroll.getOvertimeHours()}">
                                                                                    </div>
                                                                                    <div class="col-md-6">
                                                                                        <label class="form-label">Overtime Payment</label>
                                                                                        <input name="overtimePay" type="number" class="form-control" value="${payroll.getOvertimePay()}">
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row mb-3 d-flex">
                                                                                    <div class="col-md-6">
                                                                                        <label class="form-label">Status</label>
                                                                                        <select class="form-select" name="status">
                                                                                            <option value="Paid" ${payroll.getStatus() eq 'Paid' ? 'selected' : ''}>Paid</option>
                                                                                            <option value="Pending" ${payroll.getStatus() eq 'Pending' ? 'selected' : ''}>Pending</option>
                                                                                        </select>
                                                                                    </div>
                                                                                    <div class="col-md-6">
                                                                                        <label class="form-label">Total Salary</label>
                                                                                        <input name="totalSalary" type="number" class="form-control" value="${payroll.getTotalSalary()}" readonly>
                                                                                    </div>
                                                                                </div>
                                                                            </form>
                                                                        </div>
                                                                        <div class="modal-footer">
<%--                                                                            <button type="reset" class="btn btn-secondary">Reset</button>--%>
                                                                            <button type="submit" form="addRoomForm" class="btn btn-primary">Update</button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </tr>
                                                    </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>

                                        <div class="tab-pane fade" id="yearly">
                                            <div class="row mb-3">
                                                <div class="col-md-3">
                                                    <select class="form-select">
                                                        <option>2025</option>
                                                        <option>2024</option>
                                                        <option>2023</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="table-responsive">
                                                <table class="table table-hover">
                                                    <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Name</th>
                                                        <th>Total Hours</th>
                                                        <th>Total Days</th>
                                                        <th>Total OT</th>
                                                        <th>Total Salary</th>
                                                        <th>Status</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <tr>
                                                        <td>EMP001</td>
                                                        <td>John Doe</td>
                                                        <td>2112</td>
                                                        <td>264</td>
                                                        <td>144</td>
                                                        <td>$58,320</td>
                                                        <td><span class="badge bg-success">Complete</span></td>
                                                        <td>
                                                            <button class="btn btn-sm btn-info"><i class="bi bi-eye"></i></button>
                                                            <button class="btn btn-sm btn-primary"><i class="bi bi-download"></i></button>
                                                        </td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                        <%--                                        </div>--%>
                                        <%--                                    </div>--%>
                                </div>
                            </div>
                        </div>
<%--                        </c:forEach>--%>

                    </div>
                </div>
            </div>
        </div>
    </div>


</div>

<script src="admin/js/home.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>