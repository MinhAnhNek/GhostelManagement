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
<%--    <link rel="stylesheet" href="css/employeeRequest.css">--%>
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
                <a class="nav-link" href="${pageContext.request.contextPath}/admin" style="border-top-left-radius: var(--radius); border-top-right-radius: var(--radius); border-bottom: none;">
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
                <a class="nav-link active" href="${pageContext.request.contextPath}/EmployeeRequest" style="border-bottom: none;">
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
        <div class="row mb-4">
            <div class="col">
                <h2 class="mb-4">Employee Request Management</h2>
                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <div class="card shadow-sm h-100">
                            <div class="card-body">
                                <h6 class="card-subtitle mb-2 text-muted">Total Requests</h6>
                                <h2 class="card-title mb-3">${sessionScope.totalRequest.size()}</h2>
<%--                                <div class="d-flex align-items-center">--%>
<%--                                    <span class="text-success me-2"><i class="bi bi-arrow-up"></i> 12%</span>--%>
<%--                                    <small class="text-muted">vs last month</small>--%>
<%--                                </div>--%>

                                <div class="progress">
                                    <div class="progress-bar bg-success" style="width: ${sessionScope.requestStatusDistribution.get(0) / sessionScope.totalRequest.size() * 100}%" aria-valuemin="0" aria-valuemax="100">
<%--                                        <c:if test="${not empty sessionScope.requestStatusDistribution.get(0)}">--%>
                                            ${sessionScope.requestStatusDistribution.get(0)}
<%--                                        </c:if>--%>
                                    </div>
                                    <div class="progress-bar bg-warning" style="width: ${sessionScope.requestStatusDistribution.get(1) / sessionScope.totalRequest.size() * 100}%">
                                        <c:if test="${sessionScope.requestStatusDistribution.size() >= 2}">
                                            ${sessionScope.requestStatusDistribution.get(1)}
                                        </c:if>
                                    </div>
                                    <div class="progress-bar bg-danger" style="width: ${sessionScope.requestStatusDistribution.get(2) / sessionScope.totalRequest.size() * 100}%">
                                        <c:if test="${sessionScope.requestStatusDistribution.size() >= 3}">
                                            ${sessionScope.requestStatusDistribution.get(2)}
                                        </c:if>
                                    </div>
                                </div>
                                <div class="mt-3 d-flex justify-content-between">
                                    <div class="badge rounded-pill bg-success">Accepted</div>
                                    <div class="badge rounded-pill bg-warning">Pending</div>
                                    <div class="badge rounded-pill bg-danger">Rejected</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card shadow-sm h-100">
                            <div class="card-body">
                                <h6 class="card-subtitle mb-2 text-muted">Today's Requests</h6>
                                <c:if test="${sessionScope.todayRequest.size() != 0}">
                                    <h2 class="card-title mb-3">${sessionScope.todayRequest.get(0)}</h2>
                                    <div class="progress">
                                        <div class="progress-bar bg-success" style="width: ${sessionScope.requestStatusDistributionToday.get(0) / sessionScope.todayRequest.size() * 100}%">
<%--                                            <c:if test="${sessionScope.requestStatusDistributionToday.get(0)}">--%>
                                                ${sessionScope.requestStatusDistributionToday.get(0)}
