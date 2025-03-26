<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Hotel Employee Attendance Management</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
  <link rel="stylesheet" href="admin/css/employeeAttendance.css">
</head>
<body>
<div class="d-flex">
  <div class="sidebar bg-dark p-3">
    <div class="logo mb-4">
      <a href="">
        <img src="https://images.unsplash.com/photo-1571896349842-33c89424de2d" alt="Hotel Logo" class="img-fluid rounded-circle">
      </a>
    </div>
    <div class="mb-4 d-flex justify-content-center align-items-center">
      <a class="link-danger bg-danger text-white rounded-3 p-2" href="${pageContext.request.contextPath}/logout">Log Out</a>
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
        <a class="nav-link active" href="${pageContext.request.contextPath}/EmployeeAttendance" style="border-bottom: none;">
          <i class="bi bi-calendar-check me-2"></i>Employee Attendance
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/EmployeeSalaryDetail" style="border-bottom: none;">
          <i class="bi bi-cash me-2"></i>Employee Salary
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${pageContext.request.contextPath}/EmployeeRequest" style="border-bottom: none;">
          <i class="bi bi-graph-up me-2"></i>Employee Request
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
    <div class="row">
      <nav class="d-flex justify-content-between navbar navbar-expand-lg">
        <h1 class="col-md-6">
          <i class="bi bi-building"></i> Employee Attendance
        </h1>


<%--        <c:if test="${not empty sessionScope.codeSuccess}">--%>
<%--          <div class="col-md-3 p-2">--%>
<%--            <div class="alert alert-success" role="alert">${sessionScope.codeSuccess}</div>--%>
<%--          </div>--%>
<%--          <% session.removeAttribute("codeSuccess"); %>--%>
<%--        </c:if>--%>
<%--        ${not empty sessionScope.codeError ? "" : ""}--%>
        <button class="col-md-3 btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#setAttCode" >Set Today Attendance Code</button>
      </nav>
    </div>

    <div class="row mt-4">
      <div class="col-12">
        <ul class="nav nav-tabs" id="hotelTabs" role="tablist">
          <li class="nav-item" role="presentation">
            <a class="nav-link ${empty requestScope.hotelID ? 'active' : ''}" href="${pageContext.request.contextPath}/EmployeeAttendance" role="tab">Home</a>
          <c:forEach var="hotel" items="${sessionScope.hotels}">
            <li class="nav-item" role="presentation">
              <button class="nav-link ${requestScope.hotelID == hotel.getHotelId() ? "active" : ""}" onclick="redirectToServlet('${pageContext.request.contextPath}', 'EmployeeAttendance?hotelID=${hotel.getHotelId()}')">${hotel.getName()}</button>
            </li>
          </c:forEach>
        </ul>

        <c:set var="lates" value="${sessionScope.lates}"/>
        <c:set var="presents" value="${sessionScope.presents}"/>
        <c:set var="absents" value="${sessionScope.absents}"/>
        <c:set var="dayoffs" value="${sessionScope.dayoffs}"/>
        <c:set var="attendances" value="${sessionScope.attendances}"/>
        <c:set var="hotelAtt" value="${sessionScope.hotelAttendance}"/>

        <div class="tab-content mt-3" id="hotelTabContent">
          <div class="tab-pane fade show active">
            <div class="row">
              <div class="col-lg-6 col-md-6 mb-4">
                <div class="card">
                  <div class="card-body">
                    <h5 class="card-title">Total Employees Attendance</h5>
                    <div class="progress">
                      <c:if test="${not empty presents}">
                        <div class="progress-bar bg-success" role="progressbar" style="width: ${presents.size() / hotelAtt.size() * 100}%" aria-valuenow="${presents.size()}" aria-valuemin="0" aria-valuemax="100">${presents.size()}</div>
                      </c:if>
                      <c:if test="${not empty lates}">
                        <div class="progress-bar bg-warning" role="progressbar" style="width: ${lates.size() / hotelAtt.size() * 100}%" aria-valuenow="${lates.size()}">${lates.size()}</div>
                      </c:if>
                      <c:if test="${not empty absents}">
                        <div class="progress-bar bg-danger" role="progressbar" style="width: ${absents.size() / hotelAtt.size() * 100}%" aria-valuenow="${absents.size()}">${absents.size()}</div>
                      </c:if>
                      <c:if test="${not empty dayoffs}">
                        <div class="progress-bar bg-info" role="progressbar" style="width: ${dayoffs.size() / hotelAtt.size() * 100}%" aria-valuenow="${dayoffs.size()}">${dayoffs.size()}</div>
                      </c:if>
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
            </div>

