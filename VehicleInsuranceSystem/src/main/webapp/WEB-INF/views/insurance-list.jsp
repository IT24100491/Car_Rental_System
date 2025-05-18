<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
    body {
        background-color: #f4f6f9;
        font-family: 'Segoe UI', sans-serif;
    }
    .card {
        border: none;
        border-radius: 1rem;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        margin-top: 30px;
    }
    .card-header {
        background: #1e88e5;
        color: white;
        border-radius: 1rem 1rem 0 0;
        padding: 1.25rem 1.5rem;
    }
    .table th, .table td {
        vertical-align: middle;
    }
    .btn {
        border-radius: 0.4rem;
    }
    .filters input {
        border-radius: 0.5rem;
    }
    .table thead {
        background-color: #f1f3f5;
    }
</style>

<div class="container">
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <h4 class="mb-0">Insurance Policies</h4>
            <a href="${pageContext.request.contextPath}/insurance/new" class="btn btn-light text-primary fw-semibold shadow-sm">
                <i class="fa fa-plus me-1"></i> Add Insurance
            </a>
        </div>
        <div class="card-body">
            <!-- Filters -->
            <div class="row g-2 filters mb-4">
                <div class="col-md-4">
                    <input type="text" id="vehicleFilter" class="form-control" placeholder="Search by Vehicle ID">
                </div>
                <div class="col-md-4">
                    <input type="text" id="providerFilter" class="form-control" placeholder="Search by Provider">
                </div>
                <div class="col-md-4">
                    <input type="date" id="expiryFilter" class="form-control" placeholder="Filter by Expiry Date">
                </div>
            </div>

            <!-- Table -->
            <div class="table-responsive">
                <table class="table align-middle" id="insuranceTable">
                    <thead class="table-light">
                    <tr>
                        <th>Vehicle ID</th>
                        <th>Provider</th>
                        <th>Policy No.</th>
                        <th>Coverage</th>
                        <th>Start</th>
                        <th>Expiry</th>
                        <th>Premium</th>
                        <th class="text-center">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${insurances}" var="insurance">
                        <tr>
                            <td>${insurance.vehicleId}</td>
                            <td>${insurance.insuranceProvider}</td>
                            <td>${insurance.policyNumber}</td>
                            <td class="text-capitalize">${insurance.coverageType}</td>
                            <td><fmt:formatDate value="${insurance.startDate}" pattern="dd/MM/yyyy"/></td>
                            <td><fmt:formatDate value="${insurance.expiryDate}" pattern="dd/MM/yyyy"/></td>
                            <td>Rs${insurance.premiumAmount}</td>
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/insurance/edit/${insurance.id}" class="btn btn-sm btn-outline-primary me-1">
                                    <i class="fa fa-edit"></i>
                                </a>
                                <button onclick="deleteInsurance(${insurance.id})" class="btn btn-sm btn-outline-danger me-1">
                                    <i class="fa fa-trash"></i>
                                </button>
                                <c:if test="${not empty insurance.documentPath}">
                                    <a href="${pageContext.request.contextPath}/uploads/${insurance.documentPath}" target="_blank"
                                       class="btn btn-sm btn-outline-secondary">
                                        <i class="fa fa-file"></i>
                                    </a>
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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const table = document.getElementById('insuranceTable');
        const vehicleFilter = document.getElementById('vehicleFilter');
        const providerFilter = document.getElementById('providerFilter');
        const expiryFilter = document.getElementById('expiryFilter');

        function filterTable() {
            const rows = table.getElementsByTagName('tr');
            const vehicleVal = vehicleFilter.value.toLowerCase();
            const providerVal = providerFilter.value.toLowerCase();
            const expiryVal = expiryFilter.value;

            for (let i = 1; i < rows.length; i++) {
                const cells = rows[i].getElementsByTagName('td');
                const vehicle = cells[0].textContent.toLowerCase();
                const provider = cells[1].textContent.toLowerCase();
                const expiry = cells[5].textContent;

                const matchVehicle = vehicle.includes(vehicleVal);
                const matchProvider = provider.includes(providerVal);
                const matchExpiry = !expiryVal || expiry.includes(expiryVal);

                rows[i].style.display = (matchVehicle && matchProvider && matchExpiry) ? '' : 'none';
            }
        }

        vehicleFilter.addEventListener('input', filterTable);
        providerFilter.addEventListener('input', filterTable);
        expiryFilter.addEventListener('input', filterTable);
    });

    function deleteInsurance(id) {
        if (confirm('Are you sure you want to delete this insurance record?')) {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/insurance';

            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'delete';

            const idInput = document.createElement('input');
            idInput.type = 'hidden';
            idInput.name = 'id';
            idInput.value = id;

            form.appendChild(actionInput);
            form.appendChild(idInput);
            document.body.appendChild(form);
            form.submit();
        }
    }
</script>
