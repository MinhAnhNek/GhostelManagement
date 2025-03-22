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
    <div class="row">
      <nav class="navbar navbar-expand-lg bg-primary">
        <div class="container-fluid">
          <a class="navbar-brand text-white" href="#"><i class="bi bi-building"></i> Employee Attendance Manager</a>
        </div>
      </nav>
    </div>

    <div class="row mt-4">
      <div class="col-12">
        <ul class="nav nav-tabs" id="hotelTabs" role="tablist">
          <c:forEach var="hotel" items="${sessionScope.hotels}">
            <li class="nav-item" role="presentation">
              <button class="nav-link ${requestScope.hotelID == hotel.getHotelId() ? "active" : ""}" data-bs-toggle="tab" data-bs-target="#hotel${hotel.getHotelId()}">${hotel.getName()}</button>
            </li>
          </c:forEach>

        </ul>

        <div class="tab-content mt-3" id="hotelTabContent">
          <div class="tab-pane fade show active" id="hotel1">
            <div class="row">
              <div class="col-lg-4 col-md-6 mb-4">
                <div class="card">
                  <div class="card-body">
                    <h5 class="card-title">Total Employees Present</h5>
                    <div class="progress">
                      <div class="progress-bar bg-success" role="progressbar" style="width: 85%" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100">85%</div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4 col-md-6 mb-4">
                <div class="card">
                  <div class="card-body">
                    <h5 class="card-title">Late Arrivals</h5>
                    <div class="progress">
                      <div class="progress-bar bg-warning" role="progressbar" style="width: 10%" aria-valuenow="10" aria-valuemin="0" aria-valuemax="100">10%</div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-lg-4 col-md-6 mb-4">
                <div class="card">
                  <div class="card-body">
                    <h5 class="card-title">Absent Employees</h5>
                    <div class="progress">
                      <div class="progress-bar bg-danger" role="progressbar" style="width: 5%" aria-valuenow="5" aria-valuemin="0" aria-valuemax="100">5%</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="row mb-4">
              <div class="col-12">
                <div class="card">
                  <div class="card-body">
                    <h5 class="card-title">Attendance Trend</h5>
                    <canvas id="attendanceChart" height="100"></canvas>
                  </div>
                </div>
              </div>
            </div>

            <div class="row mb-3">
              <div class="col-md-6">
                <select class="form-select" aria-label="Sort by">
                  <option selected>Sort by...</option>
                  <option value="1">Employee ID</option>
                  <option value="2">Employee Name</option>
                  <option value="3">Attendance Status</option>
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
                      <th>Status</th>
                      <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                      <td>EMP001</td>
                      <td>John Doe</td>
                      <td>09:00 AM</td>
                      <td>05:00 PM</td>
                      <td><span class="badge bg-success">Present</span></td>
                      <td>
                        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#detailsModal">
                          <i class="bi bi-eye"></i> View
                        </button>
                      </td>
                    </tr>
                    <tr>
                      <td>EMP002</td>
                      <td>Jane Smith</td>
                      <td>09:30 AM</td>
                      <td>05:30 PM</td>
                      <td><span class="badge bg-warning">Late</span></td>
                      <td>
                        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#detailsModal">
                          <i class="bi bi-eye"></i> View
                        </button>
                      </td>
                    </tr>
                    </tbody>
                  </table>
                </div>

                <nav aria-label="Page navigation">
                  <ul class="pagination justify-content-center">
                    <li class="page-item disabled">
                      <a class="page-link" href="#" tabindex="-1">Previous</a>
                    </li>
                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                      <a class="page-link" href="#">Next</a>
                    </li>
                  </ul>
                </nav>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Details Modal -->
<div class="modal fade" id="detailsModal" tabindex="-1" aria-labelledby="detailsModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="detailsModalLabel">Employee Attendance Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-md-6">
            <p><strong>Employee ID:</strong> EMP001</p>
            <p><strong>Employee Name:</strong> John Doe</p>
            <p><strong>Department:</strong> Housekeeping</p>
          </div>
          <div class="col-md-6">
            <p><strong>Current Status:</strong> <span class="badge bg-success">Present</span></p>
            <p><strong>Clock In:</strong> 09:00 AM</p>
            <p><strong>Clock Out:</strong> 05:00 PM</p>
          </div>
        </div>
        <hr>
        <h6>Attendance History</h6>
        <div class="table-responsive">
          <table class="table table-sm">
            <thead>
            <tr>
              <th>Date</th>
              <th>Clock In</th>
              <th>Clock Out</th>
              <th>Status</th>
            </tr>
            </thead>
            <tbody>
            <tr>
              <td>2024-01-20</td>
              <td>09:00 AM</td>
              <td>05:00 PM</td>
              <td><span class="badge bg-success">Present</span></td>
            </tr>
            <tr>
              <td>2024-01-19</td>
              <td>09:15 AM</td>
              <td>05:00 PM</td>
              <td><span class="badge bg-warning">Late</span></td>
            </tr>
            </tbody>
          </table>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</body>
</html>