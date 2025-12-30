// Initialize AngularJS application
var app = angular.module('userApp', []);

// Configure the app
app.config(['$httpProvider', function($httpProvider) {
    // Set default headers for HTTP requests
    $httpProvider.defaults.headers.common['Content-Type'] = 'application/json';
    $httpProvider.defaults.headers.common['Accept'] = 'application/json';
}]);