<%--                                            </c:if>--%>
                                        </div>
                                        <div class="progress-bar bg-warning" style="width: ${sessionScope.requestStatusDistributionToday.get(1) / sessionScope.todayRequest.size() * 100}%">
                                            <c:if test="${sessionScope.requestStatusDistributionToday.size() >= 2}">
                                                ${sessionScope.requestStatusDistributionToday.get(1)}
                                            </c:if>
                                        </div>
                                        <div class="progress-bar bg-danger" style="width: ${sessionScope.requestStatusDistributionToday.get(2) / sessionScope.todayRequest.size() * 100}%">
                                            <c:if test="${sessionScope.requestStatusDistributionToday.size() >= 3}">
                                                ${sessionScope.requestStatusDistributionToday.get(2)}
                                            </c:if>
                                        </div>
                                    </div>
                                </c:if>

                                <c:if test="${sessionScope.todayRequest.size() == 0}">
                                    <h2 class="card-title mb-3">${sessionScope.todayRequest.size()}</h2>
                                </c:if>
                                <div class="mt-3 d-flex justify-content-between">
                                    <div class="badge rounded-pill bg-success">Accepted</div>
                                    <div class="badge rounded-pill bg-warning">Pending</div>
                                    <div class="badge rounded-pill bg-danger">Rejected</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <div class="card shadow-sm h-100">
                            <div class="card-body">
                                <h6 class="card-subtitle mb-2 text-muted">Request Type Distribution</h6>
                                <canvas id="requestTypeChart" style="width:100%;max-width:600px"></canvas>

                                <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
                                <script>
                                    var xValues = [];
                                    <c:forEach var="requestType" items="${sessionScope.requestTypes}">
                                        xValues.push('${requestType.getName()}');
                                    </c:forEach>
                                    var yValues = [];
                                    <c:forEach var="count" items="${sessionScope.requestTypesDistribution}">
                                        yValues.push('${count / sessionScope.totalRequest.size() * 100}');
                                    </c:forEach>
                                    var barColors = ["red", "green","blue","orange","brown", "violet", "yellow"];

                                    new Chart("requestTypeChart", {
                                        type: "bar",
                                        data: {
                                            labels: xValues,
                                            datasets: [{
                                                backgroundColor: barColors,
                                                data: yValues
                                            }]
                                        },
                                        options: {
                                            legend: {display: false},
                                            title: {
                                                display: true,
                                                text: "Request Type Distribution"
                                            }
                                        }
                                    });
                                </script>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card shadow-sm h-100">
                            <div class="card-body">
                                <h6 class="card-subtitle mb-2 text-muted">Hotel Request Distribution</h6>
                                <canvas id="hotelRequestChart" style="width:100%;max-width:600px"></canvas>
                                <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
                                <script>
                                    var xValues2 = [];
                                    <c:forEach var="hotel" items="${sessionScope.hotels}">
                                        xValues2.push('${hotel.getName()}');
                                    </c:forEach>

                                    var yValues2 = [];
                                    <c:forEach var="count" items="${sessionScope.hotelRequestDistribution}">
                                        yValues2.push('${count / sessionScope.totalRequest.size() * 100}');
                                    </c:forEach>

                                    var barColors2 = ["red", "green","blue","orange","brown"];

                                    new Chart("hotelRequestChart", {
                                        type: "bar",
                                        data: {
                                            labels: xValues2,
                                            datasets: [{
                                                backgroundColor: barColors2,
                                                data: yValues2
                                            }]
                                        },
                                        options: {
                                            legend: {display: false},
                                            title: {
                                                display: true,
                                                text: "Hotel Request Distribution"
                                            }
                                        }
                                    });
                                </script>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card shadow-sm">
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/EmployeeRequest" method="get">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <select name="RequestTypeID" class="form-select" id="requestType">
                                        <option value="">All Request Type</option>
                                        <c:forEach var="type" items="${sessionScope.requestTypes}">
                                            <option value="${type.getId()}" ${requestScope.RequestTypeID == type.getId() ? 'selected' : ''}>${type.getName()}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <select class="form-select" id="hotelBranch" name="HotelID">
                                        <option value="">All Hotel Branch</option>
                                        <c:forEach var="hotel" items="${sessionScope.hotels}">
                                            <option value="${hotel.getHotelId()}" ${requestScope.HotelID == hotel.getHotelId() ? 'selected' : ''}>${hotel.getName()}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <div class="input-group">
                                        <input type="text" class="form-control" placeholder="Search by Employee Name" name="Name" value="${requestScope.Name}">
                                    </div>
                                </div>
                                <div class="col-md-1">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-search"></i>
                                    </button>
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
                                <button class="nav-link" id="pending-tab" data-bs-toggle="tab" data-bs-target="#Pending" type="button">Pending</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="approved-tab" data-bs-toggle="tab" data-bs-target="#Approved" type="button">Approved</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="rejected-tab" data-bs-toggle="tab" data-bs-target="#Rejected" type="button">Rejected</button>
                            </li>
                        </ul>

                        <div class="tab-content" id="requestTabContent">
                            <div class="tab-pane fade show active" id="all" role="tabpanel">
                                <c:if test="${empty sessionScope.requests}">
                                    <div class="alert alert-warning" role="alert">There is no such request</div>
                                </c:if>
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle">
                                        <thead>
                                        <tr>
