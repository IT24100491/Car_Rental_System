<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="bookingUtil" class="com.vehicle_rental_management_system.utils.BookingUtil" />
<jsp:useBean id="vehicleUtil" class="com.vehicle_rental_management_system.utils.VehicleUtil" />
<jsp:useBean id="customerUtil" class="com.vehicle_rental_management_system.utils.CustomerUtil" />

<c:set var="bookings" value="${bookingUtil.readBookings()}" />
<c:set var="vehicles" value="${vehicleUtil.readVehicles()}" />
<c:set var="customers" value="${customerUtil.readCustomers()}" />
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Rental Management - Vehicle Rental Management System</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
  <style>
    .status-active { color: green; font-weight: bold; }
    .status-completed { color: blue; }
    .status-cancelled { color: red; }
    .status-overdue { color: orange; font-weight: bold; }
  </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Vehicle Rental System</a>
    <div class="navbar-collapse">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link" href="dashboard.jsp">Dashboard</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="customerManagement.jsp">Customer Management</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="vehicleManagement.jsp">Vehicle Management</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="index.jsp">Rental Management</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="paymentManagement.jsp">Payment Management</a>
        </li>
      </ul>
      <span class="navbar-text me-3">Welcome, ${user.username} (${user.role})</span>
      <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light">Logout</a>
    </div>
  </div>
</nav>

<div class="container mt-4">
  <h2>Rental Management</h2>

  <!-- Success/Error Messages -->
  <c:if test="${not empty param.message}">
    <div class="alert alert-success">${param.message}</div>
  </c:if>
  <c:if test="${not empty param.error}">
    <div class="alert alert-danger">${param.error}</div>
  </c:if>

  <!-- Add Rental Button -->
  <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addRentalModal">
    <i class="bi bi-plus-circle"></i> Create New Rental
  </button>

  <!-- Search Bar -->
  <div class="d-flex justify-content-between mb-3">
    <div class="col-md-6">
      <div class="input-group">
        <input type="text" id="searchInput" class="form-control" placeholder="Search by rental ID, vehicle or customer...">
        <button class="btn btn-outline-secondary" type="button" id="searchButton">
          <i class="bi bi-search"></i> Search
        </button>
      </div>
    </div>
  </div>

  <!-- Rentals Table -->
  <table class="table table-striped">
    <thead>
    <tr>
      <th>Rental ID</th>
      <th>Vehicle</th>
      <th>Customer</th>
      <th>Pickup Date</th>
      <th>Return Date</th>
      <th>Status</th>
      <th>Total Cost</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="booking" items="${bookings}">
      <tr>
        <td>${booking.bookingId}</td>
        <td>
          <c:set var="vehicle" value="${vehicleUtil.findVehicleById(booking.vehicleId)}" />
            ${vehicle.make} ${vehicle.model} (${vehicle.licensePlate})
        </td>
        <td>
          <c:set var="customer" value="${customerUtil.findCustomerById(booking.customerId)}" />
            ${customer.name} (${customer.driverLicense})
        </td>
        <td>${booking.startTime}</td>
        <td>${booking.endTime}</td>
        <td class="status-${booking.status.toLowerCase()}">
            ${booking.status}
          <c:if test="${booking.overdue}">
            <span class="status-overdue">(Overdue)</span>
          </c:if>
        </td>
        <td>$${booking.totalCost}</td>
        <td>
          <button class="btn btn-sm btn-warning"
                  onclick="openEditModal('${booking.bookingId}', '${booking.vehicleId}',
                          '${booking.customerId}', '${booking.startTime}',
                          '${booking.endTime}', '${booking.status}')">
            <i class="bi bi-pencil"></i> Edit
          </button>
          <c:if test="${booking.status eq 'active'}">
            <a href="${pageContext.request.contextPath}/process-return?bookingId=${booking.bookingId}"
               class="btn btn-sm btn-success"
               onclick="return confirm('Process vehicle return for this rental?')">
              <i class="bi bi-check-circle"></i> Return
            </a>
            <a href="${pageContext.request.contextPath}/cancel-rental?bookingId=${booking.bookingId}"
               class="btn btn-sm btn-danger"
               onclick="return confirm('Are you sure you want to cancel this rental?')">
              <i class="bi bi-x-circle"></i> Cancel
            </a>
          </c:if>
          <a href="${pageContext.request.contextPath}/rental-details?bookingId=${booking.bookingId}"
             class="btn btn-sm btn-info">
            <i class="bi bi-eye"></i> View
          </a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</div>

