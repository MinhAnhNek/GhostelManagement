<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
    Document   : RoomManagement
    Created on : Mar 6, 2025, 6:23:18 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Room Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/roomManagement.css">
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
                <button class="btn btn-primary w-100" data-bs-toggle="modal" data-bs-target="#addRoomModal">
                    <i class="bi bi-plus-circle me-2"></i>Add New Room
                </button>
            </div>
        </div>
        <div class="container-fluid py-4">
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <div class="row g-3">
                                <div class="col-md-3">
                                    <select class="form-select" id="filterType" onchange="dynamicFilter()">
                                        <option value="" selected>Filter By</option>
                                        <option value="hotel">Hotel Name</option>
                                        <option value="room">Room Number</option>
                                        <option value="type">Room Type</option>
                                        <option value="price">Price</option>
                                    </select>
                                </div>
                                <div class="col-md-6" id="dynamicFilter">
                                    <select class="form-select hidden" id="hotelFilter">
                                        <option value="">Select Hotel</option>
                                        <c:forEach var="hotel" items="${sessionScope.hotels}">
                                            <option value="${hotel.getName()}">${hotel.getName()}</option>
                                        </c:forEach>
                                    </select>
                                    <select class="form-select hidden" id="typeFilter">
                                        <option value="">Select Room Type</option>
                                        <c:forEach var="roomType" items="${sessionScope.roomTypes}">
                                            <option value="${roomType.getName()}">${roomType.getName()}</option>
                                        </c:forEach>
                                    </select>
                                    <input type="number" class="form-control hidden" id="roomFilter" placeholder="Enter Room Number">
                                    <div class="row hidden" id="priceFilter">
                                        <div class="col-6">
                                            <input type="number" class="form-control" placeholder="Min Price">
                                        </div>
                                        <div class="col-6">
                                            <input type="number" class="form-control" placeholder="Max Price">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" id="roomListing">
            <c:forEach var="room" items="${sessionScope.rooms}">
                <div class="col-md-4 mb-4">
                    <div class="card h-100 shadow-sm">
                        <div class="card-body">
                            <h5 class="card-title">${room.getHotelName()}</h5>
                            <div class="mb-2"><strong>Room:</strong> ${room.getRoomNumber()}</div>
                            <div class="mb-2"><strong>Type:</strong> ${room.getRoomType()}</div>
                            <div class="mb-2"><strong>Price:</strong> $${room.getPrice()}/night</div>
                            <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#viewRoomModal${room.getRoomID()}">View Details</button>
                        </div>
                        <!-- View Room Modal -->
                        <div class="modal fade" id="viewRoomModal${room.getRoomID()}" tabindex="-1">
                            <div class="modal-dialog modal-lg modal-dialog-centered">
                                <div class="modal-content custom-modal">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Room Details</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="mb-3 d-flex justify-content-between">
                                            <label class="form-label col-md-4">Hotel Name</label>
                                            <input type="text" class="form-control" value="${room.getHotelName()}" readonly>
                                        </div>
                                        <div class="mb-3 d-flex justify-content-between">
                                            <label class="form-label col-md-4">Room Number</label>
                                            <input type="text" class="form-control" value="${room.getRoomNumber()}" readonly>
                                        </div>
                                        <div class="mb-3 d-flex justify-content-between">
                                            <label class="form-label col-md-4">Room Type</label>
                                            <select name="roomType" class="form-select" disabled>
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
                                            <input type="text" class="form-control" value="${room.getRoomStatus()}" readonly>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Description</label>
                                            <textarea class="form-control" rows="3" readonly>${room.getDescription()}</textarea>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="button" class="btn btn-primary"><a href="${pageContext.request.contextPath}/UpdateRoom?roomID=${room.getRoomID()}">Update Information</a></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- Add Room Modal -->
    <div class="modal fade" id="addRoomModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Room</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="addRoomForm" action="${pageContext.request.contextPath}/AddRoom" method="post">
                        <div class="mb-3">
                            <label class="form-label">Hotel Name</label>
                            <select name="hotelName" class="form-select" required>
                                <c:forEach var="hotel" items="${sessionScope.hotels}">
                                    <option value="${hotel.getName()}">${hotel.getName()}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Room Type</label>
                            <select name="roomType" class="form-select" required>
                                <option value="">Select Type</option>
                                <c:forEach var="roomType" items="${sessionScope.roomTypes}">
                                    <option value="${roomType.getName()}">${roomType.getName()}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Room Number</label>
                            <input name="roomNumber" type="number" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Price per Night</label>
                            <input name="price" type="number" class="form-control" min="0" step="0.01" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Description</label>
                            <textarea name="description" class="form-control" rows="3"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" form="addRoomForm" class="btn btn-primary">Add Room</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/RoomManagement.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const hotelSelect = document.querySelector("select[name='hotelName']");
        const roomTypeSelect = document.querySelector("select[name='roomType']");
        const priceInput = document.getElementById("priceInput");
        const descriptionTextarea = document.querySelector("textarea");
        const roomSelect = document.getElementById("roomSelect"); // Dropdown to select a room

        // Transforming sessionScope lists into JavaScript objects
        const rooms = [
            <c:forEach var="room" items="${sessionScope.rooms}">
            { roomID: ${room.getRoomID()}, hotelName: "${room.getHotelName()}", roomTypeName: "${room.getRoomType()}" },
            </c:forEach>
        ];

        const hotels = [
            <c:forEach var="hotel" items="${sessionScope.hotels}">
            { hotelID: ${hotel.getHotelId()}, name: "${hotel.getName()}" },
            </c:forEach>
        ];

        const roomTypes = [
            <c:forEach var="roomType" items="${sessionScope.roomTypes}">
            { roomTypeID: ${roomType.getId()}, roomTypeName: "${roomType.getName()}", description: "${roomType.getDescription()}" },
            </c:forEach>
        ];

        const prices = [
            <c:forEach var="price" items="${sessionScope.prices}">
            { hotelID: ${price.getHotelID()}, roomTypeID: ${price.getRoomTypeID()}, price: ${price.getPrice()} },
            </c:forEach>
        ];

        const hotelMapping = {};
        hotels.forEach(hotel => {
            hotelMapping[hotel.name] = hotel.hotelID;
        });

        const roomTypeMapping = {};
        roomTypes.forEach(roomType => {
            roomTypeMapping[roomType.roomTypeName] = roomType.roomTypeID;
        });

        function updatePriceAndDescription() {
            const selectedHotelName = hotelSelect.value;
            const selectedRoomTypeName = roomTypeSelect.value;

            const selectedHotelID = hotelMapping[selectedHotelName] || null;
            const selectedRoomTypeID = roomTypeMapping[selectedRoomTypeName] || null;

            const matchingPrice = prices.find(price =>
                (!selectedHotelID || price.hotelID === selectedHotelID) &&
                (!selectedRoomTypeID || price.roomTypeID === selectedRoomTypeID)
            );

            if (matchingPrice) {
                priceInput.value = matchingPrice.price;
                if (selectedRoomTypeID) {
                    descriptionTextarea.value = roomTypes.find(rt => rt.roomTypeID === selectedRoomTypeID)?.description || "No description available.";
                }
            } else {
                priceInput.value = "";
                descriptionTextarea.value = "";
            }
        }

        function loadRoomDetails() {
            const selectedRoomID = roomSelect.value;
            if (selectedRoomID !== "") {
                const selectedRoom = rooms.find(room => room.roomID === selectedRoomID);
                if (selectedRoom) {
                    hotelSelect.value = selectedRoom.hotelName;
                    roomTypeSelect.value = selectedRoom.roomTypeName;
                    updatePriceAndDescription();
                }
            }
        }

        console.log("Prices:", prices);
        console.log("Hotels Mapping:", hotelMapping);
        console.log("Room Types Mapping:", roomTypeMapping);
        roomSelect.addEventListener("change", loadRoomDetails);
        hotelSelect.addEventListener("change", updatePriceAndDescription);
        roomTypeSelect.addEventListener("change", updatePriceAndDescription);

        // Initialize the first room if available
        if (rooms.length > 0) {
            roomSelect.value = rooms[0].roomID;
            loadRoomDetails();
        }
    });






</script>
</body>
</html>
