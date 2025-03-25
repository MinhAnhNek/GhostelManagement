<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="employee/css/home.css" rel="stylesheet">
</head>
<body>
<c:set var="emp" value="${sessionScope.emp}"/>
<nav class="navbar navbar-expand-lg fixed-top bg-white shadow-sm">
    <div class="container-fluid">
<%--        <a class="navbar-brand" href="#">--%>
<%--            <img src="https://images.unsplash.com/photo-1599305445671-ac291c95aaa9" width="40" height="40" class="rounded-circle" alt="Company Logo">--%>
<%--        </a>--%>
        <div class="col-md-12 d-flex align-items-center justify-content-between m-2">
            <button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#attendanceCode">Set Attendance by Code</button>
            <img src="https://images.unsplash.com/photo-1633332755192-727a05c4013d" width="40" height="40" class="rounded-circle me-2" alt="Profile">
            <a href="${pageContext.request.contextPath}/logout" class="bg-danger text-decoration-none text-white rounded-3 p-2">Log out</a>
        </div>
    </div>
</nav>

<div class="container-fluid mt-5 pt-4">
    <div class="row g-4">
        <div class="col-lg-3 col-md-6">
            <div class="card h-100 shadow-sm hover-card">
                <div class="card-header bg-primary text-white">Profile Overview</div>
                <div class="card-body text-center">
                    <img src="https://images.unsplash.com/photo-1633332755192-727a05c4013d" class="rounded-circle mb-3" width="80" height="80" alt="Employee Photo">
                    <h5>${emp.getName()}</h5>
                    <p class="text-muted mb-1">${emp.getRole()}</p>
                    <p class="text-muted">${emp.getHotelName()}</p>
                    <div class="mt-3">
                        <span class="badge bg-info">Employee ID: ${emp.getId()}</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-6">
            <div class="card h-100 shadow-sm hover-card">
                <div class="card-header bg-success text-white">Weekly Schedule</div>
                <div class="card-body">
                    <c:set var="schedule" value="${sessionScope.schedule}"/>
                    <c:forEach var="day" items="${schedule.getWorkDays()}">
                        <div class="schedule-item d-flex justify-content-between align-items-center mb-2">
                            <span>${day}</span>
                            <span class="badge bg-success">${schedule.getShiftStart()} - ${schedule.getShiftEnd()}</span>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-6">
            <div class="card h-100 shadow-sm hover-card">
                <div class="d-flex justify-content-between card-header bg-info text-white">
                    Attendance Overview
                    <button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#allAttendance">View all</button>
                </div>
                <div class="card-body text-center">
                    <div class="attendance-circle mb-3">
                        <h2><fmt:formatNumber type="percent" maxFractionDigits="2" value = "${sessionScope.monthlyPresentCount / sessionScope.attendances.size()}"/></h2>
                        <p class="text-muted">Monthly Attendance</p>
                    </div>
                    <div class="row g-2">
                        <div class="col-6">
                            <div class="p-2 bg-success-subtle rounded">
                                <h6>Present</h6>
                                <span>${sessionScope.monthlyPresentCount} days</span>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-2 bg-danger-subtle rounded">
                                <h6>Absent</h6>
                                <span>${sessionScope.monthlyAbsentCount} day</span>
                            </div>
                        </div>
                    </div>
                    <div class="row g-2 mt-2">
                        <div class="col-6">
                            <div class="p-2 bg-warning-subtle rounded">
                                <h6>Late</h6>
                                <span>${sessionScope.monthlyLateCount} days</span>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="p-2 bg-info-subtle rounded">
                                <h6>Day Off</h6>
                                <span>${sessionScope.monthlyDayOffCount} day</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-3 col-md-6">
            <div class="card h-100 shadow-sm hover-card">
                <div class="card-header bg-warning text-dark">Salary Information</div>
                <c:set value="${sessionScope.payroll.getFirst()}" var="payroll"/>
                <div class="card-body">
                    <h3 class="text-center mb-4">$${payroll.getTotalSalary()}</h3>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Basic Salary</span>
                        <span>$${payroll.getBaseSalary()}</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Bonus</span>
                        <span class="text-success">$${payroll.getOvertimeHours() * payroll.getOvertimePay()}</span>
                    </div>
