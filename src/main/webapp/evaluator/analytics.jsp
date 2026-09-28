<%@ page import="com.mockevaluation.dao.EvaluationDAO"%>

<%
EvaluationDAO dao =
new EvaluationDAO();

int excellent =
dao.getExcellentCount();

int good =
dao.getGoodCount();

int average =
dao.getAverageCount();

int poor =
dao.getPoorCount();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Evaluation Analytics</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<style>

body{
    background:#0f172a;
    color:white;
    padding:30px;
}

.chart-card{
    background:white;
    border-radius:20px;
    padding:20px;
    width:400px;
    height:400px;
    margin:auto;
}

h2{
    text-align:center;
    margin-bottom:20px;
}

</style>

</head>

<body>

<h2>

Evaluation Analytics Dashboard

</h2>

<div class="chart-card">

<canvas id="performanceChart"></canvas>

</div>

<script>

const ctx =
document.getElementById("performanceChart");

new Chart(ctx, {

type: "pie",

data: {

labels: [

"Excellent",
"Good",
"Average",
"Poor"

],

datasets: [{

data: [

<%= excellent %>,
<%= good %>,
<%= average %>,
<%= poor %>

],

backgroundColor: [

"#10b981",
"#3b82f6",
"#f59e0b",
"#ef4444"

]

}]

}

});

</script>

<a href="dashboard.jsp"
class="btn btn-info">

<i class="bi bi-arrow-left"></i>

Back Dashboard

</a>
</body>
</html>