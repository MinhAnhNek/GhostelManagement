<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Hotel Employee</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
</head>
<body>
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-12 col-lg-10">
                <div class="card shadow-lg border-0">
                    <div class="card-header bg-transparent border-0 pt-4">
                        <div class="d-flex align-items-center">
                            <a href="#" class="btn btn-outline-primary me-3">
                                <i class="bi bi-arrow-left"></i> Back
                            </a>
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
                                        <c:forEach var="status" items="${sessionScope.statuses}">
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
    <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <div class="toast align-items-center text-bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">Employee added successfully!</div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
