<%@ page import="com.mockevaluation.dao.UserDAO"%>
<%@ page import="com.mockevaluation.model.User"%>

<%
long id =
Long.parseLong(
request.getParameter("id"));

UserDAO dao =
new UserDAO();

User u =
dao.getUserById(id);
%>

<!DOCTYPE html>
<html>
<head>

<title>Edit User</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body class="container mt-5">

<h2>Edit User</h2>

<form action="../updateUser"
method="post">

<input type="hidden"
name="userId"
value="<%= u.getUserId() %>">

<div class="mb-3">

<label>Full Name</label>

<input type="text"
name="fullName"
class="form-control"
value="<%= u.getFullName() %>"
required>

</div>

<div class="mb-3">

<label>Email</label>

<input type="email"
name="email"
class="form-control"
value="<%= u.getEmail() %>"
required>

</div>

<div class="mb-3">

<label>Password</label>

<input type="text"
name="password"
class="form-control"
value="<%= u.getPassword() %>"
required>

</div>

<div class="mb-3">

<label>Role</label>

<select name="role"
class="form-control">

<option value="ADMIN"
<%= u.getRole().equals("ADMIN")?"selected":"" %>>

ADMIN

</option>

<option value="EVALUATOR"
<%= u.getRole().equals("EVALUATOR")?"selected":"" %>>

EVALUATOR

</option>

</select>

</div>

<button type="submit"
class="btn btn-success">

Update User

</button>

<a href="user.jsp"
class="btn btn-secondary">

Cancel

</a>

</form>

</body>
</html>