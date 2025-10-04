<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JSP Demo - Spring Security</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .jsp-header { background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; }
        .demo-card { transition: transform 0.3s; }
        .demo-card:hover { transform: translateY(-3px); }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="/">Spring Security Demo</a>
            <div class="navbar-nav">
                <a class="nav-link" href="/dashboard">Dashboard</a>
                <sec:authorize access="isAuthenticated()">
                    <span class="navbar-text me-3">
                        Welcome, <sec:authentication property="name"/>!
                    </span>
                    <form action="${pageContext.request.contextPath}/logout" method="post" class="d-inline">
                        <button type="submit" class="btn btn-outline-light btn-sm">Logout</button>
                        <sec:csrfInput/>
                    </form>
                </sec:authorize>
                <sec:authorize access="!isAuthenticated()">
                    <a class="nav-link" href="/login">Login</a>
                </sec:authorize>
            </div>
        </div>
    </nav>

    <!-- Header -->
    <div class="jsp-header py-4">
        <div class="container text-center">
            <h1 class="display-4 mb-3">
                <i class="fas fa-code me-3"></i>JSP/JSTL Demo
            </h1>
            <p class="lead">Spring Security integration with JSP and JSTL</p>
        </div>
    </div>

    <div class="container my-5">
        <!-- Authentication Status -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-shield-alt me-2"></i>Authentication Status
                        </h5>
                    </div>
                    <div class="card-body">
                        <sec:authorize access="isAuthenticated()">
                            <div class="alert alert-success">
                                <i class="fas fa-check-circle me-2"></i>
                                <strong>Authenticated:</strong> You are logged in as <strong><sec:authentication property="name"/></strong>
                            </div>
                            
                            <h6>Your Roles:</h6>
                            <sec:authorize access="hasRole('ADMIN')">
                                <span class="badge bg-danger me-1">ADMIN</span>
                            </sec:authorize>
                            <sec:authorize access="hasRole('MANAGER')">
                                <span class="badge bg-warning me-1">MANAGER</span>
                            </sec:authorize>
                            <sec:authorize access="hasRole('USER')">
                                <span class="badge bg-info me-1">USER</span>
                            </sec:authorize>
                        </sec:authorize>
                        
                        <sec:authorize access="!isAuthenticated()">
                            <div class="alert alert-warning">
                                <i class="fas fa-exclamation-triangle me-2"></i>
                                <strong>Not Authenticated:</strong> Please <a href="/login">login</a> to access protected content.
                            </div>
                        </sec:authorize>
                    </div>
                </div>
            </div>
        </div>

        <!-- Role-based Content Display -->
        <div class="row">
            <div class="col-12 mb-4">
                <h3 class="text-center">Role-based Content Access (JSP/JSTL)</h3>
                <p class="text-center text-muted">Content below is conditionally displayed based on your authentication and roles</p>
            </div>
        </div>

        <div class="row">
            <!-- Public Content -->
            <div class="col-lg-4 mb-4">
                <div class="card demo-card h-100 border-primary">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-globe me-2"></i>Public Content
                        </h5>
                    </div>
                    <div class="card-body">
                        <p class="card-text">This content is visible to everyone, regardless of authentication status.</p>
                        <p><strong>Security Tag:</strong> <code>&lt;sec:authorize access="permitAll"&gt;</code></p>
                        <sec:authorize access="permitAll">
                            <div class="alert alert-info">
                                ✅ This message is always visible!
                            </div>
                        </sec:authorize>
                    </div>
                </div>
            </div>

            <!-- User Content -->
            <div class="col-lg-4 mb-4">
                <div class="card demo-card h-100 border-info">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-users me-2"></i>User Content
                        </h5>
                    </div>
                    <div class="card-body">
                        <p class="card-text">This content is visible to authenticated users with USER, MANAGER, or ADMIN roles.</p>
                        <p><strong>Security Tag:</strong> <code>&lt;sec:authorize access="hasAnyRole('USER','MANAGER','ADMIN')"&gt;</code></p>
                        <sec:authorize access="hasAnyRole('USER','MANAGER','ADMIN')">
                            <div class="alert alert-success">
                                ✅ You have user-level access!
                            </div>
                            <a href="/user" class="btn btn-info">User Area</a>
                        </sec:authorize>
                        <sec:authorize access="!hasAnyRole('USER','MANAGER','ADMIN')">
                            <div class="alert alert-warning">
                                ❌ User access required
                            </div>
                        </sec:authorize>
                    </div>
                </div>
            </div>

            <!-- Manager Content -->
            <div class="col-lg-4 mb-4">
                <div class="card demo-card h-100 border-warning">
                    <div class="card-header bg-warning text-dark">
                        <h5 class="mb-0">
                            <i class="fas fa-user-tie me-2"></i>Manager Content
                        </h5>
                    </div>
                    <div class="card-body">
                        <p class="card-text">This content is visible to users with MANAGER or ADMIN roles only.</p>
                        <p><strong>Security Tag:</strong> <code>&lt;sec:authorize access="hasAnyRole('MANAGER','ADMIN')"&gt;</code></p>
                        <sec:authorize access="hasAnyRole('MANAGER','ADMIN')">
                            <div class="alert alert-success">
                                ✅ You have manager-level access!
                            </div>
                            <a href="/manager" class="btn btn-warning">Manager Area</a>
                        </sec:authorize>
                        <sec:authorize access="!hasAnyRole('MANAGER','ADMIN')">
                            <div class="alert alert-warning">
                                ❌ Manager access required
                            </div>
                        </sec:authorize>
                    </div>
                </div>
            </div>
        </div>

        <!-- Admin Only Content -->
        <div class="row">
            <div class="col-12 mb-4">
                <div class="card demo-card border-danger">
                    <div class="card-header bg-danger text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-user-shield me-2"></i>Admin Only Content
                        </h5>
                    </div>
                    <div class="card-body">
                        <p>This content is visible only to users with ADMIN role.</p>
                        <p><strong>Security Tag:</strong> <code>&lt;sec:authorize access="hasRole('ADMIN')"&gt;</code></p>
                        
                        <sec:authorize access="hasRole('ADMIN')">
                            <div class="alert alert-success">
                                <i class="fas fa-crown me-2"></i>
                                <strong>Admin Access Confirmed!</strong> You have full administrative privileges.
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <h6>Admin Tools:</h6>
                                    <ul class="list-unstyled">
                                        <li><a href="/admin" class="text-decoration-none">Admin Dashboard</a></li>
                                        <li><a href="/h2-console" class="text-decoration-none" target="_blank">Database Console</a></li>
                                    </ul>
                                </div>
                                <div class="col-md-6">
                                    <h6>System Information:</h6>
                                    <p><strong>Current Admin:</strong> <sec:authentication property="name"/></p>
                                    <p><strong>Session ID:</strong> <%= request.getSession().getId() %></p>
                                </div>
                            </div>
                        </sec:authorize>
                        
                        <sec:authorize access="!hasRole('ADMIN')">
                            <div class="alert alert-danger">
                                <i class="fas fa-ban me-2"></i>
                                <strong>Access Denied:</strong> Administrative privileges required to view this content.
                            </div>
                        </sec:authorize>
                    </div>
                </div>
            </div>
        </div>

        <!-- JSP/JSTL Features Demo -->
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-secondary text-white">
                        <h5 class="mb-0">
                            <i class="fas fa-code me-2"></i>JSP/JSTL Security Features
                        </h5>
                    </div>
                    <div class="card-body">
                        <h6>Security Taglib Features Demonstrated:</h6>
                        <div class="row">
                            <div class="col-md-6">
                                <ul>
                                    <li><code>&lt;sec:authorize access="..."&gt;</code> - Conditional content display</li>
                                    <li><code>&lt;sec:authentication property="name"/&gt;</code> - User information</li>
                                    <li><code>&lt;sec:csrfInput/&gt;</code> - CSRF protection</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <ul>
                                    <li><code>hasRole('ROLE')</code> - Single role check</li>
                                    <li><code>hasAnyRole('ROLE1','ROLE2')</code> - Multiple role check</li>
                                    <li><code>isAuthenticated()</code> - Authentication status</li>
                                </ul>
                            </div>
                        </div>
                        
                        <div class="alert alert-info mt-3">
                            <strong>Note:</strong> This JSP page demonstrates how to integrate Spring Security with 
                            traditional JSP/JSTL applications, providing the same security features as Thymeleaf 
                            but using JSP technology.
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
</body>
</html>