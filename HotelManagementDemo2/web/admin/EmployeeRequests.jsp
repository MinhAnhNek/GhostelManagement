<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Request Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="admin/css/employeeRequest.css">
    <link rel="stylesheet" href="css/employeeRequest.css">
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
                <a class="nav-link active" href="${pageContext.request.contextPath}/admin" style="border-top-left-radius: var(--radius); border-top-right-radius: var(--radius);">
                    <i class="bi bi-people me-2"></i>
                    Employee Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/RoomManagement"><i class="bi bi-door-open me-2"></i>Room Details</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/EmployeeSalaryDetail" style="border-bottom-left-radius: var(--radius); border-bottom-right-radius: var(--radius);">
                    <i class="bi bi-calendar-check me-2"></i>Employee Salary Detail
                </a>
            </li>
            <%--            <li class="nav-item">--%>
            <%--                <a class="nav-link" href="#"  style="border-bottom-left-radius: var(--radius); border-bottom-right-radius: var(--radius);"><i class="bi bi-graph-up me-2"></i>Finance Overview</a>--%>
            <%--            </li>--%>
        </ul>

    </div>

    <div class="main-content p-4 w-100">
        <div class="row mb-4">
            <div class="col">
                <h2 class="mb-4">Employee Request Management</h2>
                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <div class="card shadow-sm h-100">
                            <div class="card-body">
                                <h6 class="card-subtitle mb-2 text-muted">Total Requests</h6>
                                <h2 class="card-title mb-3">248</h2>
