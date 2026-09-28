<%@ page import="java.util.*" %>
<%@ page import="com.mockevaluation.dao.UserDAO" %>
<%@ page import="com.mockevaluation.model.User" %>

<%
User sessionUser =
(User)session.getAttribute("user");

if(sessionUser == null)
{
    response.sendRedirect("../index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>User Management</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/style.css">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

</head>

<body>

<!-- Sidebar -->

<div class="sidebar">

    <div class="logo">
        <i class="bi bi-mortarboard-fill"></i>
        MockEval
    </div>

    <ul class="menu">

        <li><a href="dashboard.jsp"><i class="bi bi-grid"></i>  Dashboard</a></li>

        <li><a href="batch.jsp"><i class="bi bi-collection"></i>  Batch</a></li>

        <li><a href="technology.jsp"><i class="bi bi-cpu"></i>  Technology</a></li>

        <li><a href="participant.jsp"><i class="bi bi-people"></i>  Participants</a></li>
        
        <li><a href="round.jsp"><i class="bi bi-diagram-3"></i> Rounds</a></li>
        
        <li><a href="assignment.jsp"><i class="bi bi-person-check"></i> Assignment</a></li>
 
        <li><a href="report.jsp"><i class="bi bi-bar-chart"></i> Reports</a></li>

        <li><a href="user.jsp" class="active"><i class="bi bi-person-gear"></i>Users</a></li>

    </ul>

</div>

<!-- Main Content -->

<div class="main-content fade-in">

    <!-- Topbar -->

    <div class="topbar">

        <h3>
            <i class="bi bi-person-gear"></i>
            User Management
        </h3>

        <a href="../logout"
           class="btn btn-danger">

            <i class="bi bi-box-arrow-right"></i>
            Logout

        </a>

    </div>

    <!-- Add User Form -->

    <div class="glass-card">

        <h4 class="mb-4">
            <i class="bi bi-person-plus-fill"></i>
            Add New User
        </h4>

        <form action="../UserServlet"
              method="post">

            <div class="mb-3">

                <label class="form-label">
                    Full Name
                </label>

                <input type="text"
                       name="fullName"
                       class="form-control"
                       placeholder="Enter Full Name"
                       required>

            </div>

            <div class="mb-3">

                <label class="form-label">
                    Email Address
                </label>

                <input type="email"
                       name="email"
                       class="form-control"
                       placeholder="Enter Email"
                       required>

            </div>

            <div class="mb-3">

                <label class="form-label">
                    Password
                </label>

                <input type="password"
                       name="password"
                       class="form-control"
                       placeholder="Enter Password"
                       required>

            </div>

            <div class="mb-4">

                <label class="form-label">
                    Role
                </label>

                <select name="role"
                        class="form-select">

                    <option value="EVALUATOR">
                        EVALUATOR
                    </option>

                    <option value="ADMIN">
                        ADMIN
                    </option>

                </select>

            </div>

            <button type="submit"
                    class="btn btn-primary-custom">

                <i class="bi bi-save-fill"></i>
                Save User

            </button>

        </form>

    </div>

    <!-- User Table -->

    <div class="glass-card mt-4">

        <h4 class="mb-3">
            <i class="bi bi-people-fill"></i>
            All Users
        </h4>

        <div class="table-responsive">

            <table class="table table-hover table-bordered align-middle">

                <thead>

                <tr>

                    <th>ID</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Actions</th>
                   

                </tr>

                </thead>

                <tbody>

                <%
                UserDAO dao =
                new UserDAO();

                ArrayList<User> list =
                dao.getAllUsers();

                for(User u : list){
                %>

                <tr>

                    <td><%= u.getUserId() %></td>

                    <td><%= u.getFullName() %></td>

                    <td><%= u.getEmail() %></td>

                    <td>
                    
                    

                        <% if("ADMIN".equals(u.getRole())) { %>

                            <span class="badge bg-danger">
                                ADMIN
                            </span>

                        <% } else { %>

                            <span class="badge bg-success">
                                EVALUATOR
                            </span>

                        <% } %>

                    </td>
                    
                    <td>

<a href="editUser.jsp?id=<%= u.getUserId() %>"
class="btn btn-warning btn-sm">

Edit

</a>

<a href="../deleteUser?id=<%= u.getUserId() %>"
class="btn btn-danger btn-sm"
onclick="return confirm('Delete User?')">

Delete

</a>

</td>

                </tr>

                <%
                }
                %>

                </tbody>

            </table>

        </div>

    </div>

    <!-- Footer -->

    <div class="footer">

        © 2026 Mock Evaluation System |
        User Management Module

    </div>

</div>

</body>
</html>