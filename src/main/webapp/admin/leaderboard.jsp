<%@ page import="java.util.ArrayList"%>
<%@ page import="com.mockevaluation.dao.EvaluationDAO"%>
<%@ page import="com.mockevaluation.model.User"%>

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
dao.getEvaluatorLeaderboard();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Evaluator Leaderboard</title>

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

.rank{
    font-size:22px;
    font-weight:bold;
}

</style>

</head>

<body>

<div class="container-box">

<div class="card-custom">

<h2 class="mb-4 text-info">

<i class="bi bi-trophy-fill"></i>

Evaluator Leaderboard

</h2>

<table
class="table table-dark table-hover table-bordered">

<thead>

<tr>

<th>Rank</th>
<th>Evaluator</th>
<th>Total Evaluations</th>
<th>Average Score</th>

</tr>

</thead>

<tbody>

<%
int rank = 1;

for(String[] row : list){
%>

<tr>

<td class="rank">

<%

if(rank == 1){
    out.print("#1");
}
else if(rank == 2){
    out.print("#2");
}
else if(rank == 3){
    out.print("#3");
}
else{
    out.print(rank);
}

%>

</td>

<td>

<%= row[0] %>

</td>

<td>

<%= row[1] %>

</td>

<td>

<%= row[2] %>

</td>

</tr>

<%

rank++;

}
%>

</tbody>

</table>

<a href="dashboard.jsp"
class="btn btn-warning">

<i class="bi bi-arrow-left"></i>

Back Dashboard

</a>

</div>

</div>

</body>
</html>