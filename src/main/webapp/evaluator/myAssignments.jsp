<%@ page import="java.util.ArrayList"%>
<%@ page import="com.mockevaluation.dao.AssignmentDAO"%>
<%@ page import="com.mockevaluation.model.User"%>



<%
User user =
(User)session.getAttribute("user");

if(user == null){
    response.sendRedirect("../index.jsp");
    return;
}

AssignmentDAO dao =
new AssignmentDAO();


ArrayList<String[]> list =
dao.getAssignmentsByEvaluator(
user.getUserId());



%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>My Assignments</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

body{
    background:#0f172a;
    color:white;
    font-family:'Segoe UI',sans-serif;
}

.container-box{
    padding:30px;
}

.page-title{
    color:#38bdf8;
    margin-bottom:25px;
}

.card-custom{
    background:#1e293b;
    border-radius:20px;
    padding:25px;
    box-shadow:0 10px 25px rgba(0,0,0,0.3);
}

.table{
    color:white !important;
}

.table thead{
    background:#334155;
}

.btn-evaluate{
    background:#10b981;
    border:none;
}

.btn-evaluate:hover{
    background:#059669;
}

</style>

</head>

<body>

<div class="container-box">

<h2 class="page-title">


<i class="bi bi-person-check-fill"></i>

My Assigned Participants

</h2>

<div class="card-custom">

<div class="table-responsive">

<table class="table table-dark table-hover table-bordered align-middle">

<thead>

<tr>

<th>ID</th>
<th>Participant Name</th>
<th>Email</th>
<th>Phone</th>
<th>Batch</th>
<th>Technology</th>
<th>Round</th>
<th>Assignment Date</th>
<th>Status</th>
<th>Action</th>
</tr>

</thead>

<tbody>

<tbody>

<%
if(list.size() > 0){

for(String[] row : list){

%>

<tr>

<td><%= row[0] %></td>
<td><%= row[1] %></td>
<td><%= row[2] %></td>
<td><%= row[3] %></td>
<td><%= row[4] %></td>
<td><%= row[5] %></td>
<td><%= row[6] %></td>
<td><%= row[7] %></td>

<!-- Status Column -->
<td>

<%
if("Completed".equals(row[9])){
%>

    <span class="badge bg-success">
        Completed
    </span>

<%
}else{
%>

    <span class="badge bg-warning text-dark">
        Pending
    </span>

<%
}
%>

</td>

<!-- Action Column -->
<td>

<%
if("Pending".equals(row[9])){
%>

    <a href="evaluation.jsp?participantId=<%= row[0] %>&roundId=<%= row[8] %>"
       class="btn btn-evaluate btn-sm">

        <i class="bi bi-clipboard-check"></i>
        Evaluate

    </a>

<%
}else{
%>

    <button
        class="btn btn-secondary btn-sm"
        disabled>

        Already Evaluated

    </button>

<%
}
%>

</td>

</tr>

<%
}
}else{
%>

<tr>

<td colspan="10" class="text-center">

    No Assignments Found

</td>

</tr>

<%
}
%>

</tbody>


</td>

</tbody>

</table>

</div>

</div>

<br>

<a href="dashboard.jsp"
class="btn btn-warning">

<i class="bi bi-arrow-left"></i>

Back Dashboard

</a>

</div>

</body>
</html>