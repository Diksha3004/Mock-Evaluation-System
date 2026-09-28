<%@ page import="java.util.ArrayList"%>
<%@ page import="com.mockevaluation.dao.EvaluationDAO"%>

<%

EvaluationDAO dao =
new EvaluationDAO();

ArrayList<String[]> list =
dao.getRoundWiseReport();

%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>
Round Wise Report
</title>

<link href=
"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<style>

body{
    background:#0f172a;
    color:white;
    padding:30px;
    font-family:Segoe UI;
}

.card-custom{

    background:#1e293b;
    padding:25px;

    border-radius:20px;

    box-shadow:
    0 10px 30px rgba(0,0,0,0.3);
}

h2{

    color:#38bdf8;

    margin-bottom:20px;
}

.table thead{

    background:#334155;
}

</style>

</head>

<body>

<div class="card-custom">

<h2>

Round Wise Performance Report

</h2>

<table class="table table-dark table-bordered table-hover">

<thead>

<tr>

<th>
Round Name
</th>

<th>
Total Evaluations
</th>

<th>
Average Score
</th>

</tr>

</thead>

<tbody>

<%

for(String[] row : list){

%>

<tr>

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