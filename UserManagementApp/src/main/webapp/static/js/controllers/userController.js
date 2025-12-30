app.controller('UserController', ['$scope', '$window', 'UserService', function($scope, $window, UserService) {

    // Check if user is logged in
    if (sessionStorage.getItem('loggedIn') !== 'true') {
        $window.location.href = '/login';
        return;
    }

    // Initialize variables
    $scope.users = [];
    $scope.currentUser = {};
    $scope.isEditing = false;
    $scope.showModal = false;
    $scope.selectedUser = {};
    $scope.successMessage = '';
    $scope.errorMessage = '';

    // Fetch all users
    $scope.fetchUsers = function() {
        UserService.getAllUsers()
            .then(function(response) {
                $scope.users = response.data;
                $scope.clearMessages();
            })
            .catch(function(error) {
                console.error('Error fetching users:', error);
                $scope.showError('Failed to fetch users');
            });
    };

    // Save user (create or update)
    $scope.saveUser = function() {
        if ($scope.isEditing) {
            // Update existing user
            UserService.updateUser($scope.currentUser.id, $scope.currentUser)
                .then(function(response) {
                    $scope.showSuccess('User updated successfully!');
                    $scope.fetchUsers();
                    $scope.resetForm();
                })
                .catch(function(error) {
                    console.error('Error updating user:', error);
                    $scope.showError('Failed to update user');
                });
        } else {
            // Create new user
            UserService.createUser($scope.currentUser)
                .then(function(response) {
                    $scope.showSuccess('User created successfully!');
                    $scope.fetchUsers();
                    $scope.resetForm();
                })
                .catch(function(error) {
                    console.error('Error creating user:', error);
                    $scope.showError('Failed to create user');
                });
        }
    };

    // View user details
    $scope.viewUser = function(user) {
        $scope.selectedUser = angular.copy(user);
        $scope.showModal = true;
    };

    // Edit user
    $scope.editUser = function(user) {
        $scope.currentUser = angular.copy(user);
        $scope.isEditing = true;
        // Scroll to top of page
        window.scrollTo(0, 0);
        $scope.clearMessages();
    };

    // Delete user
    $scope.deleteUser = function(userId) {
        if (confirm('Are you sure you want to delete this user?')) {
            UserService.deleteUser(userId)
                .then(function(response) {
                    $scope.showSuccess('User deleted successfully!');
                    $scope.fetchUsers();
                })
                .catch(function(error) {
                    console.error('Error deleting user:', error);
                    $scope.showError('Failed to delete user');
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

    // Close modal
    $scope.closeModal = function() {
        $scope.showModal = false;
        $scope.selectedUser = {};
    };

    // Show success message
    $scope.showSuccess = function(message) {
        $scope.successMessage = message;
        $scope.errorMessage = '';
        setTimeout(function() {
            $scope.$apply(function() {
                $scope.successMessage = '';
            });
        }, 3000);
    };

    // Show error message
    $scope.showError = function(message) {
        $scope.errorMessage = message;
        $scope.successMessage = '';
        setTimeout(function() {
            $scope.$apply(function() {
                $scope.errorMessage = '';
            });
        }, 3000);
    };

    // Clear messages
    $scope.clearMessages = function() {
        $scope.successMessage = '';
        $scope.errorMessage = '';
    };

    // Initialize - fetch users on page load
    $scope.fetchUsers();
}]);