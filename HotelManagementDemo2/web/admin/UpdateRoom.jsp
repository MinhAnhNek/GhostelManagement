<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
    Document   : UpdateRoom
    Created on : Mar 9, 2025, 11:33:42 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Room Information</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <link rel="stylesheet" href="css/roomManagement.css">
    </head>
    <body>
    <c:set var="room" value="${sessionScope.room}"/>

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
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin"><i class="bi bi-people me-2"></i>Employee Management</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/RoomManagement"><i class="bi bi-door-open me-2"></i>Room Management</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><i class="bi bi-calendar-check me-2"></i>Booking Management</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"  style="border-bottom-left-radius: var(--radius); border-bottom-right-radius: var(--radius);"><i class="bi bi-graph-up me-2"></i>Finance Overview</a>
                </li>
            </ul>
        </div>

        <div class="main-content p-4 w-100">

            <div class="mb-4">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h2 class="col-md-10">Room Management</h2>
                    <button class="btn btn-primary w-100">
                        <a href="${pageContext.request.contextPath}/RoomManagement">Back</a>
                    </button>
                </div>
            </div>
            <form action="${pageContext.request.contextPath}/UpdateRoom" method="post">
                <div class="mb-3 d-flex justify-content-between">
                    <label class="form-label col-md-4">Room ID</label>
                    <input name="roomID" type="text" class="form-control" value="${room.getRoomID()}" readonly>
                </div>
                <div class="mb-3 d-flex justify-content-between">
                    <label class="form-label col-md-4">Hotel Name</label>
                    <input name="hotelName" type="text" class="form-control" value="${room.getHotelName()}" readonly>
                </div>
                <div class="mb-3 d-flex justify-content-between">
                    <label class="form-label col-md-4">Room Number</label>
                    <input type="text" class="form-control" value="${room.getRoomNumber()}" readonly>
                </div>
                <div class="mb-3 d-flex justify-content-between">
                    <label class="form-label col-md-4">Room Type</label>
                    <select name="roomType" class="form-select" >
                        <c:forEach var="roomType" items="${sessionScope.roomTypes}">
                            <c:choose>
                                <c:when test="${room.getRoomType() eq (roomType.getName())}">
                                    <option value="${roomType.getName()}" selected="selected">${roomType.getName()}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${roomType.getName()}">${roomType.getName()}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-3 d-flex justify-content-between">
                    <label class="form-label col-md-4">Price per Night</label>
                    <input type="text" class="form-control" id="priceInput" value="${room.getPrice()}" readonly>
                </div>
                <div class="mb-3 d-flex justify-content-between">
                    <label class="form-label col-md-4">Room Status</label>
                    <select name="roomStatus" class="form-select">
                        <c:forEach var="roomStatus" items="${sessionScope.roomStatuses}">
                            <c:choose>
                                <c:when test="${room.getRoomStatus() eq roomStatus.getStatusName()}">
                                    <option value="${room.getRoomStatus()}" selected>${room.getRoomStatus()}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${roomStatus.getStatusName()}">${roomStatus.getStatusName()}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea class="form-control" rows="3" >${room.getDescription()}</textarea>
                </div>
                <div class="mb-3 d-flex justify-content-between">
                    <button type="button" class="btn btn-secondary">
                        <a href="${pageContext.request.contextPath}/UpdateRoom?roomID=${room.getRoomID()}">
                            Refresh
                        </a>
                    </button>
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const contextPath = '${pageContext.request.contextPath}';
        document.addEventListener("DOMContentLoaded", function () {
            const roomTypeSelect = document.querySelector("select[name='roomType']");
            const roomID = document.getElementsByName('roomID')[0].value;

            function redirectToUpdateRoom() {
                const selectedRoomType = encodeURIComponent(roomTypeSelect.value);

                if (selectedRoomType) {
                    window.location.href = contextPath + `/UpdateRoom?roomID=` + roomID + `&roomType=` + selectedRoomType;
                }
            }

            roomTypeSelect.addEventListener("change", redirectToUpdateRoom);
        });

    </script>
    </body>
</html>
