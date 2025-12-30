app.service('UserService', ['$http', function($http) {

    var baseUrl = '/api/users';

    // Fetch all users
    this.getAllUsers = function() {
        return $http.get(baseUrl);
    };

    // Get user by ID
    this.getUserById = function(id) {
        return $http.get(baseUrl + '/' + id);
    };

    // Create new user
    this.createUser = function(user) {
        return $http.post(baseUrl, user);
    };

    // Update existing user
    this.updateUser = function(id, user) {
        return $http.put(baseUrl + '/' + id, user);
    };

    // Delete user
    this.deleteUser = function(id) {
        return $http.delete(baseUrl + '/' + id);
    };
}]);