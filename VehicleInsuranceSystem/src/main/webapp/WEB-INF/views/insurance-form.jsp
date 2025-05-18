<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Insurance Form</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap" rel="stylesheet">

    <!-- Custom Minimal CSS -->
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f4f6f9;
        }
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.05);
            margin-top: 50px;
        }
        .card-header {
            background-color: #0d6efd;
            color: #fff;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
            padding: 20px 25px;
        }
        .card-header h4 {
            margin: 0;
            font-weight: 600;
        }
        .card-body {
            padding: 25px;
        }
        .form-label {
            font-weight: 500;
            color: #333;
        }
        .btn-primary {
            background-color: #0d6efd;
            border-color: #0d6efd;
        }
        .btn-primary:hover {
            background-color: #0b5ed7;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8 col-md-10">
            <div class="card">
                <div class="card-header">
                    <h4>${empty insurance ? 'Add New Insurance' : 'Edit Insurance'}</h4>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/insurance" method="POST"
                          enctype="multipart/form-data" onsubmit="return validateForm()">

                        <input type="hidden" name="action" value="${empty insurance ? 'create' : 'update'}">
                        <c:if test="${not empty insurance}">
                            <input type="hidden" name="id" value="${insurance.id}">
                        </c:if>

                        <div class="mb-3">
                            <label for="vehicleId" class="form-label">Vehicle ID *</label>
                            <input type="text" class="form-control" id="vehicleId" name="vehicleId"
                                   value="${insurance.vehicleId}" required>
                        </div>

                        <div class="mb-3">
                            <label for="insuranceProvider" class="form-label">Insurance Provider *</label>
                            <input type="text" class="form-control" id="insuranceProvider" name="insuranceProvider"
                                   value="${insurance.insuranceProvider}" required>
                        </div>

                        <div class="mb-3">
                            <label for="policyNumber" class="form-label">Policy Number *</label>
                            <input type="text" class="form-control" id="policyNumber" name="policyNumber"
                                   value="${insurance.policyNumber}" required>
                        </div>

                        <div class="mb-3">
                            <label for="coverageType" class="form-label">Coverage Type *</label>
                            <select class="form-select" id="coverageType" name="coverageType" required>
                                <option value="">Select Coverage Type</option>
                                <option value="full" ${insurance.coverageType == 'full' ? 'selected' : ''}>Full Coverage</option>
                                <option value="third-party" ${insurance.coverageType == 'third-party' ? 'selected' : ''}>Third Party</option>
                                <option value="basic" ${insurance.coverageType == 'basic' ? 'selected' : ''}>Basic</option>
                            </select>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="startDate" class="form-label">Start Date *</label>
                                    <input type="date" class="form-control" id="startDate" name="startDate"
                                           value="<fmt:formatDate value='${insurance.startDate}' pattern='yyyy-MM-dd'/>" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="expiryDate" class="form-label">Expiry Date *</label>
                                    <input type="date" class="form-control" id="expiryDate" name="expiryDate"
                                           value="<fmt:formatDate value='${insurance.expiryDate}' pattern='yyyy-MM-dd'/>" required>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="premiumAmount" class="form-label">Premium Amount *</label>
                            <div class="input-group">
                                <span class="input-group-text">Rs</span>
                                <input type="number" step="0" class="form-control" id="premiumAmount"
                                       name="premiumAmount" value="${insurance.premiumAmount}" required>
                            </div>
                        </div>


                        <div class="d-flex justify-content-end gap-2">
                            <a href="${pageContext.request.contextPath}/insurance" class="btn btn-secondary">Cancel</a>
                            <button type="submit" class="btn btn-primary">
                                ${empty insurance ? 'Create Insurance' : 'Update Insurance'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function validateForm() {
        const startDate = new Date(document.getElementById('startDate').value);
        const expiryDate = new Date(document.getElementById('expiryDate').value);
        const premiumAmount = parseFloat(document.getElementById('premiumAmount').value);

        if (expiryDate <= startDate) {
            alert('Expiry date must be after start date');
            return false;
        }

        if (premiumAmount <= 0) {
            alert('Premium amount must be greater than 0');
            return false;
        }

    }
</script>

</body>
</html>
