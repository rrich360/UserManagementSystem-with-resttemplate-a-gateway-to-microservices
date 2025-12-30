<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header class="app-header">
    <div class="header-container">
        <div class="header-left">
            <h1>User Management System</h1>
        </div>
        <div class="header-right">
            <nav>
                <a href="${pageContext.request.contextPath}/users" class="nav-link">
                    <span class="icon">👥</span> User Management
                </a>
                <a href="${pageContext.request.contextPath}/login" class="nav-link logout">
                    <span class="icon">🚪</span> Logout
                </a>
            </nav>
        </div>
    </div>
</header>