<%--                                <div class="d-flex align-items-center">--%>
<%--                                    <span class="text-success me-2"><i class="bi bi-arrow-up"></i> 12%</span>--%>
<%--                                    <small class="text-muted">vs last month</small>--%>
<%--                                </div>--%>

                                <div class="progress" style="height: 8px;">
                                    <div class="progress-bar bg-success" style="width: 45%"></div>
                                    <div class="progress-bar bg-warning" style="width: 35%"></div>
                                    <div class="progress-bar bg-danger" style="width: 20%"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card shadow-sm h-100">
                            <div class="card-body">
                                <h6 class="card-subtitle mb-2 text-muted">Today's Requests</h6>
                                <h2 class="card-title mb-3">15</h2>
                                <div class="progress" style="height: 8px;">
                                    <div class="progress-bar bg-success" style="width: 45%"></div>
                                    <div class="progress-bar bg-warning" style="width: 35%"></div>
                                    <div class="progress-bar bg-danger" style="width: 20%"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row g-4 mb-4">
                    <div class="col-md-12">
                        <div class="card shadow-sm h-100">
                            <div class="card-body">
                                <h6 class="card-subtitle mb-2 text-muted">Request Type Distribution</h6>
                                <canvas id="requestTypeChart" style="height: 200px; width: 200px;"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card shadow-sm">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/EmployeeRequest" method="get">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <select class="form-select" id="requestType">
                                        <option value="">All Request Type</option>
                                        <c:forEach var="type" items="${sessionScope.requestTypes}">
                                            <option value="${type.getId()}">${type.getName()}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <select class="form-select" id="hotelBranch">
                                        <option value="">All Hotel Branch</option>
                                        <c:forEach var="hotel" items="${sessionScope.hotels}">
                                            <option value="${hotel.getHotelId()}">${hotel.getName()}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-search"></i></span>
                                        <input type="text" class="form-control" placeholder="Search by Employee Name">
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <ul class="nav nav-tabs mb-4" id="requestTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="all-tab" data-bs-toggle="tab" data-bs-target="#all" type="button">All Requests</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending" type="button">Pending</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="approved-tab" data-bs-toggle="tab" data-bs-target="#approved" type="button">Approved</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="rejected-tab" data-bs-toggle="tab" data-bs-target="#rejected" type="button">Rejected</button>
                            </li>
                        </ul>

                        <div class="tab-content" id="requestTabContent">
                            <div class="tab-pane fade show active" id="all" role="tabpanel">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle">
                                        <thead>
                                        <tr>
                                            <th>Request ID</th>
                                            <th>Employee Name</th>
                                            <th>Request Type</th>
                                            <th>Time Submitted</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="request" items="${sessionScope.requests}">
                                            <tr>
                                                <td>${request.getEmployeeID()}</td>
                                                <td>${sessionScope.employees.get(request.getEmployeeID()).getName()}</td>
                                                <td>${sessionScope.requestTypes.get(request.getTypeID() - 1).getName()}</td>
                                                <td>${request.getAppliedDate()}</td>
                                                <td>
                                                    <c:if test="${request.getStatus() == 'Approved'}">
                                                        <span class="badge bg-success">${request.getStatus()}</span>
                                                    </c:if>
                                                    <c:if test="${request.getStatus() == 'Rejected'}">
                                                        <span class="badge bg-danger">${request.getStatus()}</span>
                                                    </c:if>
                                                    <c:if test="${request.getStatus() == 'Pending'}">
                                                        <span class="badge bg-warning">Pending</span>
                                                    </c:if>
                                                </td>
                                                <td><button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#requestModal${request.getId()}"><i class="bi bi-eye"></i> View</button></td>
                                            </tr>
                                            <div class="modal fade" id="requestModal${request.getId()}" tabindex="-1">
                                                <div class="modal-dialog modal-lg">
                                                    <div class="modal-content">
                                                        <form action="${pageContext.request.contextPath}/EmployeeRequest" method="POST">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title">Request Details</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <div class="row mb-3">
                                                                    <div class="col-md-6 d-flex">
                                                                        <p>
                                                                            <strong class="col-md-6">Request ID:</strong>
                                                                            <input type="text" value="${request.getId()}" readonly>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="col-md-6">Employee ID:</strong>
                                                                            <input type="text" value="${request.getEmployeeID()}" readonly>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="col-md-6">Full Name:</strong>
                                                                            <input type="text" value="${sessionScope.employees.get(request.getEmployeeID()).getName()}" readonly>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="col-md-6">Hotel:</strong>
                                                                            <input type="text" value="${sessionScope.employees.get(request.getEmployeeID()).getHotelName()}" readonly>
                                                                        </p>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <p>
                                                                            <strong class="col-md-6">Request Type:</strong>
                                                                            <input type="text" value="${sessionScope.requestTypes.get(request.getTypeID() - 1).getName()}" readonly>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="col-md-6">Submission Date:</strong>
                                                                            <input type="text" value="${request.getAppliedDate()}" readonly>
                                                                        </p>
                                                                        <p>
                                                                            <strong class="col-md-6">Status:</strong>
                                                                            <c:if test="${request.getStatus() == 'Approved'}">
                                                                                <span class="badge bg-success">${request.getStatus()}</span>
                                                                            </c:if>
                                                                            <c:if test="${request.getStatus() == 'Rejected'}">
                                                                                <span class="badge bg-danger">${request.getStatus()}</span>
                                                                            </c:if>
                                                                            <c:if test="${request.getStatus() == 'Pending'}">
                                                                                <span class="badge bg-warning">Pending</span>
                                                                            </c:if>
                                                                        </p>
                                                                    </div>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <h6>Request Details</h6>
                                                                    <textarea class="form-control" rows="2">${request.getReason()}</textarea>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Admin Feedback</label>
                                                                    <textarea class="form-control" rows="3" name="AdminFeedback"></textarea>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="submit" name="submit" value="approved" class="btn btn-success" ${request.getStatus() eq 'Pending' ? 'disable' : ''}><i class="bi bi-check-lg"></i> Approve</button>
                                                                <button type="submit" name="submit" value="rejected" class="btn btn-danger" ${request.getStatus() eq 'Pending' ? 'disable' : ''}><i class="bi bi-x-lg"></i> Reject</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <c:forEach var="requestStatus" items="${sessionScope.requestStatuses}">
                                <div class="tab-pane fade" id="${requestStatus}" role="tabpanel">
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle">
                                            <thead>
                                            <tr>
                                                <th>Request ID</th>
                                                <th>Employee Name</th>
                                                <th>Request Type</th>
                                                <th>Date Submitted</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="request" items="${sessionScope.requests}">
                                                <c:if test="${request.getStatus() eq requestStatus}}">
                                                    <tr>
                                                        <td>${request.getEmployeeID()}</td>
                                                        <td>${sessionScope.employees.get(request.getEmployeeID()).getName()}</td>
                                                        <td>${sessionScope.requestTypes.get(request.getTypeID() - 1).getName()}</td>
                                                        <td>${request.getAppliedDate()}</td>
                                                        <td>
                                                            <c:if test="${request.getStatus() == 'Approved'}">
                                                                <span class="badge bg-success">${request.getStatus()}</span>
                                                            </c:if>
                                                            <c:if test="${request.getStatus() == 'Rejected'}">
                                                                <span class="badge bg-danger">${request.getStatus()}</span>
                                                            </c:if>
                                                            <c:if test="${request.getStatus() == 'Pending'}">
                                                                <span class="badge bg-warning">Pending</span>
                                                            </c:if>

                                                        </td>
                                                        <td>
                                                            <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#requestModal${request.getId() + requestStatus}">
                                                                <i class="bi bi-eye"></i> View
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <div class="modal fade" id="requestModal${request.getId() + requestStatus}" tabindex="-1">
                                                        <div class="modal-dialog modal-lg">
                                                            <div class="modal-content">
                                                                <form action="${pageContext.request.contextPath}/EmployeeRequest" method="POST">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title">Request Details</h5>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="row mb-3">
                                                                            <div class="col-md-6 d-flex">
                                                                                <p>
                                                                                    <strong class="col-md-6">Request ID:</strong>
                                                                                    <input type="text" value="${request.getId()}" readonly>
                                                                                </p>
                                                                                <p>
                                                                                    <strong class="col-md-6">Employee ID:</strong>
                                                                                    <input type="text" value="${request.getEmployeeID()}" readonly>
                                                                                </p>
                                                                                <p>
                                                                                    <strong class="col-md-6">Full Name:</strong>
                                                                                    <input type="text" value="${sessionScope.employees.get(request.getEmployeeID()).getName()}" readonly>
                                                                                </p>
                                                                                <p>
                                                                                    <strong class="col-md-6">Hotel:</strong>
                                                                                    <input type="text" value="${sessionScope.employees.get(request.getEmployeeID()).getHotelName()}" readonly>
                                                                                </p>
                                                                            </div>
                                                                            <div class="col-md-6">
                                                                                <p>
                                                                                    <strong class="col-md-6">Request Type:</strong>
                                                                                    <input type="text" value="${sessionScope.requestTypes.get(request.getTypeID() - 1).getName()}" readonly>
                                                                                </p>
                                                                                <p>
                                                                                    <strong class="col-md-6">Submission Date:</strong>
                                                                                    <input type="text" value="${request.getAppliedDate()}" readonly>
                                                                                </p>
                                                                                <p>
                                                                                    <c:if test="${request.getStatus() == 'Approved'}">
                                                                                        <span class="badge bg-success">${request.getStatus()}</span>
                                                                                    </c:if>
                                                                                    <c:if test="${request.getStatus() == 'Rejected'}">
                                                                                        <span class="badge bg-danger">${request.getStatus()}</span>
                                                                                    </c:if>
                                                                                    <c:if test="${request.getStatus() == 'Pending'}">
                                                                                        <span class="badge bg-warning">Pending</span>
                                                                                    </c:if>

                                                                                </p>
                                                                            </div>
                                                                        </div>
                                                                        <div class="mb-3">
                                                                            <h6>Request Details</h6>
                                                                            <textarea class="form-control" rows="2">${request.getReason()}</textarea>
                                                                        </div>
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Admin Feedback</label>
                                                                            <textarea class="form-control" rows="3" name="AdminFeedback"></textarea>
                                                                        </div>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="submit" name="submit" value="approved" class="btn btn-success" ${request.getStatus() eq 'Pending' ? 'disable' : ''}><i class="bi bi-check-lg"></i> Approve</button>
                                                                        <button type="submit" name="submit" value="rejected" class="btn btn-danger" ${request.getStatus() eq 'Pending' ? 'disable' : ''}><i class="bi bi-x-lg"></i> Reject</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                            </c:forEach>

