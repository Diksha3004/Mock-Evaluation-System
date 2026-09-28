<%@ page import="java.util.ArrayList"%>
<%@ page import="com.mockevaluation.dao.EvaluationDAO"%>
<%@ page import="com.mockevaluation.model.User"%>


<%
if(request.getParameter("deleted")!=null){
%>

<div class="alert alert-success">

Evaluation Deleted Successfully

</div>

<%
}
%>

<%
User user =
(User)session.getAttribute("user");

if(user == null){
    response.sendRedirect("../index.jsp");
    return;
}

EvaluationDAO dao =
new EvaluationDAO();

ArrayList<String[]> list =
dao.getEvaluationHistory(
user.getUserId());
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Evaluation History</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

body{
    background:#0f172a;
    color:white;
    font-family:'Segoe UI';
}

.container-box{
    padding:30px;
}

.card-custom{
    background:#1e293b;
    border-radius:20px;
    padding:25px;
}

.table{
    color:white;
}

.table thead{
    background:#334155;
}

h2{
    color:#38bdf8;
    margin-bottom:20px;
}

.badge-excellent{
    background:#10b981;
}

.badge-good{
    background:#3b82f6;
}

.badge-average{
    background:#f59e0b;
}

.badge-poor{
    background:#ef4444;
}

</style>

</head>

<body>

<div class="container-box">

<div class="card-custom">

<h2>

<i class="bi bi-clock-history"></i>

Evaluation History

</h2>

<%
if(request.getParameter("success")!=null){
%>

<div class="alert alert-success">

Evaluation Saved Successfully

</div>

<%
}
%>

<table class="table table-dark table-hover table-bordered">

<thead>

<tr>

<th>Participant</th>
<th>Round</th>
<th>Score</th>
<th>Status</th>
<th>Feedback</th>
<th>Date</th>
<th>Action</th>
<th>Delete</th>

</tr>

</thead>

<tbody>

<%
for(String[] row : list){

	int score =
			Integer.parseInt(row[3]);

String status="";
String css="";

if(score>=80){

status="Excellent";
css="badge-excellent";

}else if(score>=60){

status="Good";
css="badge-good";

}else if(score>=40){

status="Average";
css="badge-average";

}else{

status="Poor";
css="badge-poor";
}
%>

<tr>

<td><%= row[1] %></td>

<td><%= row[2] %></td>

<td><%= row[3] %></td>

<td>

<span class="badge <%= css %>">

<%= status %>

</span>

</td>

<td><%= row[4] %></td>

<td><%= row[5] %></td>

<td>

<a href="editEvaluation.jsp?id=<%= row[0] %>"
class="btn btn-warning btn-sm">

Edit

</a>

</td>

<td>

<a href="../deleteEvaluation?id=<%= row[0] %>"
class="btn btn-danger btn-sm"
onclick="return confirm('Delete this evaluation?')">

<i class="bi bi-trash"></i>
Delete

</a>

</td>

</tr>



<%
}
%>

</tbody>

</table>

<a href="dashboard.jsp"
class="btn btn-info">

<i class="bi bi-arrow-left"></i>

Back Dashboard

</a>

</div>

</div>

</body>
</html>