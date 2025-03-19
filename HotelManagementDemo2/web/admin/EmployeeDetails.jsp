<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Employee Dashboard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
  <link rel="stylesheet" href="admin/css/employeeDetails.css">
</head>

<body>
<div class="d-flex">
  <div class="sidebar bg-dark p-3">
    <div class="logo mb-4">
        <img src="https://images.unsplash.com/photo-1571896349842-33c89424de2d" alt="Hotel Logo" class="img-fluid rounded-circle">
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
        <div class="card shadow-sm" id="profile">
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
                <span class="badge bg-success"></span>

                <c:if test="${emp.getStatus() eq 'Active'}">
                  <span class="badge bg-success">${emp.getStatus()}</span>
                </c:if>
                <c:if test="${emp.getStatus() eq 'Currently on Vacation'}">
                  <span class="badge bg-warning">${emp.getStatus()}</span>
                </c:if>
                <c:if test="${emp.getStatus() eq 'Deactive'}">
                  <span class="badge bg-danger">${emp.getStatus()}</span>
                </c:if>
              </div>
            </div>
            <div class="mt-4">
              <h6>Contact</h6>
              <div>
                <i class="bi bi-envelope-fill"></i>
                <span>${emp.getMail()}</span>
              </div>
              <div>
                <i class="bi bi-telephone-fill"></i>
                <span>${emp.getPhoneNum()}</span>
              </div>
            </div>
            <div class="mt-4">
              <h6>Address</h6>
              <span>${emp.getAddress()}</span>
            </div>
            <div class="mt-4">
              <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#update">Update Info</button>
            </div>
          </div>
        </div>
        <div class="modal fade" id="update">
          <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
              <div class="modal-header">
                <h4 class="modal-title">Update Information</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
              </div>
              <div class="modal-body">
                <form action="${pageContext.request.contextPath}/updateEmployee" method="get">
                  <div class="row d-flex justify-content-between">
                    <div class="col-md-6 form-group">
                      <label for="avatar" class="col-md-4">Avatar</label>
                      <%--                    <img src="https://images.unsplash.com/photo-1633332755192-727a05c4013d" alt="Employee Profile" class="rounded-circle mb-3" width="120">--%>
                      <input type="file" id="avatar" accept="image/jpeg, image/jpg, image/png" name="image">
                    </div>
                  </div>
                  <div class="row d-flex justify-content-between">
                    <div class="col-md-6 d-flex form-group">
                      <label for="id" class="col-md-4">Employee ID</label>
                      <input type="number" class="form-control" name="id" id="id" value="${emp.getId()}" readonly>
                    </div>
                    <div class="col-md-6  d-flex justify-content-between form-group">
                      <label for="name" class="col-md-4">Name</label>
                      <input type="text" class="form-control" id="name" name="name" value="${emp.getName()}">
                    </div>
                  </div>
                  <div class="row d-flex justify-content-between">
                    <div class="col-md-6 d-flex justify-content-between form-group">
                      <label for="role" class="col-md-4">Role</label>
                      <select name="role" class="form-select" id="role">
                        <c:forEach var="role" items="${sessionScope.roles}">
                          <option value="${role.getRoleName()}" ${emp.getRole() eq role.getRoleName() ? "selected" : ""}  ${role.getRoleName() eq 'Admin' ? 'disabled' : ''}>${role.getRoleName()}</option>
                        </c:forEach>
                      </select>
                    </div>
                    <div class="col-md-6 d-flex justify-content-between form-group">
                      <label for="status" class="col-md-4">Status</label>
                      <select name="status" class="form-select" id="status">
                        <c:forEach var="status" items="${sessionScope.employeeStatuses}">
                          <option value="${status.getName()}" ${emp.getStatus() eq status.getName() ? "selected" : ""}>${status.getName()}</option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>
                  <div class="row d-flex justify-content-between">
                    <div class="col-md-6 d-flex justify-content-between form-group">
                      <label for="salary" class="col-md-4">Base Salary</label>
                      <input type="number" min="0" class="form-control" id="salary" name="salary" value="${emp.getSalary()}">
                    </div>
                    <div class="col-md-6 d-flex justify-content-between form-group">
                      <label for="overtime_pay" class="col-md-4">Overtime Pay</label>
                      <input type="number" min="0" class="form-control" id="overtime_pay" name="overtime_pay" value="${sessionScope.payroll.getFirst().getOvertimePay()}">
                    </div>
                  </div>
                  <div class="row d-flex justify-content-between">
                    <div class="col-md-6 d-flex justify-content-between form-group">
                      <label for="startDate" class="col-md-4">Start Date</label>
                      <input type="date" class="form-control" id="startDate" name="startDate" value="${emp.getStartDate()}">
                    </div>
                    <div class="col-md-6 d-flex justify-content-between form-group">
                      <label for="hotel" class="col-md-4">Hotel Branch</label>
                      <select class="form-select" id="hotel" name="hotelName">
                        <c:forEach var="hotel" items="${sessionScope.hotels}">
                          <option value=" ${hotel.getName()}" ${emp.getHotelName() eq hotel.getName() ? "selected" : ""}>${hotel.getName()}</option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>
                  <div class="row d-flex justify-content-between">
                    <div class="col-md-6 d-flex justify-content-between form-group">
                      <label for="phoneNum" class="col-md-4">Phone Number</label>
                      <input type="tel" class="form-control" id="phoneNum" name="phoneNum" value="${emp.getPhoneNum()}">
                    </div>
                    <div class="col-md-6 d-flex justify-content-between form-group">
                      <label for="mail" class="col-md-4">Email</label>
                      <input type="email" class="form-control" id="mail" name="mail" value="${emp.getMail()}">
                    </div>
                  </div>
                  <div class="row d-flex justify-content-between">
                    <div class="col-md-6 d-flex justify-content-between form-group">
                      <label for="address" class="col-md-4">Address</label>
                      <textarea class="form-control" id="address" name="address" rows="2">${emp.getAddress()}</textarea>
                    </div>
                  </div>
                  <div class="buttons d-flex justify-content-between">
                    <button type="reset" class="btn btn-secondary">Reset</button>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-12 col-lg-8">
        <div class="card shadow-sm">
          <div class="card-body">
            <div class="card-title d-flex justify-content-between">
              <h5>Attendance Overview</h5>
              <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#viewAttendanceModal${emp.getId()}">View All Attendance</button>
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
                <c:if test="${empty sessionScope.attendance}">
                  <div class="alert alert-warning" role="alert">This Employee hasn't got any attendance yet</div>
                </c:if>
                <c:forEach var="att" items="${sessionScope.attendance}" begin="1" end="3" step="1">
                  <tr>
                    <td>${att.getDate()}</td>
                    <td>
                        ${empty att.getCheckInTime() ? "--:--:--" : att.getCheckInTime()}
                    </td>
                    <td>
                        ${empty att.getCheckOutTime() ? "--:--:--" : att.getCheckOutTime()}
                    </td>
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
                      <c:if test="${att.getStatus() eq 'Day Off'}">
                        <span class="badge bg-info">Day Off</span>
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
            <div class="card-title d-flex justify-content-between">
              <h5>Salary Overview</h5>
              <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#viewSalaryModal${emp.getId()}">
                View All Salary
              </button>
            </div>
            <c:set var="payroll" value="${sessionScope.payroll.getFirst()}"/>
            <div class="row g-4 mt-2">
              <div class="col-md-4">
                <div class="border rounded p-3">
                  <h6 class="text-muted">Base Salary</h6>
                  <h4>$${emp.getSalary()}</h4>
                </div>
              </div>
              <div class="col-md-4">
                <div class="border rounded p-3">
                  <h6 class="text-muted">Overtime <span class="text-sm-end" style="font-size: 0.8rem;">$${payroll.getOvertimePay()} * ${payroll.getOvertimeHours()}</span></h6>
                  <h4>$${payroll.getOvertimePay() * payroll.getOvertimeHours()}</h4>
                </div>
              </div>
              <div class="col-md-4">
                <div class="border rounded p-3">
                  <h6 class="text-muted">Total</h6>
                  <h4>$${payroll.getTotalSalary()}</h4>
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

