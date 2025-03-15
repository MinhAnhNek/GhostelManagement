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
                <img src="https://images.unsplash.com/photo-1571896349842-33c89424de2d" alt="Hotel Logo" class="img-fluid rounded-circle">
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
                    <a class="nav-link" href="#"><i class="bi bi-calendar-check me-2"></i>Booking Details</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"  style="border-bottom-left-radius: var(--radius); border-bottom-right-radius: var(--radius);"><i class="bi bi-graph-up me-2"></i>Finance Overview</a>
                </li>

            </ul>
        </div>

        <div class="main-content p-4 w-100">
            <div class="mb-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2>Employee Management</h2>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addEmployeeModal">
                        <i class="bi bi-plus-circle me-2"></i>Add New Employee
                    </button>
                </div>
                <form action="${pageContext.request.contextPath}/SearchEmployee" method="get">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3>Filter Options</h3>
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
                                <input name="phoneNum" type="text" class="form-control" id="Phone" placeholder="Enter Phone" value="${sessionScope.phoneNum}">
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
                            <select name="type" class="form-select" style="width: 25%" id="type">
                                <option value="name" ${fn:contains(requestScope.type, "name") ? 'selected' : ''}>Sort by Name Ascending</option>
                                <option value="name desc" ${fn:contains(requestScope.type, "name desc") ? 'selected' : ''}>Sort by Name Descending</option>
                                <option value="salary" ${fn:contains(requestScope.type, "salary") ? 'selected' : ''}>Sort by Salary Ascending</option>
                                <option value="salary desc" ${fn:contains(requestScope.type, "salary desc") ? 'selected' : ''}>Sort by Salary Descending</option>
                                <option value="startDate" ${fn:contains(requestScope.type, "startDate") ? 'selected' : ''}>Sort by Start Date Ascending</option>
                                <option value="startDate desc" ${fn:contains(requestScope.type, "startDate desc") ? 'selected' : ''}>Sort by Start Date Descending</option>
                                <option value="" ${empty requestScope.type ? 'selected' : ''}>Sort by Employee ID</option>
                            </select>
                            <button class="btn btn-secondary" type="button" onclick="redirectToSearchServlet('${pageContext.request.contextPath}', 'SearchRoom')">Reset all Filters</button>
                            <button class="btn btn-primary" type="submit" id="filterButton">Filter</button>
                        </div>
                    </div>
                </form>


            </div>

<%--            <c:set var="employees" value="${sessionScope.employees}"/>--%>
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
                                            <button class="btn btn-sm btn-info me-2" onclick="redirectToSearchServlet('${pageContext.request.contextPath}', 'admin?id=${employee.getId()}')">
                                                <i class="bi bi-eye"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <!-- Center-aligned -->
                        <ul class="pagination justify-content-center" style="margin: 1.5rem 0 0 0">
                            <c:forEach var="pageNumber" begin="1" end="7">
                                <li class="page-item">
                                    <button class="page-link ${requestScope.pageNo == pageNumber ? "active" : ""}" onclick="redirectToSearchServlet('${pageContext.request.contextPath}', 'admin?pageNo=${pageNumber}')">${pageNumber}</button>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="addEmployeeModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="container py-5">
                    <div class="row justify-content-center">
                        <div class="col-12 col-lg-10">
                            <div class="card shadow-lg border-0">
                                <div class="card-header bg-transparent border-0 pt-4">
                                    <div class="d-flex align-items-center">
<%--                                        <a href="#" class="btn btn-outline-primary me-3">--%>
<%--                                            <i class="bi bi-arrow-left"></i> Back--%>
<%--                                        </a>--%>
                                        <h1 class="mb-0">Add New Hotel Employee</h1>
                                    </div>
                                </div>
                                <div class="card-body p-4">
                                    <form action="${pageContext.request.contextPath}/addEmployee" method="post" class="needs-validation" novalidate>
                                        <div class="row g-4">
                                            <div class="col-12 col-md-6">
                                                <label class="form-label">Full Name</label>
                                                <input type="text" name="name" class="form-control" required minlength="2" maxlength="50" placeholder="Enter full name">
                                                <div class="invalid-feedback">Please enter a valid name (2-50 characters)</div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label class="form-label">Role</label>
                                                <select class="form-select" name="role" required>
                                                    <option value="">Choose...</option>
                                                    <c:forEach var="role" items="${sessionScope.roles}">
                                                        <option value="${role.getRoleName()}">${role.getRoleName()}</option>
                                                    </c:forEach>
                                                </select>
                                                <div class="invalid-feedback">Please select a role</div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label class="form-label">Monthly Salary</label>
                                                <input name="salary" type="number" class="form-control" min="0" required placeholder="Enter monthly salary">
                                                <div class="invalid-feedback">Please enter a valid salary amount</div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label class="form-label">Start Date</label>
                                                <input name="startDate" type="date" class="form-control" required max="2025-12-31">
                                                <div class="invalid-feedback">Please select a valid start date</div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label class="form-label">Hotel</label>
                                                <select name="hotelName" class="form-select" required>
                                                    <option value="">Choose...</option>
                                                    <c:forEach var="hotel" items="${sessionScope.hotels}">
                                                        <option value="${hotel.getName()}">${hotel.getName()}</option>
                                                    </c:forEach>
                                                </select>
                                                <div class="invalid-feedback">Please select a hotel</div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label class="form-label">Email Address</label>
                                                <input name="mail" type="email" class="form-control" required placeholder="Enter email address">
                                                <div class="invalid-feedback">Please enter a valid email address</div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label class="form-label">Phone Number</label>
                                                <input name="phoneNum" type="tel" class="form-control" required pattern="[+][0-9]{1,3}\s?[(]?[0-9]{3}[)]?[-\s]?[0-9]{3}[-\s]?[0-9]{4}" placeholder="+1 (123) 456-7890">
                                                <div class="invalid-feedback">Please enter a valid phone number</div>
                                            </div>
                                            <div class="col-12 col-md-6">
                                                <label class="form-label">Status</label>
                                                <select name="status" class="form-select" required>
                                                    <c:forEach var="status" items="${sessionScope.employeeStatus}">
                                                        <option value="${status.getName()}">${status.getName()}</option>
                                                    </c:forEach>
                                                </select>
                                                <div class="invalid-feedback">Please select a status</div>
                                            </div>
                                            <div class="col-12">
                                                <label class="form-label">Residential Address</label>
                                                <textarea name="address" class="form-control" rows="3" required minlength="10" placeholder="Enter full residential address"></textarea>
                                                <div class="invalid-feedback">Please enter a valid address (minimum 10 characters)</div>
                                            </div>
                                            <div class="col-12 d-flex gap-2 justify-content-end mt-4">
                                                <button type="reset" class="btn btn-outline-secondary">Clear Form</button>
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
                </div>
            </div>
        </div>
    </div>


    <script src="admin/js/home.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