<!-- Add Rental Modal -->
<div class="modal fade" id="addRentalModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Create New Rental</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form action="${pageContext.request.contextPath}/add-rental" method="post">
        <div class="modal-body">
          <div class="row">
            <div class="col-md-6">
              <div class="mb-3">
                <label class="form-label">Rental ID</label>
                <input type="text" class="form-control" name="bookingId" required>
              </div>
              <div class="mb-3">
                <label class="form-label">Customer</label>
                <select class="form-select" name="customerId" required>
                  <c:forEach var="customer" items="${customers}">
                    <option value="${customer.customerId}">
                        ${customer.name} (DL: ${customer.driverLicense})
                    </option>
                  </c:forEach>
                </select>
              </div>
              <div class="mb-3">
                <label class="form-label">Pickup Date & Time</label>
                <input type="datetime-local" class="form-control" name="startTime" required>
              </div>
            </div>
            <div class="col-md-6">
              <div class="mb-3">
                <label class="form-label">Vehicle</label>
                <select class="form-select" name="vehicleId" required>
                  <c:forEach var="vehicle" items="${vehicles}">
                    <c:if test="${vehicle.status eq 'available'}">
                      <option value="${vehicle.vehicleId}">
                          ${vehicle.make} ${vehicle.model} (${vehicle.vehicleType}) - $${vehicle.dailyRate}/day
                      </option>
                    </c:if>
                  </c:forEach>
                </select>
              </div>
              <div class="mb-3">
                <label class="form-label">Return Date & Time</label>
                <input type="datetime-local" class="form-control" name="endTime" required>
              </div>
              <div class="mb-3">
                <label class="form-label">Additional Options</label>
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" name="insurance" id="insurance">
                  <label class="form-check-label" for="insurance">
                    Insurance ($10/day)
                  </label>
                </div>
                <div class="form-check">
                  <input class="form-check-input" type="checkbox" name="gps" id="gps">
                  <label class="form-check-label" for="gps">
                    GPS Navigation ($5/day)
                  </label>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          <button type="submit" class="btn btn-primary">Create Rental</button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Edit Rental Modal -->
<div class="modal fade" id="editRentalModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Edit Rental</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <form id="editForm" action="${pageContext.request.contextPath}/update-rental" method="post">
        <div class="modal-body">
          <input type="hidden" id="editBookingId" name="bookingId">
          <div class="mb-3">
            <label class="form-label">Vehicle</label>
            <select class="form-select" id="editVehicleId" name="vehicleId" required>
              <c:forEach var="vehicle" items="${vehicles}">
                <option value="${vehicle.vehicleId}">
                    ${vehicle.make} ${vehicle.model} (${vehicle.licensePlate})
                </option>
              </c:forEach>
            </select>
          </div>
          <div class="mb-3">
            <label class="form-label">Customer</label>
            <select class="form-select" id="editCustomerId" name="customerId" required>
              <c:forEach var="customer" items="${customers}">
                <option value="${customer.customerId}">
                    ${customer.name} (${customer.driverLicense})
                </option>
              </c:forEach>
            </select>
          </div>
          <div class="mb-3">
            <label class="form-label">Pickup Date</label>
            <input type="datetime-local" class="form-control" id="editStartTime" name="startTime" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Return Date</label>
            <input type="datetime-local" class="form-control" id="editEndTime" name="endTime" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Status</label>
            <select class="form-select" id="editStatus" name="status" required>
              <option value="active">Active</option>
              <option value="completed">Completed</option>
              <option value="cancelled">Cancelled</option>
            </select>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          <button type="submit" class="btn btn-primary">Save Changes</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  function openEditModal(bookingId, vehicleId, customerId, startTime, endTime, status) {
    // Format the datetime for the input fields
    const formatForInput = (datetimeStr) => {
      return datetimeStr.replace(' ', 'T').substring(0, 16);
    };

    document.getElementById('editBookingId').value = bookingId;
    document.getElementById('editVehicleId').value = vehicleId;
    document.getElementById('editCustomerId').value = customerId;
    document.getElementById('editStartTime').value = formatForInput(startTime);
    document.getElementById('editEndTime').value = formatForInput(endTime);
    document.getElementById('editStatus').value = status.toLowerCase();

    var editModal = new bootstrap.Modal(document.getElementById('editRentalModal'));
    editModal.show();
  }

  document.getElementById('editForm').addEventListener('submit', function(e) {
    if (!confirm('Are you sure you want to update this rental?')) {
      e.preventDefault();
    }
  });

  // Search functionality
  document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('searchInput');
    const searchButton = document.getElementById('searchButton');
    const rentalRows = document.querySelectorAll('tbody tr');

    function filterRentals() {
      const searchTerm = searchInput.value.toLowerCase();

      rentalRows.forEach(row => {
        const rentalId = row.cells[0].textContent.toLowerCase();
        const vehicle = row.cells[1].textContent.toLowerCase();
        const customer = row.cells[2].textContent.toLowerCase();

        if (rentalId.includes(searchTerm) ||
                vehicle.includes(searchTerm) ||
                customer.includes(searchTerm)) {
          row.style.display = '';
        } else {
          row.style.display = 'none';
        }
      });
    }

    searchInput.addEventListener('input', filterRentals);
    searchButton.addEventListener('click', filterRentals);
    searchInput.addEventListener('search', filterRentals);
  });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