<%--            <div class="row mb-4">--%>
<%--              <div class="col-12">--%>
<%--                <div class="card">--%>
<%--                  <div class="card-body">--%>
<%--                    <h5 class="card-title">Attendance Trend</h5>--%>
<%--                    <canvas id="attendanceChart" height="100"></canvas>--%>
<%--                  </div>--%>
<%--                </div>--%>
<%--              </div>--%>
<%--            </div>--%>


            <div class="row mb-3">
              <div class="col-md-4">
                <select class="form-select" name="status" aria-label="Filter by" onchange="redirectToServlet('${pageContext.request.contextPath}', 'EmployeeAttendance?hotelID=${requestScope.hotelID}&status=' + this.value)">
                  <option value="">Filter by...</option>
                  <option value="Present" ${requestScope.status eq 'Present' ? 'selected' : ''}>Present</option>
                  <option value="Late" ${requestScope.status eq 'Late' ? 'selected' : ''}>Late</option>
                  <option value="Absent" ${requestScope.status eq 'Absent' ? 'selected' : ''}>Absent</option>
                  <option value="Day Off" ${requestScope.status eq 'Day Off' ? 'selected' : ''}>Day Off</option>
                </select>
              </div>
            </div>

            <div class="row">
              <div class="col-12">
                <div class="table-responsive">
                  <table class="table table-hover">
                    <thead>
                    <tr>
                      <th>Employee ID</th>
                      <th>Employee Name</th>
                      <th>Clock In</th>
                      <th>Clock Out</th>
                      <th>Total Hours</th>
                      <th>Status</th>
                      <th>Actions</th>
                    </tr>
                    </thead>
                    <c:if test="${empty attendances}">
                      <div class="alert alert-warning" role="alert">
                        There are no such attendances.
                      </div>
                    </c:if>
                    <c:forEach var="att" items="${attendances}">
                    <tbody>
                    <tr>
                      <td>${att.getEmployeeID()}</td>
                      <td>${sessionScope.totalEmp.get(att.getEmployeeID()).getName()}</td>
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
                      <td>
                        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#detailsModal${att.getEmployeeID()}">
                          <i class="bi bi-pencil"></i> Edit
                        </button>
                      </td>
                    </tr>

                    </c:forEach>
                    </tbody>
                  </table>
                </div>

<%--                <nav aria-label="Page navigation">--%>
<%--                  <ul class="pagination justify-content-center">--%>
<%--                    <li class="page-item active"><a class="page-link" href="#">1</a></li>--%>
<%--                    <li class="page-item"><a class="page-link" href="#">2</a></li>--%>
<%--                    <li class="page-item"><a class="page-link" href="#">3</a></li>--%>
<%--                  </ul>--%>
<%--                </nav>--%>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<c:forEach var="att" items="${attendances}">
  <!-- Details Modal -->
  <div class="modal fade" id="detailsModal${att.getEmployeeID()}" tabindex="-1" aria-hidden="true">
    <form action="${pageContext.request.contextPath}/EmployeeAttendance" method="post">
      <div class="modal-dialog modal-lg">
        <div class="modal-content p-3">
          <div class="modal-header">
            <h5 class="modal-title" id="detailsModalLabel">Employee Attendance Details</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="row">
              <div class="col-md-6">
                <p class="d-flex">
                  <strong class="col-md-4">Employee ID:</strong>
                  <input class="form-control" type="text" name="employeeID" value="${att.getEmployeeID()}" readonly>
                </p>
                <p class="d-flex">
                  <strong class="col-md-4">Employee Name:</strong>
                  <input class="form-control" type="text" name="employeeName" value="${sessionScope.totalEmp.get(att.getEmployeeID()).getName()}" readonly>
                </p>
                <p class="d-flex">
                  <strong class="col-md-4">Position:</strong>
                  <input class="form-control" type="text" name="position" value="${sessionScope.totalEmp.get(att.getEmployeeID()).getRole()}" readonly>
                </p>
              </div>
              <div class="col-md-6">
<%--                <p><strong>Current Status:</strong>--%>
<%--                  <select class="form-select" name="status">--%>
<%--                    <option class="text-bg-success text-white" value="Present" ${att.getStatus() eq 'Present' ? 'selected' :''}>Present</option>--%>
<%--                    <option class="text-bg-danger text-white" value="Absent" ${att.getStatus() eq 'Absent' ? 'selected' :''}>Absent</option>--%>
<%--                    <option class="text-bg-warning text-white" value="Late" ${att.getStatus() eq 'Late' ? 'selected' :''}>Late</option>--%>
<%--                    <option class="text-bg-info text-white" value="Day Off" ${att.getStatus() eq 'Day Off' ? 'selected' :''}>Day Off</option>--%>
<%--                  </select>--%>
<%--                </p>--%>
                <p class="d-flex">
                  <strong class="col-md-4">Checkin Time: </strong>
                  <input class="form-control" type="time" value="${att.getCheckInTime()}" min="08:30" max="22:00" name="checkInTime" >
                </p>
                <p class="d-flex">
                  <strong class="col-md-4">Checkout Time: </strong>
                  <input class="form-control" type="time" min="08:30" max="22:00" value="${att.getCheckOutTime()}" name="checkOutTime" >
                </p>

                <c:if test="${not empty sessionScope.checkOutTimeError}">
                  <div class="alert alert-danger" role="alert">${sessionScope.checkOutTimeError}</div>
                </c:if>
              </div>
              <div class="alert alert-info col-md-6" role="alert">
                <strong class="text-decoration-underline">Note:</strong>
                <p>
                  Present: Check In time <= 09:00<br>
                  Late: Check In time > 09:00<br>
                  Absent: Left blank all fields
                </p>
              </div>
            </div>