<%--                            <div class="tab-pane fade" id="approved" role="tabpanel">--%>
<%--                                <div class="table-responsive">--%>
<%--                                    <table class="table table-hover align-middle">--%>
<%--                                        <thead>--%>
<%--                                        <tr>--%>
<%--                                            <th>Request ID</th>--%>
<%--                                            <th>Employee Name</th>--%>
<%--                                            <th>Request Type</th>--%>
<%--                                            <th>Time Submitted</th>--%>
<%--                                            <th>Status</th>--%>
<%--                                            <th>Actions</th>--%>
<%--                                        </tr>--%>
<%--                                        </thead>--%>
<%--                                        <tbody>--%>
<%--                                        <tr>--%>
<%--                                            <td>#REQ002</td>--%>
<%--                                            <td>Jane Smith</td>--%>
<%--                                            <td>Equipment Request</td>--%>
<%--                                            <td>2024-01-14</td>--%>
<%--                                            <td><span class="badge bg-success">Approved</span></td>--%>
<%--                                            <td><button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#requestModal"><i class="bi bi-eye"></i> View</button></td>--%>
<%--                                        </tr>--%>
<%--                                        </tbody>--%>
<%--                                    </table>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                            <div class="tab-pane fade" id="rejected" role="tabpanel">--%>
<%--                                <div class="table-responsive">--%>
<%--                                    <table class="table table-hover align-middle">--%>
<%--                                        <thead>--%>
<%--                                        <tr>--%>
<%--                                            <th>Request ID</th>--%>
<%--                                            <th>Employee Name</th>--%>
<%--                                            <th>Request Type</th>--%>
<%--                                            <th>Time Submitted</th>--%>
<%--                                            <th>Status</th>--%>
<%--                                            <th>Actions</th>--%>
<%--                                        </tr>--%>
<%--                                        </thead>--%>
<%--                                        <tbody>--%>
<%--                                        <tr>--%>
<%--                                            <td>#REQ003</td>--%>
<%--                                            <td>Mike Johnson</td>--%>
<%--                                            <td>Training Request</td>--%>
<%--                                            <td>2024-01-13</td>--%>
<%--                                            <td><span class="badge bg-danger">Rejected</span></td>--%>
<%--                                            <td><button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#requestModal"><i class="bi bi-eye"></i> View</button></td>--%>
<%--                                        </tr>--%>
<%--                                        </tbody>--%>
<%--                                    </table>--%>
<%--                                </div>--%>
<%--                            </div>--%>
                        </div>

                        <nav aria-label="Page navigation" class="mt-4">
                            <ul class="pagination justify-content-end">
                                <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item"><a class="page-link" href="#">Next</a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>
        </div>
    </div>


</div>

<script>
    const canvas = document.getElementById('requestTypeChart');
    const ctx = canvas.getContext('2d');
    const values = [10, 20, 15, 25, 5, 25];
    const colors = ['red', 'blue', 'green', 'yellow', 'purple', 'orange'];
    const total = values.reduce((acc, val) => acc + val, 0); // Total = 100
    const centerX = canvas.width / 2;  // 200
    const centerY = canvas.height / 2; // 200
    const radius = 150;
    let startAngle = 0;
    values.forEach((value, index) => {
        const sliceAngle = (value / total) * 2 * Math.PI;
        ctx.beginPath();
        ctx.moveTo(centerX, centerY);
        ctx.arc(centerX, centerY, radius, startAngle, startAngle + sliceAngle);
        ctx.lineTo(centerX, centerY);
        ctx.fillStyle = colors[index];
        ctx.fill();
        ctx.strokeStyle = 'black';
        ctx.stroke();
        startAngle += sliceAngle;
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>