<div class="modal fade" id="viewAttendanceModal${emp.getId()}">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">View Employee Attendance</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
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
            <c:if test="${empty sessionScope.attendance}">
              <div class="alert alert-warning" role="alert">This Employee hasn't got any attendance yet</div>
            </c:if>
            <c:forEach var="att" items="${sessionScope.attendance}">
              <tr>
                <td>${att.getDate()}</td>
                <td>
                    ${empty att.getCheckInTime() ? "--:--:--" : att.getCheckInTime()}
                </td>
                <td>
                    ${empty att.getCheckOutTime() ? "--:--:--" : att.getCheckOutTime()}
                </td>
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
                  <c:if test="${att.getStatus() eq 'Day Off'}">
                    <span class="badge bg-info">Day Off</span>
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


<div class="modal fade" id="viewSalaryModal${emp.getId()}">
  <div class="modal-dialog modal-dialog-scrollable modal-lg modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">View Employee Salary</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="table-responsive mt-3">
            <table class="table table-hover">
              <thead>
              <tr>
                <th>Year</th>
                <th>Month</th>
                <th>Base Salary</th>
                <th>Working Days</th>
                <th>Total Hours</th>
                <th>Overtime Hours</th>
                <th>Overtime Payment</th>
                <th>Total Salary</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach var="payroll" items="${sessionScope.payroll}">
                <tr>
                  <td>${payroll.getSalaryYear()}</td>
                  <td>${payroll.getSalaryMonth()}</td>
                  <td>${payroll.getBaseSalary()}</td>
                  <td>${payroll.getTotalWorkingDays()}</td>
                  <td>${payroll.getTotalHours()}</td>
                  <td>${payroll.getOvertimeHours()}</td>
                  <td>${payroll.getOvertimePay()}</td>
                  <td>${payroll.getTotalSalary()}</td>
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
