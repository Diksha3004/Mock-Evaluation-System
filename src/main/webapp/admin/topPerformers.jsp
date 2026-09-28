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
dao.getTopPerformers();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Top Performers Report</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
    padding:25px;
    border-radius:20px;
    margin-bottom:25px;
}

h2{
    color:#38bdf8;
}

table{
    color:white !important;
}

.chart-container{
    width:100%;
    max-width:850px;
    height:450px;
    margin:auto;
}

#performerChart{
    width:100% !important;
    height:100% !important;
}

.rank1{
    color:gold;
    font-weight:bold;
}

.rank2{
    color:silver;
    font-weight:bold;
}

.rank3{
    color:#cd7f32;
    font-weight:bold;
}

</style>

</head>

<body>

<div class="container-box">

<h2>
 Top Performers Report
</h2>

<div class="card-custom">

<table class="table table-dark table-hover">

<thead>

<tr>

<th>Rank</th>
<th>Participant</th>
<th>Average Score</th>
<th>Total Evaluations</th>

</tr>

</thead>

<tbody>

<%
int rank=1;

for(String[] row : report){
%>

<tr>

<td>

<%
if(rank==1){
%>
<span class="rank1">#1</span>
<%
}
else if(rank==2){
%>
<span class="rank2">#2</span>
<%
}
else if(rank==3){
%>
<span class="rank3">#3</span>
<%
}
else{
%>
#<%= rank %>
<%
}
%>

</td>

<td><%= row[0] %></td>

<td><%= row[1] %></td>

<td><%= row[2] %></td>

</tr>

<%
rank++;
}
%>

</tbody>

</table>

</div>

<div class="card-custom">

<div class="chart-container">

<canvas id="performerChart"></canvas>

</div>

</div>

<a href="report.jsp"
class="btn btn-info">

Back Reports

</a>

</div>

<script>

const labels = [

<%
for(int i=0;i<report.size();i++){
%>

'<%= report.get(i)[0] %>'

<%= (i<report.size()-1)?",":"" %>

<%
}
%>

];

const scores = [

<%
for(int i=0;i<report.size();i++){
%>

<%= report.get(i)[1] %>

<%= (i<report.size()-1)?",":"" %>

<%
}
%>

];

new Chart(
document.getElementById("performerChart"),
{
type:'bar',

data:{

labels:labels,

datasets:[{

label:'Average Score',

data:scores,

backgroundColor:[
'#FFD700',
'#C0C0C0',
'#CD7F32',
'#38bdf8',
'#10b981',
'#f97316'
]

}]
},

options:{

responsive:true,

maintainAspectRatio:false,

plugins:{
legend:{
display:false
}
},

scales:{
y:{
beginAtZero:true,
max:100
}
}

}

});

</script>

</body>
</html>