<%--                                            <th>Request ID</th>--%>
                                            <th>Employee ID</th>
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
<%--                                                <td>${request.getId()}</td>--%>
                                                <td>${request.getEmployeeID()}</td>
                                                <td>${sessionScope.employees.get(request.getEmployeeID()).getName()}</td>
                                                <td>${sessionScope.requestTypes.get(request.getTypeID() - 1).getName()}</td>
                                                <td>${request.getAppliedDate().substring(0,19)}</td>
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
                                                        <form action="${pageContext.request.contextPath}/UpdateRequest" method="get">
                                                            <div class="modal-header">
                                                                <h5 class="modal-title">Request Details</h5>
                                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                            </div>
                                                            <div class="modal-body">
                                                                <div class="row mb-3">
                                                                    <div class="col-md-6">
                                                                        <p class="d-flex">
                                                                            <strong class="col-md-6">Request ID:</strong>
                                                                            <input type="text" name="requestID" class="form-control" value="${request.getId()}" readonly>
                                                                        </p>
                                                                        <p class="d-flex">
                                                                            <strong class="col-md-6">Employee ID:</strong>
                                                                            <input type="text" class="form-control" value="${request.getEmployeeID()}" readonly>
                                                                        </p>
                                                                        <p class="d-flex">
                                                                            <strong class="col-md-6">Full Name:</strong>
                                                                            <input type="text" class="form-control" value="${sessionScope.employees.get(request.getEmployeeID()).getName()}" readonly>
                                                                        </p>
                                                                        <p class="d-flex">
                                                                            <strong class="col-md-6">Hotel:</strong>
                                                                            <input type="text" class="form-control" value="${sessionScope.employees.get(request.getEmployeeID()).getHotelName()}" readonly>
                                                                        </p>
                                                                    </div>
                                                                    <div class="col-md-6">
                                                                        <p class="d-flex">
                                                                            <strong class="col-md-6">Request Type:</strong>
                                                                            <input type="text" class="form-control" value="${sessionScope.requestTypes.get(request.getTypeID() - 1).getName()}" readonly>
                                                                        </p>
                                                                        <p class="d-flex">
                                                                            <strong class="col-md-6">Submission Date:</strong>
                                                                            <input type="text" class="form-control" value="${request.getAppliedDate().substring(0,19)}" readonly>
                                                                        </p>
                                                                        <p class="d-flex">
                                                                            <strong class="col-md-6">Request Status:</strong>
                                                                            <c:if test="${request.getStatus() == 'Approved'}">
                                                                                <span class="badge bg-success">${request.getStatus()}</span>
                                                                            </c:if>
                                                                            <c:if test="${request.getStatus() == 'Rejected'}">
                                                                                <span class="badge bg-danger">${request.getStatus()}</span>
                                                                            </c:if>
                                                                            <c:if test="${request.getStatus() == 'Pending'}">
                                                                                <span class="badge bg-warning">${request.getStatus()}</span>
                                                                            </c:if>
                                                                        </p>
                                                                        <p class="d-flex">
                                                                            <strong class="col-md-6">Replied Date:</strong>
                                                                            <input type="text" class="form-control" value="${request.getRepliedDate() == null ? 'Not Yet' : request.getRepliedDate().substring(0,19)}" readonly>
                                                                        </p>
                                                                    </div>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <h6>Request Details</h6>
                                                                    <textarea class="form-control" rows="2" readonly>${request.getReason()}</textarea>
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label">Admin Feedback</label>
                                                                    <textarea class="form-control" rows="3" name="AdminFeedback">${request.getFeedback()}</textarea>
                                                                </div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <% session.setAttribute("to", "EmployeeRequest"); %>
                                                                <button type="submit" name="status" value="Approved" class="btn btn-success" ${request.getStatus() eq 'Pending' ? '' : 'disabled'}><i class="bi bi-check-lg"></i> Approve</button>
                                                                <button type="submit" name="status" value="Rejected" class="btn btn-danger" ${request.getStatus() eq 'Pending' ? '' : 'disabled'}><i class="bi bi-x-lg"></i> Reject</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <nav aria-label="Page navigation" class="mt-4">
                                    <ul class="pagination justify-content-end">
                                        <%--                                <li class="page-item disabled"><a class="page-link" href="${pageContext.request.contextPath}/EmployeeRequest?pageNo=">Previous</a></li>--%>
                                        <c:forEach var="pageNo" begin="1" end="${requestScope.maxPage}" step="1">
                                            <li class="page-item">
                                                <a class="page-link ${requestScope.pageNo == pageNo ? 'active' : ''}" href="${pageContext.request.contextPath}/EmployeeRequest?pageNo=${pageNo}">
                                                        ${pageNo}
                                                </a>
                                            </li>
                                        </c:forEach>
                                        <%--                                <li class="page-item"><a class="page-link" href="#">Next</a></li>--%>
                                    </ul>
                                </nav>
                            </div>

                            <c:forEach var="requestStatus" items="${sessionScope.requestStatuses}">
                                <div class="tab-pane fade" id="${requestStatus}" role="tabpanel">
                                    <c:if test="${empty sessionScope.requests}">
                                        <div class="alert alert-warning" role="alert">There is no such request</div>
                                    </c:if>
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle">
                                            <thead>
                                            <tr>
<%--                                                <th>Request ID</th>--%>
                                                <th>Employee ID</th>
                                                <th>Employee Name</th>
                                                <th>Request Type</th>
                                                <th>Date Submitted</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach var="request" items="${sessionScope.requests}">
