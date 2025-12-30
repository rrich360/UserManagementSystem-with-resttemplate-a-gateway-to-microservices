<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="providerApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Provider Dashboard</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .header { background: #2c3e50; color: white; padding: 1rem 2rem; }
        .container { max-width: 1200px; margin: 2rem auto; padding: 0 2rem; }
        .card { background: white; padding: 2rem; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 2rem; }
        h1 { margin-bottom: 1rem; }
        h2 { color: #2c3e50; margin-bottom: 1rem; }
        table { width: 100%; border-collapse: collapse; margin-top: 1rem; }
        th, td { padding: 1rem; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #34495e; color: white; }
        .btn { padding: 0.5rem 1rem; border: none; border-radius: 5px; cursor: pointer; margin-right: 0.5rem; }
        .btn-primary { background: #3498db; color: white; }
        .btn-success { background: #27ae60; color: white; }
        .btn-danger { background: #e74c3c; color: white; }
        .btn:hover { opacity: 0.8; }
        input { padding: 0.5rem; border: 1px solid #ddd; border-radius: 5px; width: 100%; margin-bottom: 1rem; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
        .status { padding: 0.5rem 1rem; border-radius: 5px; display: inline-block; }
        .status.online { background: #d4edda; color: #155724; }
        .status.offline { background: #f8d7da; color: #721c24; }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
</head>
<body ng-controller="DashboardController">

    <div class="header">
        <h1>Provider Application Dashboard</h1>
        <p>Consuming User Management Service via RestTemplate</p>
    </div>

    <div class="container">

        <!-- Service Status -->
        <div class="card">
            <h2>Service Status</h2>
            <p><strong>Provider App:</strong> <span class="status online">Running on port 8081</span></p>
            <p><strong>User Management Service:</strong>
                <span class="status" ng-class="serviceOnline ? 'online' : 'offline'">
                    {{ serviceOnline ? 'Connected (port 8080)' : 'Disconnected' }}
                </span>
            </p>
            <button class="btn btn-primary" ng-click="checkHealth()">Check Connection</button>
        </div>

        <!-- User Form -->
        <div class="card">
            <h2>{{ isEditing ? 'Edit User' : 'Add New User' }}</h2>
            <form ng-submit="saveUser()">
                <div class="form-row">
                    <input type="text" ng-model="currentUser.username" placeholder="Username" required>
                    <input type="email" ng-model="currentUser.email" placeholder="Email" required>
                </div>
                <div class="form-row">
                    <input type="text" ng-model="currentUser.firstName" placeholder="First Name" required>
                    <input type="text" ng-model="currentUser.lastName" placeholder="Last Name" required>
                </div>
                <input type="tel" ng-model="currentUser.phone" placeholder="Phone">

                <button type="submit" class="btn btn-success">
                    {{ isEditing ? 'Update User' : 'Create User' }}
                </button>
                <button type="button" class="btn btn-danger" ng-click="cancelEdit()" ng-show="isEditing">
                    Cancel
                </button>
            </form>
        </div>

        <!-- Users List -->
        <div class="card">
            <h2>Users from User Management Service ({{ users.length }})</h2>
            <button class="btn btn-primary" ng-click="fetchUsers()">🔄 Refresh Users</button>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Email</th>
                        <th>Name</th>
                        <th>Phone</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr ng-repeat="user in users">
                        <td>{{ user.id }}</td>
                        <td>{{ user.username }}</td>
                        <td>{{ user.email }}</td>
                        <td>{{ user.firstName }} {{ user.lastName }}</td>
                        <td>{{ user.phone || 'N/A' }}</td>
                        <td>
                            <button class="btn btn-primary" ng-click="editUser(user)">Edit</button>
                            <button class="btn btn-danger" ng-click="deleteUser(user.id)">Delete</button>
                        </td>
                    </tr>
                    <tr ng-show="users.length === 0">
                        <td colspan="6" style="text-align: center;">
                            {{ serviceOnline ? 'No users found' : 'Cannot connect to User Management Service' }}
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        var app = angular.module('providerApp', []);

        app.controller('DashboardController', ['$scope', '$http', function($scope, $http) {
            $scope.users = [];
            $scope.currentUser = {};
            $scope.isEditing = false;
            $scope.serviceOnline = false;

            var baseUrl = '/api/users';

            // Check service health
            $scope.checkHealth = function() {
                $http.get(baseUrl + '/health')
                    .then(function(response) {
                        $scope.serviceOnline = true;
                        alert('Connection successful! ' + response.data);
                    })
                    .catch(function() {
                        $scope.serviceOnline = false;
                        alert('Connecting to User Management Service... Make sure it is running on port 8080.');
                    });
            };

            // Fetch all users
            $scope.fetchUsers = function() {
                $http.get(baseUrl)
                    .then(function(response) {
                        $scope.users = response.data;
                        $scope.serviceOnline = true;
                    })
                    .catch(function(error) {
                        console.error('Error fetching users:', error);
                        $scope.serviceOnline = false;
                        alert('Failed to fetch users. Is User Management Service running?');
                    });
            };

            // Save user (create or update)
            $scope.saveUser = function() {
                if ($scope.isEditing) {
                    // Update
                    $http.put(baseUrl + '/' + $scope.currentUser.id, $scope.currentUser)
                        .then(function() {
                            alert('User updated successfully!');
                            $scope.fetchUsers();
                            $scope.resetForm();
                        })
                        .catch(function(error) {
                            console.error('Error updating user:', error);
                            alert('Failed to update user');
                        });
                } else {
                    // Create
                    $http.post(baseUrl, $scope.currentUser)
                        .then(function() {
                            alert('User created successfully!');
                            $scope.fetchUsers();
                            $scope.resetForm();
                        })
                        .catch(function(error) {
                            console.error('Error creating user:', error);
                            alert('Failed to create user');
                        });
                }
            };

            // Edit user
            $scope.editUser = function(user) {
                $scope.currentUser = angular.copy(user);
                $scope.isEditing = true;
                window.scrollTo(0, 0);
            };

            // Delete user
            $scope.deleteUser = function(id) {
                if (confirm('Are you sure you want to delete this user?')) {
                    $http.delete(baseUrl + '/' + id)
                        .then(function() {
                            alert('User deleted successfully!');
                            $scope.fetchUsers();
                        })
                        .catch(function(error) {
                            console.error('Error deleting user:', error);
                            alert('Failed to delete user');
                        });
                }
            };

            // Cancel edit
            $scope.cancelEdit = function() {
                $scope.resetForm();
            };

            // Reset form
            $scope.resetForm = function() {
                $scope.currentUser = {};
                $scope.isEditing = false;
            };

            // Initialize
            $scope.checkHealth();
            $scope.fetchUsers();
        }]);
    </script>
</body>
</html>