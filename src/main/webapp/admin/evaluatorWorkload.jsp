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

ArrayList<String[]> report =
dao.getEvaluatorWorkload();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Evaluator Workload</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>

body{
    background:#0f172a;
    color:white;
}

.card-custom{
    background:#1e293b;
    padding:25px;
    border-radius:20px;
    margin-bottom:25px;
}

.chart-container{
    width:100%;
    max-width:900px;
    height:400px;
    margin:auto;
    
}

table{
    color:white !important;
}

</style>

</head>

<body>

<div class="container mt-4">

<h2 class="text-info">
Evaluator Workload Dashboard
</h2>

<div class="card-custom">

<table class="table table-dark table-hover">

<thead>

<tr>

<th>Evaluator</th>
<th>Assignments</th>
<th>Completed</th>
<th>Pending</th>

</tr>

</thead>

<tbody>

<%
for(String[] row : report){
%>

<tr>

<td><%= row[0] %></td>
<td><%= row[1] %></td>
<td><%= row[2] %></td>
<td><%= row[3] %></td>

</tr>

<%
}
%>

</tbody>

</table>

</div>

<div class="card-custom">

<div class="chart-container">

<canvas id="workloadChart"></canvas>

</div>

</div>

<a href="report.jsp"
class="btn btn-info">

Back Reports

</a>

</div>

<script>

const labels=[

<%
for(int i=0;i<report.size();i++){
%>

'<%= report.get(i)[0] %>'

<%= i<report.size()-1?",":"" %>

<%
}
%>

];

const assignments=[

<%
for(int i=0;i<report.size();i++){
%>

<%= report.get(i)[1] %>

<%= i<report.size()-1?",":"" %>

<%
}
%>

];

const completed=[

<%
for(int i=0;i<report.size();i++){
%>

<%= report.get(i)[2] %>

<%= i<report.size()-1?",":"" %>

<%
}
%>

];

new Chart(
document.getElementById("workloadChart"),
{

type:'bar',

data:{

labels:labels,

datasets:[

{
label:'Assignments',
data:assignments
},

{
label:'Completed',
data:completed
}

]

},

options:{

responsive:true,

maintainAspectRatio:false,

scales:{

x:{
ticks:{
color:'white'
}
},

y:{
ticks:{
color:'white'
}
}

}

}

});

</script>

</body>
</html>