<%--                                                <c:out value="${request.getStatus()}"/>--%>
                                                <c:if test="${request.getStatus() eq requestStatus}">
                                                    <tr>
<%--                                                        <td>${request.getId()}</td>--%>
                                                        <td>${request.getEmployeeID()}</td>
                                                        <td>${sessionScope.employees.get(request.getEmployeeID()).getName()}</td>
                                                        <td>${sessionScope.requestTypes.get(request.getTypeID() - 1).getName()}</td>
                                                        <td>${request.getAppliedDate().substring(0,19)}</td>
                                                        <td>
                                                            <c:if test="${request.getStatus() == 'Approved'}">
                                                                <span class="badge bg-success">${request.getStatus()}</span>
                                                            </c:if>
                                                            <c:if test="${request.getStatus() == 'Rejected'}">
                                                                <span class="badge bg-danger">${request.getStatus()}</span>
                                                            </c:if>
                                                            <c:if test="${request.getStatus() == 'Pending'}">
                                                                <span class="badge bg-warning">${request.getStatus()}</span>
                                                            </c:if>

                                                        </td>
                                                        <td>
                                                            <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#requestModal${request.getId()}${requestStatus}">
                                                                <i class="bi bi-eye"></i> View
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <div class="modal fade" id="requestModal${request.getId()}${requestStatus}" tabindex="-1">
                                                        <div class="modal-dialog modal-lg">
                                                            <div class="modal-content">
                                                                <form action="${pageContext.request.contextPath}/UpdateRequest" method="POST">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title">Request Details</h5>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <div class="row mb-3">
                                                                            <div class="col-md-6">
                                                                                <p class="d-flex">
                                                                                    <strong class="col-md-6">Request ID:</strong>
                                                                                    <input type="text" name="requestID" class="form-control" value="${request.getId()}" readonly>
                                                                                </p>
                                                                                <p class="d-flex">
                                                                                    <strong class="col-md-6">Employee ID:</strong>
                                                                                    <input type="text" class="form-control" value="${request.getEmployeeID()}" readonly>
                                                                                </p>
                                                                                <p class="d-flex">
                                                                                    <strong class="col-md-6">Full Name:</strong>
                                                                                    <input type="text" class="form-control" value="${sessionScope.employees.get(request.getEmployeeID()).getName()}" readonly>
                                                                                </p>
                                                                                <p class="d-flex">
                                                                                    <strong class="col-md-6">Hotel:</strong>
                                                                                    <input type="text" class="form-control" value="${sessionScope.employees.get(request.getEmployeeID()).getHotelName()}" readonly>
                                                                                </p>
                                                                            </div>
                                                                            <div class="col-md-6">
                                                                                <p class="d-flex">
                                                                                    <strong class="col-md-6">Request Type:</strong>
                                                                                    <input type="text" class="form-control" value="${sessionScope.requestTypes.get(request.getTypeID() - 1).getName()}" readonly>
                                                                                </p>
                                                                                <p class="d-flex">
                                                                                    <strong class="col-md-6">Submission Date:</strong>
                                                                                    <input type="text" class="form-control" value="${request.getAppliedDate().substring(0,19)}" readonly>
                                                                                </p>
                                                                                <p class="d-flex">
                                                                                    <strong class="col-md-6">Request Status:</strong>
                                                                                    <c:if test="${request.getStatus() == 'Approved'}">
                                                                                        <span class="badge bg-success">${request.getStatus()}</span>
                                                                                    </c:if>
                                                                                    <c:if test="${request.getStatus() == 'Rejected'}">
                                                                                        <span class="badge bg-danger">${request.getStatus()}</span>
                                                                                    </c:if>
                                                                                    <c:if test="${request.getStatus() == 'Pending'}">
                                                                                        <span class="badge bg-warning">${request.getStatus()}</span>
                                                                                    </c:if>
                                                                                </p>
                                                                            </div>
                                                                        </div>
                                                                        <div class="mb-3">
                                                                            <h6>Request Details</h6>
                                                                            <textarea class="form-control" rows="2" readonly>${request.getReason()}</textarea>
                                                                        </div>
                                                                        <div class="mb-3">
                                                                            <label class="form-label">Admin Feedback</label>
                                                                            <textarea class="form-control" rows="3" name="AdminFeedback" required></textarea>
                                                                        </div>
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <button type="submit" name="status" value="approved" class="btn btn-success"  ${request.getStatus() eq 'Pending' ? '' : 'disabled'}><i class="bi bi-check-lg"></i> Approve</button>
                                                                        <button type="submit" name="status" value="rejected" class="btn btn-danger"  ${request.getStatus() eq 'Pending' ? '' : 'disabled'}<i class="bi bi-x-lg"></i> Reject</button>
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
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>