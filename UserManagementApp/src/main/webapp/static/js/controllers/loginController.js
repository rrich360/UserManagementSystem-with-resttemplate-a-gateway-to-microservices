app.controller('LoginController', ['$scope', '$window', function($scope, $window) {

    // Initialize credentials object
    $scope.credentials = {
        username: '',
        password: ''
    };

    $scope.errorMessage = '';

    // Login function
    $scope.login = function() {
        // Clear previous error
        $scope.errorMessage = '';

        // Simple validation
        if (!$scope.credentials.username || !$scope.credentials.password) {
            $scope.errorMessage = 'Please enter both username and password';
            return;
        }

        // Demo authentication (hardcoded for demo purposes)
        if ($scope.credentials.username === 'admin' && $scope.credentials.password === 'admin123') {
            // Store user session (in real app, use proper authentication)
            sessionStorage.setItem('loggedIn', 'true');
            sessionStorage.setItem('username', $scope.credentials.username);

            // Redirect to users page
            $window.location.href = '/users';
        } else {
            $scope.errorMessage = 'Invalid username or password';
        }
    };

    // Check if already logged in
    if (sessionStorage.getItem('loggedIn') === 'true') {
        $window.location.href = '/users';
    }
}]);