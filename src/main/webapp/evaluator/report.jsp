<%@page import="com.mockevaluation.dao.EvaluationDAO"%>
<%@page import="com.mockevaluation.model.User"%>

<%
User user =
(User)session.getAttribute("user");

if(user == null){
    response.sendRedirect("../index.jsp");
    return;
}

EvaluationDAO dao =
new EvaluationDAO();

int total =
dao.getEvaluatorEvaluationCount(
user.getUserId());

double avg =
dao.getEvaluatorAverageScore(
user.getUserId());
%>

<!DOCTYPE html>
<html>
<head>

<title>My Report</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body class="bg-dark text-white">

<div class="container mt-5">

<h2>My Performance Report</h2>

<hr>

<div class="row">

<div class="col-md-6">

<div class="card bg-primary text-white p-4">

<h4>Total Evaluations</h4>

<h1><%= total %></h1>

</div>

</div>

<div class="col-md-6">

<div class="card bg-success text-white p-4">

<h4>Average Score</h4>

<h1>
<%= String.format("%.2f",avg) %>
</h1>

</div>

</div>

</div>

<br>

<a href="dashboard.jsp"
class="btn btn-warning">
Back Dashboard
</a>

</div>

</body>
</html>