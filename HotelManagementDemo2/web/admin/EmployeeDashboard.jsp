<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="admin/css/home.css">
<%--    <link rel="stylesheet" href="EmployeeManagement/css/add.css">--%>

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
                <%--            <li class="nav-item">--%>
                <%--                <a class="nav-link" href="" style="border-top-left-radius: var(--radius); border-top-right-radius: var(--radius);"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>--%>
                <%--            </li>--%>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/admin" style="border-top-left-radius: var(--radius); border-top-right-radius: var(--radius); border-bottom: none;">
                        <i class="bi bi-people me-2"></i>
                        Employee Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/EmployeeSalaryDetail" style="border-bottom: none;">
                        <i class="bi bi-calendar-check me-2"></i>Employee Salary Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/EmployeeRequest" style="border-bottom: none;">
                        <i class="bi bi-graph-up me-2"></i>Employee Request Dashboard
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/RoomManagement" style="border-bottom-left-radius: var(--radius); border-bottom-right-radius: var(--radius);">
                        <i class="bi bi-door-open me-2"></i>Room Details
                    </a>
                </li>
            </ul>
        </div>

        <div class="main-content p-4 w-100">
            <div class="mb-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2>Employee Management</h2>
                    <c:if test="${not empty requestScope.error}">
                        <div class="alert alert-warning" role="alert">
                                ${requestScope.error}
                        </div>
                    </c:if>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addEmployeeModal">
                        <i class="bi bi-plus-circle me-2"></i>Add New Employee
                    </button>
                </div>

<%--                Dash board --%>
                <div class="row g-4">
                    <div class="col-md-6 col-lg-6">
                        <div class="card h-100">
                            <div class="card-body">
                                <h6 class="card-subtitle mb-2">Total Employees</h6>
                                <h2 class="card-title mb-0 text-center">${sessionScope.totalEmp.size()}</h2>
                                <div class="mt-3">
                                    <div class="progress mt-2">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: ${sessionScope.activeEmp * 100 / sessionScope.totalEmp.size()}%" aria-valuenow="${sessionScope.activeEmp}" aria-valuemin="0" aria-valuemax="100">${sessionScope.activeEmp}</div>
                                        <div class="progress-bar bg-warning" role="progressbar" style="width: ${sessionScope.onVacation * 100 / sessionScope.totalEmp.size()}%">${sessionScope.onVacation}</div>
                                        <div class="progress-bar bg-danger" role="progressbar" style="width: ${sessionScope.deactiveEmp * 100 / sessionScope.totalEmp.size()}%">${sessionScope.deactiveEmp}</div>
                                    </div>
                                </div>
                                <div class="mt-3 d-flex justify-content-between">
                                    <div class="badge rounded-pill bg-success">Active</div>
                                    <div class="badge rounded-pill bg-warning">On Vacation</div>
                                    <div class="badge rounded-pill bg-danger">Deactive</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-6">
                        <div class="card h-100">
                            <div class="card-body">
                                <c:set var="atworkEmp" value="${sessionScope.presentEmp + sessionScope.lateEmp}"/>
                                <h6 class="card-subtitle mb-2">Today Status</h6>
                                <h2 class="card-title mb-0 text-center">${atworkEmp}</h2>
                                <div class="mt-3">
                                    <div class="progress mt-2">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: ${sessionScope.presentEmp * 100 / atworkEmp}%" aria-valuenow="${sessionScope.presentEmp}" aria-valuemin="0" aria-valuemax="100">${sessionScope.presentEmp}</div>
                                        <div class="progress-bar bg-warning" role="progressbar" style="width: ${sessionScope.lateEmp * 100 / atworkEmp}%">${sessionScope.lateEmp}</div>
                                        <div class="progress-bar bg-danger" role="progressbar" style="width: ${sessionScope.absentEmp.size() * 100 / atworkEmp}%">${sessionScope.absentEmp.size()}</div>
                                        <div class="progress-bar bg-info" role="progressbar" style="width: ${sessionScope.dayoff.size() * 100 / atworkEmp}%">${sessionScope.dayoff.size()}</div>
                                    </div>
                                </div>
                                <div class="mt-3 d-flex justify-content-between">
                                    <span class="badge rounded-pill bg-success">Present</span>
                                    <span class="badge rounded-pill bg-warning">Late</span>
                                    <span class="badge rounded-pill bg-danger">Absent</span>
                                    <span class="badge rounded-pill bg-info">Day Off</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-8">
                        <div class="card h-100">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="card-title mb-0">Top Salary this Month</h5>
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-primary" type="button" onclick="redirectToServlet('${pageContext.request.contextPath}', 'EmployeeSalaryDetail')">
                                        View All
                                    </button>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                        <tr>
                                            <th>Employee</th>
                                            <th>Hotel</th>
                                            <th>Salary</th>
                                            <th>Status</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="pay" items="${sessionScope.payrolls}" begin="1" step="1" end="3">
                                            <c:set var="emp" value="${sessionScope.totalEmp.get(pay.getEmployeeID())}"/>
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e" class="rounded-circle me-2" width="32" height="32" alt="">
                                                        <div>${emp.getName()}</div>
                                                    </div>
                                                </td>
                                                <td>${emp.getHotelName()}</td>
                                                <td>${pay.getTotalSalary()}</td>
                                                <td>
                                                    <c:if test="${pay.getStatus() eq 'Paid'}">
                                                        <span class="badge bg-success">${pay.getStatus()}</span>
                                                    </c:if>
                                                    <c:if test="${pay.getStatus() eq 'Pending'}">
                                                        <span class="badge bg-warning">${pay.getStatus()}</span>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="card h-100">
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h5 class="card-title mb-0">Recent Pending Requests</h5>
                                <button type="button" class="btn btn-primary" onclick="redirectToServlet('${pageContext.request.contextPath}', 'EmployeeRequest')">
                                    View All
                                </button>
                            </div>
                            <div class="card-body">
                                <c:if test="${not empty sessionScope.pendingRequests}">
                                    <c:forEach items="${sessionScope.pendingRequests}" var="request" begin="0" end="1" step="1">
                                        <div class="d-flex align-items-start mb-3">
                                            <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e" class="rounded-circle me-2" width="32" height="32" alt="">
                                            <div class="flex-grow-1">
                                                <small class="float-end text-navy">${request.getAppliedDate().substring(0,10)}</small>
                                                <div><strong>${request.employeeID} - ${sessionScope.totalEmp.get(request.getEmployeeID()).getName()}</strong></div>
                                                <div>${sessionScope.requestTypes.get(request.getTypeID() - 1).getName()}</div>