<%--                    <div class="d-flex justify-content-between mb-2">--%>
<%--                        <span>Deductions</span>--%>
<%--                        <span class="text-danger">-$500</span>--%>
<%--                    </div>--%>
                    <hr>
                    <div class="d-flex justify-content-between">
                        <strong>Net Salary</strong>
                        <strong>$${payroll.getTotalSalary()}</strong>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <div class="row mt-4 mb-4">
        <div class="col-12">
            <div class="card shadow-sm hover-card">
                <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
                    <ul class="nav nav-tabs card-header-tabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="all-tab" data-bs-toggle="tab" data-bs-target="#all" type="button" role="tab">Pending Requests</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link " id="pending-tab" data-bs-toggle="tab" data-bs-target="#pending" type="button" role="tab">Pending Requests</button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="answered-tab" data-bs-toggle="tab" data-bs-target="#answered" type="button" role="tab">Answered Requests</button>
                        </li>
                    </ul>
                    <button class="btn btn-light btn-sm" data-bs-toggle="modal" data-bs-target="#request" type="button">New Request</button>
                </div>
                <div class="card-body">
                    <div class="tab-content" id="requestTabContent">
                        <div class="tab-pane fade show active" id="all" role="tabpanel">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th>Type</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${empty sessionScope.requests}">
                                        <div class="alert alert-warning text-center">There is No Requests made</div>
                                    </c:if>
                                    <c:forEach var="request" items="${sessionScope.requests}">
                                        <tr>
                                            <td>
                                                <c:forEach var="requestType" items="${sessionScope.requestTypes}">
                                                    <c:if test="${requestType.getId() eq request.getTypeID()}">
                                                        ${requestType.getName()}
                                                    </c:if>
                                                </c:forEach>
                                            </td>
<%--                                            <td>${request.getAppliedDate()}</td>--%>
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
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#requestModal${request.getId()}">
                                                    View
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="pending" role="tabpanel">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th>Type</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${empty sessionScope.requests}">
                                        <div class="alert alert-warning">There is no pending Requests</div>
                                    </c:if>
                                    <c:forEach var="request" items="${sessionScope.requests}">
                                        <c:if test="${request.getStatus() == 'Pending'}">
                                            <tr>
                                                <td>
                                                    <c:forEach var="requestType" items="${sessionScope.requestTypes}">
                                                        <c:if test="${requestType.getId() eq request.getTypeID()}">
                                                            ${requestType.getName()}
                                                        </c:if>
                                                    </c:forEach>
                                                </td>
<%--                                                <td>${request.getAppliedDate()}</td>--%>
                                                <td>${request.getAppliedDate().substring(0,19)}</td>
                                                <td>
                                                    <span class="badge bg-warning">Pending</span>
                                                </td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#requestModal${request.getId()}">
                                                        View
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="answered" role="tabpanel">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th>Type</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${empty sessionScope.requests}">
                                        <div class="alert alert-warning">There is no answered request</div>
                                    </c:if>
                                    <c:forEach var="request" items="${sessionScope.requests}">
                                        <c:if test="${request.getStatus() != 'Pending'}">
                                            <tr>
                                                <td>
                                                    <c:forEach var="requestType" items="${sessionScope.requestTypes}">
                                                        <c:if test="${requestType.getId() eq request.getTypeID()}">
                                                            ${requestType.getName()}
                                                        </c:if>
                                                    </c:forEach>
                                                </td>
