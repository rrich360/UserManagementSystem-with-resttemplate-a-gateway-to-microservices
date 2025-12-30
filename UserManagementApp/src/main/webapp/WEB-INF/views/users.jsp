<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="userApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
</head>
<body ng-controller="UserController">

    <%@ include file="header.jsp" %>

    <div class="main-container">
        <div class="content-wrapper">

            <!-- User Form Section -->
            <div class="card">
                <h2>{{ isEditing ? 'Edit User' : 'Add New User' }}</h2>

                <form ng-submit="saveUser()" class="user-form">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="username">Username *</label>
                            <input type="text"
                                   id="username"
                                   ng-model="currentUser.username"
                                   placeholder="Enter username"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="email">Email *</label>
                            <input type="email"
                                   id="email"
                                   ng-model="currentUser.email"
                                   placeholder="Enter email"
                                   required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="firstName">First Name *</label>
                            <input type="text"
                                   id="firstName"
                                   ng-model="currentUser.firstName"
                                   placeholder="Enter first name"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="lastName">Last Name *</label>
                            <input type="text"
                                   id="lastName"
                                   ng-model="currentUser.lastName"
                                   placeholder="Enter last name"
                                   required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="phone">Phone</label>
                            <input type="tel"
                                   id="phone"
                                   ng-model="currentUser.phone"
                                   placeholder="Enter phone number">
                        </div>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            {{ isEditing ? 'Update User' : 'Add User' }}
                        </button>
                        <button type="button"
                                class="btn btn-secondary"
                                ng-click="cancelEdit()"
                                ng-show="isEditing">
                            Cancel
                        </button>
                    </div>
                </form>
            </div>

            <!-- Users List Section -->
            <div class="card">
                <div class="card-header">
                    <h2>All Users ({{ users.length }})</h2>
                    <button class="btn btn-primary" ng-click="fetchUsers()">
                        🔄 Refresh
                    </button>
                </div>

                <div class="message success" ng-show="successMessage">
                    {{ successMessage }}
                </div>

                <div class="message error" ng-show="errorMessage">
                    {{ errorMessage }}
                </div>

                <div class="table-container">
                    <table class="user-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>First Name</th>
                                <th>Last Name</th>
                                <th>Phone</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="user in users">
                                <td>{{ user.id }}</td>
                                <td>{{ user.username }}</td>
                                <td>{{ user.email }}</td>
                                <td>{{ user.firstName }}</td>
                                <td>{{ user.lastName }}</td>
                                <td>{{ user.phone || 'N/A' }}</td>
                                <td class="actions">
                                    <button class="btn btn-small btn-info"
                                            ng-click="viewUser(user)">
                                        View
                                    </button>
                                    <button class="btn btn-small btn-warning"
                                            ng-click="editUser(user)">
                                        Edit
                                    </button>
                                    <button class="btn btn-small btn-danger"
                                            ng-click="deleteUser(user.id)">
                                        Delete
                                    </button>
                                </td>
                            </tr>
                            <tr ng-show="users.length === 0">
                                <td colspan="7" class="no-data">No users found. Add a user to get started!</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- User Details Modal -->
    <div class="modal" ng-show="showModal" ng-click="closeModal()">
        <div class="modal-content" ng-click="$event.stopPropagation()">
            <div class="modal-header">
                <h2>User Details</h2>
                <button class="close-btn" ng-click="closeModal()">×</button>
            </div>
            <div class="modal-body">
                <div class="detail-row">
                    <strong>ID:</strong> {{ selectedUser.id }}
                </div>
                <div class="detail-row">
                    <strong>Username:</strong> {{ selectedUser.username }}
                </div>
                <div class="detail-row">
                    <strong>Email:</strong> {{ selectedUser.email }}
                </div>
                <div class="detail-row">
                    <strong>First Name:</strong> {{ selectedUser.firstName }}
                </div>
                <div class="detail-row">
                    <strong>Last Name:</strong> {{ selectedUser.lastName }}
                </div>
                <div class="detail-row">
                    <strong>Phone:</strong> {{ selectedUser.phone || 'N/A' }}
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" ng-click="closeModal()">Close</button>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/static/js/app.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/services/userService.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/controllers/userController.js"></script>
</body>
</html>