<%--                                                <div>${sessionScope.requestTypes.get(request.getTypeID() - 1).getName()}</div>--%>
                                                    <%--                                            <small class="text-muted">${request.get}</small>--%>
                                                <div class="mt-2">
                                                    <% session.setAttribute("to", "admin"); %>
                                                    <button type="submit" class="btn btn-sm btn-success me-1" onclick="redirectToServlet('${pageContext.request.contextPath}', 'UpdateRequest?requestID=${request.getId()}&to=admin&status=Approved')">Approve</button>
                                                    <button type="submit" class="btn btn-sm btn-danger" onclick="redirectToServlet('${pageContext.request.contextPath}', 'UpdateRequest?requestID=${request.getId()}&to=admin&status=Rejected')">Reject</button>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${empty sessionScope.pendingRequests}">
                                    <div class="alert alert-success" role="alert">There are no recently pending request left</div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div><br>

                <form action="${pageContext.request.contextPath}/admin" method="get">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3>Employee List</h3>
                        <button type="button" class="btn btn-primary" onclick="showFilter()" id="filterBtn">
                            <i class="bi bi-plus-circle me-2"></i>Show Filters
                        </button>
                    </div>
                    <div class="hidden" id="filterContainer">
                        <div class="row g-3 search-row">
                            <div class="col-md-3 form-group">
                                <label for="employeeID">Employee ID</label>
                                <input name="employeeID" type="text" class="form-control" id="employeeID" placeholder="Enter Employee ID" value="${sessionScope.employeeID}">
                            </div>
                            <div class="col-md-3 form-group">
                                <label for="employeeName">Employee Name</label>
                                <input name="name" type="text" class="form-control" id="employeeName" placeholder="Enter Employee Name" value="${sessionScope.name}">
                            </div>
                            <div class="col-md-3 form-group">
                                <label for="status">Status</label>
                                <select name="statusID" class="form-select" id="status">
                                    <c:forEach var="status" items="${sessionScope.employeeStatuses}">
                                        <option value="${status.getId()}" ${fn:contains(status.getId(), sessionScope.statusID) ? "selected" : ""}>${status.getName()}</option>
                                    </c:forEach>
                                    <option value="" ${empty sessionScope.statusID ? "selected" : ""}>Select all Status</option>
                                </select>
                            </div>
                            <div class="col-md-3 form-group">
                                <label for="role">Employee Role</label>
                                <select name="roleID" class="form-select" id="role">
                                    <c:forEach var="role" items="${sessionScope.roles}">
                                        <option value="${role.getRoleId()}" ${fn:contains(role.getRoleId(), sessionScope.roleID) ? "selected" : ""}>${role.getRoleName()}</option>
                                    </c:forEach>
                                    <option value="" ${empty sessionScope.roleID ? "selected" : ""}>Select all Role</option>
                                </select>
                            </div>
                        </div>
                        <div class="row g-3 search-row">
                            <div class="col-md-3 form-group">
                                <label for="Mail">Mail</label>
                                <input name="mail" type="text" class="form-control" id="Mail" placeholder="Enter Mail" value="${sessionScope.mail}">
                            </div>
                            <div class="col-md-3 form-group">
                                <label for="Phone">Phone Number</label>
                                <input name="phoneNum" type="tel" class="form-control" id="Phone" placeholder="Enter Phone" value="${sessionScope.phoneNum}">
                            </div>
                            <div class="col-md-3 form-group">
                                <label for="salary">Salary</label>
                                <div class="input-group d-flex justify-context-between" id="salary">
                                    <div class="col-md-6 min-salary">
                                        <input name="minSalary" type="number" class="form-control" placeholder="Min Salary" value="${sessionScope.minSalary}">
                                    </div>
                                    <div class="col-md-6 max-salary">
                                        <input name="maxSalary" type="number" class="form-control" placeholder="Max Salary" value="${sessionScope.maxSalary}">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 form-group">
                                <label for="hotelName">Hotel Branch</label>
                                <select name="hotelID" class="form-select" id="hotelName">
                                    <c:forEach var="hotel" items="${sessionScope.hotels}">
                                        <option value="${hotel.getHotelId()}" ${fn:contains(hotel.getHotelId(), sessionScope.hotelID) ? "selected" : ""}> ${hotel.getName()}</option>
                                    </c:forEach>
                                    <option value="" ${empty sessionScope.hotelID ? "selected" : ""}>Select all Hotel</option>
                                </select>
                            </div>
                        </div>
                        <div class="buttons">
                            <select name="sortType" class="form-select" style="width: 25%" id="type">
                                <option value="name" ${requestScope.sortType eq "name" ? "selected" : ""}>Sort by Name Ascending</option>
                                <option value="name desc" ${requestScope.sortType eq "name desc" ? 'selected' : ''}>Sort by Name Descending</option>
                                <option value="salary" ${requestScope.sortType eq "salary" ? 'selected' : ''}>Sort by Salary Ascending</option>
                                <option value="salary desc" ${requestScope.sortType eq "salary desc" ? "selected" : ""}>Sort by Salary Descending</option>
                                <option value="startDate" ${requestScope.sortType eq "startDate" ? "selected" : ""}>Sort by Start Date Ascending</option>
                                <option value="startDate desc" ${requestScope.sortType eq "startDate desc" ? "selected" : ""}>Sort by Start Date Descending</option>
                                <option value="" ${empty requestScope.sortType ? "selected" : ""}>Sort by Employee ID</option>
                            </select>
                            <button class="btn btn-secondary" type="button" onclick="redirectToServlet('${pageContext.request.contextPath}', 'admin')">Reset all Filters</button>
                            <button class="btn btn-primary" type="submit" id="filterButton">Filter</button>
                        </div>
                    </div>
                </form>
            </div>

            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th>Employee ID</th>
                                <th>Name</th>
                                <th>Position</th>
                                <th>Department</th>
                                <th>Contact</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody id="employeeTable">
                                <c:forEach var="employee" items="${sessionScope.employees}">
                                    <tr>
                                        <td>${employee.getId()}</td>
                                        <c:forEach var="eStatus" items="${sessionScope.employeeStatuses}">
                                            <c:if test="${eStatus.getName() eq employee.getStatus()}">
                                                <td class="status-${eStatus.getId()}">${employee.getName()}</td>
                                            </c:if>
                                        </c:forEach>