<%--                                                <td><fmt:formatDate type="both" dateStyle="medium" timeStyle="medium" value="${request.getAppliedDate()}" /></td>--%>
                                                <td>${request.getAppliedDate().substring(0,19)}</td>
                                                <td>
                                                    <c:if test="${request.getStatus() == 'Approved'}">
                                                        <span class="badge bg-success">${request.getStatus()}</span>
                                                    </c:if>
                                                    <c:if test="${request.getStatus() == 'Rejected'}">
                                                        <span class="badge bg-danger">${request.getStatus()}</span>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#requestModal${request.getId()}">
                                                        View
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<c:forEach var="request" items="${sessionScope.requests}">
    <div class="modal fade" id="requestModal${request.getId()}" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Request Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <p class="d-flex">
                                <strong class="col-md-4">Request ID:</strong>
                                <input type="text" class="form-control" value="${request.getId()}" readonly>
                            </p>
                            <p class="d-flex">
                                <strong class="col-md-4">Request Type:</strong>
                                <input type="text" class="form-control" value="${sessionScope.requestTypes.get(request.getTypeID() - 1).getName()}" readonly>
                            </p>
                        </div>
                        <div class="col-md-6">
                            <p class="d-flex">
                                <strong class="col-md-4">Submission Date:</strong>
                                <input type="text" class="form-control" value="${request.getAppliedDate().substring(0,19)}" readonly>
                            </p>
                            <p class="d-flex">
                                <strong class="col-md-4">Request Status:</strong>
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
                        <label class="form-label">
                            Admin Feedback
                            <span class="text text-sm-end"> ${empty request.getRepliedDate() ? "" : request.getRepliedDate()}</span>
                        </label>
                        <textarea class="form-control" rows="3" name="AdminFeedback" readonly>${request.getFeedback()}</textarea>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:forEach>


<div class="modal fade" id="attendanceCode" tabindex="-1">
    <form class="modal-dialog modal-dialog-centered" action="employee" method="POST">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Attends with Code</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row">
<%--                    <% request.setAttribute("empID", ) %>--%>
                    <input class="form-control" type="text" name="attCode" placeholder="Enter Attendance Code" value="${sessionScope.attCode}">
                    <c:if test="${not empty sessionScope.wrongCode}">
                        <div class="alert alert-danger mt-3" role="alert">Invalid code</div>
                    </c:if>
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary">Submit</button>
            </div>
        </div>
    </form>
</div>


<div class="modal fade" id="allAttendance" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">All Attendance This Month</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th>Date</th>
                            <th>Clock In</th>
                            <th>Clock Out</th>
                            <th>Total Hours</th>
                            <th>Status</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="att" items="${sessionScope.attendances}">
                            <tr>
                                <td>${att.getDate()}</td>
                                <td>${att.getCheckInTime()}</td>
                                <td>${att.getCheckOutTime()}</td>
                                <td>${att.getTotalHours()}</td>
                                <td>
                                    <c:if test="${att.getStatus() == 'Present'}">
                                        <span class="badge bg-success">${att.getStatus()}</span>
                                    </c:if>
                                    <c:if test="${att.getStatus() == 'Absent'}">
                                        <span class="badge bg-danger">${att.getStatus()}</span>
                                    </c:if>
                                    <c:if test="${att.getStatus() == 'Late'}">
                                        <span class="badge bg-warning">${att.getStatus()}</span>
                                    </c:if>
                                    <c:if test="${att.getStatus() == 'Day Off'}">
                                        <span class="badge bg-info">${att.getStatus()}</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
<%--                <button type="submit" class="btn btn-primary">Submit</button>--%>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="request" tabindex="-1">
    <form class="modal-dialog modal-dialog-centered" action="EmployeeRequest" method="POST">
        <div class="modal-content p-2">
            <div class="modal-header">
                <h4 class="modal-title">New Request</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">EmployeeID:</div>
                        <input type="number" class="form-control" name="employeeID" value="${emp.getId()}" readonly>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">Employee Name:</div>
                        <input type="text" class="form-control" name="employeeName" value="${emp.getName()}" readonly>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <strong class="col-md-6">Request Type:</strong>
                        <select class="form-select" name="requestType">
                            <c:forEach var="requestType" items="${sessionScope.requestTypes}">
                                <option value="${requestType.getId()}" selected="selected">${requestType.getName()}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div>Reason:</div>
                        <textarea class="form-control" rows="3" name="reason"></textarea>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary">Submit</button>
            </div>
        </div>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>

    var show = '${not empty sessionScope.wrongCode}';
    var success = '${not empty sessionScope.successAttend}';
    // var showEmpAtt = '';
    document.addEventListener("DOMContentLoaded", function() {
        if (success === 'true') {
            alert('${sessionScope.successAttend}');
        }
        if (show === 'true') {
            var myModal = new bootstrap.Modal(document.getElementById('attendanceCode'));
            console.log(show);
            myModal.show();
        }
    });
</script>
<%
    session.removeAttribute("wrongCode");
    session.removeAttribute("successAttend");
%>
</body>
</html>

