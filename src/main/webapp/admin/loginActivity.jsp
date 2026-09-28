<%@ page import="java.util.*"%>
<%@ page import="com.mockevaluation.dao.LoginActivityDAO"%>
<%@ page import="com.mockevaluation.model.LoginActivity"%>

<%
LoginActivityDAO dao =
new LoginActivityDAO();

ArrayList<LoginActivity> list =
dao.getAllActivities();
%>

<!DOCTYPE html>
<html>
<head>

<title>Login Activity Report</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body class="bg-dark text-white">

<div class="container mt-4">

<h2>
Login Activity Report
</h2>

<table class="table table-dark table-bordered">

<tr>
<th>ID</th>
<th>User ID</th>
<th>Role</th>
<th>Login Time</th>
<th>Logout Time</th>
</tr>

<%
for(LoginActivity a : list){
%>

<tr>

<td>
<%= a.getActivityId() %>
</td>

<td>
<%= a.getUserId() %>
</td>

<td>
<%= a.getRole() %>
</td>

<td>
<%= a.getLoginTime() %>
</td>

<td>
<%= a.getLogoutTime() %>
</td>

</tr>

<%
}
%>

</table>

</div>

</body>
</html>