<%--                                        <td>--%>
<%--                                                <img src="https://images.unsplash.com/photo-1557862921-37829c790f19" class="employee-avatar me-2" alt="Employee">--%>
<%--                                        </td>--%>
                                        <td>${employee.getRole()}</td>
                                        <td>${employee.getHotelName()}</td>
                                        <td>${employee.getMail()}</td>
                                        <td>
                                            <c:if test="${emp.getRole() != 'Admin'}">
                                                <button class="btn btn-sm btn-info me-2" onclick="redirectToServlet('${pageContext.request.contextPath}', 'admin?id=${employee.getId()}')">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <!-- Center-aligned -->
                        <ul class="pagination justify-content-center" style="margin: 1.5rem 0 0 0">
                            <c:forEach var="pageNumber" begin="1" end="${requestScope.maxPage}">
                                <li class="page-item">
                                    <button class="page-link ${requestScope.pageNo == pageNumber ? "active" : ""}" onclick="redirect(window.location.href, 'pageNo=${pageNumber}')">
                                        ${pageNumber}
                                    </button>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade " id="addEmployeeModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header d-flex justify-content-between align-items-center">
<%--                    <div class="card-header bg-transparent border-0 pt-4 justify-content-center">--%>
<%--                        <div class="">--%>
<%--                                        <a href="#" class="btn btn-outline-primary me-3">--%>
<%--                                            <i class="bi bi-arrow-left"></i> Back--%>
<%--                                        </a>--%>
                            <h1 class="mb-0">Add New Hotel Employee</h1>

                            <c:if test="${not empty requestScope.error}">
                                <div class="alert alert-warning" role="alert">
                                        ${requestScope.error}
                                </div>
                            </c:if>
                            <button class="btn btn-close btn-warning" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
