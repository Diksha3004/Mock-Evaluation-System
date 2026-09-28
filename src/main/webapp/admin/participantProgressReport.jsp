<%@ page import="java.util.ArrayList"%>
<%@ page import="com.mockevaluation.dao.EvaluationDAO"%>

<%
EvaluationDAO dao =
new EvaluationDAO();

ArrayList<String[]> list =
dao.getParticipantProgressReport();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Participant Progress Report</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<style>

body{
    background:#0f172a;
    color:white;
    padding:30px;
}

.card-custom{
    background:#1e293b;
    border-radius:20px;
    padding:25px;
}

h2{
    color:#38bdf8;
    margin-bottom:20px;
}

</style>

</head>

<body>

<div class="card-custom">

<h2>

Participant Progress Report

</h2>

<table class="table table-dark table-bordered">

<thead>

<tr>

<th>ID</th>
<th>Name</th>
<th>Total Evaluations</th>
<th>Average Score</th>
<th>Performance</th>

</tr>

</thead>

<tbody>

<%
for(String[] row : list){
%>

<tr>

<td><%= row[0] %></td>

<td><%= row[1] %></td>

<td><%= row[2] %></td>

<td><%= row[3] %></td>

<td>

<%
if(row[4].equals("Excellent")){
%>

<span class="badge bg-success">
Excellent
</span>

<%
}else if(row[4].equals("Good")){
%>

<span class="badge bg-primary">
Good
</span>

<%
}else if(row[4].equals("Average")){
%>

<span class="badge bg-warning">
Average
</span>

<%
}else{
%>

<span class="badge bg-danger">
Poor
</span>

<%
}
%>

</td>

</tr>

<%
}
%>

</tbody>

</table>

<a href="dashboard.jsp"
class="btn btn-info">

Back Dashboard

</a>

</div>

</body>
</html>