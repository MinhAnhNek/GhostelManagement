<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Employee Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="admin/css/employeeDetails.css">
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
        <button class="btn btn-primary" onclick="redirectToServlet('${pageContext.request.contextPath}', 'admin')">
          Back to Dashboard
        </button>
      </div>
    </div>

<%--    <div class="card">--%>
<%--      <div class="card-body">--%>
<%--      </div>--%>
<%--    </div>--%>
<%--  </div>--%>

    <c:set var="emp" value="${sessionScope.emp}"/>
  <div class="container-fluid py-4">
    <div class="row g-4">
      <div class="col-12 col-lg-4">
        <div class="card shadow-sm">
          <div class="card-body text-center">
            <img src="https://images.unsplash.com/photo-1633332755192-727a05c4013d" alt="Employee Profile" class="rounded-circle mb-3" width="120">
            <h5 class="card-title mb-1">${emp.getName()}</h5>
            <p class="text-muted">${emp.getRole()}</p>
            <div class="d-flex justify-content-around mt-4">
              <div>
                <h6>ID</h6>
                <p class="mb-0">#${emp.getId()}</p>
              </div>
              <div>
                <h6>Hotel Branch</h6>
                <p class="mb-0">${emp.getHotelName()}</p>
              </div>
              <div>
                <h6>Status</h6>
                <span class="badge bg-success">${emp.getStatus()}</span>
              </div>
            </div>
          </div>
        </div>
        <div class="card shadow-sm mt-4">
          <div class="card-body">
            <h5 class="card-title">Today's Status</h5>
            <div class="mt-3">
              <div class="d-flex justify-content-between mb-2">
                <span>Clock In</span>
                <span class="text-success">09:00 AM</span>
              </div>
              <div class="d-flex justify-content-between">
                <span>Clock Out</span>
                <span class="text-danger">-- : --</span>
              </div>
              <div class="progress mt-3" style="height: 8px">
                <div class="progress-bar" role="progressbar" style="width: 65%"></div>
              </div>
              <small class="text-muted d-block text-center mt-2">5.2 hrs / 8 hrs</small>
            </div>
          </div>
        </div>
      </div>
      <div class="col-12 col-lg-8">
        <div class="card shadow-sm">
          <div class="card-body">
            <div class="card-title d-flex justify-content-between">
              <h5>Attendance Overview</h5>
              <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#viewRoomModal${emp.getId()}">View All Attendance</button>
            </div>
            <div class="table-responsive mt-3">
              <table class="table table-hover">
                <thead>
                <tr>
                  <th>Date</th>
                  <th>Clock In</th>
                  <th>Clock Out</th>
                  <th>Hours</th>
                  <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="att" items="${sessionScope.attendance}" begin="1" end="3" step="1">
                  <tr>
                    <td>${att.getDate()}</td>
                    <td>${att.getCheckInTime()}</td>
                    <td>${att.getCheckOutTime()}</td>
                    <td>${att.getTotalHours()}</td>
                    <td>
                      <c:if test="${att.getStatus() eq 'Present'}">
                        <span class="badge bg-success">Present</span>
                      </c:if>
                      <c:if test="${att.getStatus() eq 'Late'}">
                        <span class="badge bg-warning">Late</span>
                      </c:if>
                      <c:if test="${att.getStatus() eq 'Absent'}">
                        <span class="badge bg-danger">Absent</span>
                      </c:if>
                      <c:if test="${att.getStatus() eq 'On Leave'}">
                        <span class="badge bg-info">On Leave</span>
                      </c:if>
                    </td>
                  </tr>
                </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
        </div>
        <div class="card shadow-sm mt-4">
          <div class="card-body">
            <h5 class="card-title">Salary Details</h5>
            <div class="row g-4 mt-2">
              <div class="col-md-4">
                <div class="border rounded p-3">
                  <h6 class="text-muted">Base Salary</h6>
                  <h4>${emp.getSalary()}</h4>
                </div>
              </div>
              <div class="col-md-4">
                <div class="border rounded p-3">
                  <h6 class="text-muted">Overtime</h6>
                  <h4>$350</h4>
                </div>
              </div>
              <div class="col-md-4">
                <div class="border rounded p-3">
                  <h6 class="text-muted">Total</h6>
                  <h4>$5,350</h4>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</div>

<div class="modal fade" id="viewRoomModal${emp.getId()}">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">View Employee Attendance</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="table-responsive mt-3">
            <table class="table table-hover">
              <thead>
              <tr>
                <th>Date</th>
                <th>Clock In</th>
                <th>Clock Out</th>
                <th>Hours</th>
                <th>Status</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach var="att" items="${sessionScope.attendance}">
                <tr>
                  <td>${att.getDate()}</td>
                  <td>${att.getCheckInTime()}</td>
                  <td>${att.getCheckOutTime()}</td>
                  <td>${att.getTotalHours()}</td>
                  <td>
                    <c:if test="${att.getStatus() eq 'Present'}">
                      <span class="badge bg-success">Present</span>
                    </c:if>
                    <c:if test="${att.getStatus() eq 'Late'}">
                      <span class="badge bg-warning">Late</span>
                    </c:if>
                    <c:if test="${att.getStatus() eq 'Absent'}">
                      <span class="badge bg-danger">Absent</span>
                    </c:if>
                    <c:if test="${att.getStatus() eq 'On Leave'}">
                      <span class="badge bg-info">On Leave</span>
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
  </div>
</div>
<script src="admin/js/home.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