<%--                        </div>--%>
<%--                    </div>--%>
                </div>
                <div class="modal-body">
                    <form action="${pageContext.request.contextPath}/admin" method="post">
                        <div class="row g-4">
                            <div class="col-12 col-md-6">
                                <label class="form-label">Full Name</label>
                                <input type="text" name="name" class="form-control" required minlength="2" maxlength="50" placeholder="Enter full name" value="${requestScope.name}">
                            </div>
                            <div class="col-12 col-md-6">
                                <label class="form-label">Role</label>
                                <select class="form-select" name="role" required>
                                    <option value="">Choose Role</option>
                                    <c:forEach var="role" items="${sessionScope.roles}">
                                        <option value="${role.getRoleName()}" ${role.getRoleName() eq 'Admin' ? 'disabled' : ''} ${requestScope.role eq role.getRoleName() ? 'selected' : ''}>${role.getRoleName()}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-12 col-md-6">
                                <label class="form-label">Monthly Salary</label>
                                <input name="salary" type="number" class="form-control" min="0" value="${requestScope.salary}" required placeholder="Enter monthly salary">
                            </div>
                            <div class="col-12 col-md-6">
                                <label class="form-label">Overtime pay (per hour)</label>
                                <input name="overtime_pay" type="number" class="form-control" min="0" placeholder="Enter overtime pay" value="${requestScope.overtime_pay}" required>
                            </div>
                            <div class="col-12 col-md-6">
                                <label class="form-label">Hotel</label>
                                <select name="hotelName" class="form-select" required>
                                    <option value="">Choose Hotel</option>
                                    <c:forEach var="hotel" items="${sessionScope.hotels}">
                                        <option value="${hotel.getName()}" ${requestScope.hotelName eq hotel.getName() ? 'selected' : ''}>${hotel.getName()}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-12 col-md-6">
                                <label class="form-label">Email Address</label>
                                <input name="mail" type="email" class="form-control" required placeholder="Enter email address" value="${requestScope.mail}">
                            </div>
                            <div class="col-12 col-md-6">
                                <label class="form-label">Phone Number</label>
                                <input name="phoneNum" type="number" class="form-control" required placeholder="+1 (123) 456-7890" value="${requestScope.phoneNum}">
                            </div>
                            <div class="col-12 col-md-6">
                                <label class="form-label">Temporary Password</label>
                                <input name="password" type="text" class="form-control" required placeholder="Enter temporary password" value="${requestScope.password}">
                            </div>

                            <div class="col-12">
                                <label class="form-label">Residential Address</label>
                                <textarea name="address" class="form-control" rows="3" required minlength="10" placeholder="Enter full residential address">${requestScope.address}</textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <div class="col-12 d-flex gap-2 justify-content-end mt-4">
<%--                                <button type="reset" class="btn btn-outline-secondary">Clear Form</button>--%>
                                <button type="submit" class="btn btn-primary" id="submitBtn">
                                    <span class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
                                    Submit
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <script src="admin/js/home.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