<%--            <hr>--%>
<%--            <h6>Attendance History</h6>--%>
<%--            <div class="table-responsive">--%>
<%--              <table class="table table-sm">--%>
<%--                <thead>--%>
<%--                <tr>--%>
<%--                  <th>Date</th>--%>
<%--                  <th>Clock In</th>--%>
<%--                  <th>Clock Out</th>--%>
<%--                  <th>Status</th>--%>
<%--                </tr>--%>
<%--                </thead>--%>
<%--                <tbody>--%>
<%--                <tr>--%>
<%--                  <td>2024-01-20</td>--%>
<%--                  <td>09:00 AM</td>--%>
<%--                  <td>05:00 PM</td>--%>
<%--                  <td><span class="badge bg-success">Present</span></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                  <td>2024-01-19</td>--%>
<%--                  <td>09:15 AM</td>--%>
<%--                  <td>05:00 PM</td>--%>
<%--                  <td><span class="badge bg-warning">Late</span></td>--%>
<%--                </tr>--%>
<%--                </tbody>--%>
<%--              </table>--%>
<%--            </div>--%>
          </div>
          <div class="modal-footer">
            <button type="reset" class="btn btn-secondary">Reset</button>
            <button type="submit" class="btn btn-primary">Submit</button>
          </div>
        </div>
      </div>
    </form>
  </div>
</c:forEach>

<div class="modal fade" id="setAttCode" tabindex="-1" role="dialog" aria-hidden="true">
  <form action="${pageContext.request.contextPath}/AttendanceCode" method="post">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header d-flex justify-content-between">
          <h5 class="modal-title">Attendance Code Details</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <h4>Add New Code</h4>
            <div class="alert alert-info" role="alert">
              <strong>This code is only available in 1 hour!</strong>
            </div>
            <div class="form-group col-md-12 p-2">
              <label class="control-label">Code</label>
              <input type="text" class="form-control" name="attCode" value="${sessionScope.code}" required>
            </div>
            <div class="d-flex justify-content-between">
              <div class="form-group col-md-6 p-2">
                <label class="control-label">Start Time</label>
                <input type="time" class="form-control" min="08:30" max="12:30" name="startTime" value="${sessionScope.thisCode.getStartTime()}" readonly>
              </div>
              <div class="form-group col-md-6 p-2">
                <label class="control-label">End Time</label>
                <input type="time" class="form-control" min="08:30" max="12:30" name="endTime" value="${sessionScope.thisCode.getEndTime()}" readonly>
              </div>
            </div>
            <c:if test="${not empty sessionScope.codeError}">
              <div class="alert alert-warning">${sessionScope.codeError}</div>
            </c:if>


          </div>
          <div class="table-responsive">
            <table class="table table-hover">
              <tr>
                <th>Code</th>
                <th>Start Time</th>
                <th>End Time</th>
              </tr>
              <c:if test="${empty sessionScope.attCodeList}">
                <div class="alert alert-warning">There is no Attendance Code for today yet</div>
              </c:if>
              <c:forEach var="attCode" items="${sessionScope.attCodeList}">
                <tr>
                  <td>${attCode.getCode()}</td>
                  <td>${attCode.getStartTime()}</td>
                  <td>${attCode.getEndTime()}</td>
                </tr>
              </c:forEach>
            </table>
          </div>
        </div>
        <div class="modal-footer">
          <button type="reset" class="btn btn-secondary">Reset</button>
          <button type="submit" class="btn btn-primary" ${not empty sessionScope.endOfTime ? "disabled" : ""}>${not empty sessionScope.endOfTime ? sessionScope.endOfTime : "Submit"}</button>
        </div>

      </div>
    </div>
  </form>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>

  var show = '${not empty sessionScope.codeError}';
  var success = '${not empty sessionScope.added}';
  // var showEmpAtt = '';
  document.addEventListener("DOMContentLoaded", function() {
    if (success === 'true') {
      alert('${sessionScope.added}');
    }

    if (show === 'true') {
      var myModal = new bootstrap.Modal(document.getElementById('setAttCode'));
      console.log(show);
      myModal.show();
    }

    if (${not empty sessionScope.empID}) {
      var empModal = new bootstrap.Modal(document.getElementById('detailsModal${sessionScope.empID}'));
      // console.log(showEmpAtt);
      empModal.show();
    }
  });
</script>
<script src="admin/js/home.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<%
  session.removeAttribute("code");
  session.removeAttribute("startTime");
  session.removeAttribute("codeError");
  session.removeAttribute("empID");
  session.removeAttribute("added");
%>
</body>
</html>