<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html ng-app="userApp">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - User Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
</head>
<body>
    <div class="login-container" ng-controller="LoginController">
        <div class="login-box">
            <h1>User Management System</h1>
            <h2>Login</h2>

            <form ng-submit="login()" class="login-form">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text"
                           id="username"
                           ng-model="credentials.username"
                           placeholder="Enter username"
                           required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password"
                           id="password"
                           ng-model="credentials.password"
                           placeholder="Enter password"
                           required>
                </div>

                <div class="error-message" ng-show="errorMessage">
                    {{ errorMessage }}
                </div>

                <button type="submit" class="btn btn-primary">Login</button>
            </form>


        </div>
    </div>

    <script src="${pageContext.request.contextPath}/static/js/app.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/controllers/loginController.js"></script>
</body>
</html>