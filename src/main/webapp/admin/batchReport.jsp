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
dao.getBatchWiseReport();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Batch Wise Report</title>

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

table{
    color:white !important;
}

h2{
    color:#38bdf8;
}

.chart-container{
    width:80%;
    max-width:700px;
    height:350px;
    margin:auto;
}



</style>

</head>

<body>

<div class="container-box">

<h2>
Batch Wise Report
</h2>

<div class="card-custom">

<table class="table table-dark table-hover">

<thead>

<tr>

<th>Batch Name</th>
<th>Total Evaluations</th>
<th>Average Score</th>

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

</tr>

<%
}
%>

</tbody>

</table>

</div>

<div class="card-custom chart-container">

    <h4 class="text-center mb-4">
        Batch Performance Analysis
    </h4>

    <canvas id="batchChart"></canvas>

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

<%= report.get(i)[2] %>

<%= (i<report.size()-1)?",":"" %>

<%
}
%>

];

new Chart(
document.getElementById("batchChart"),
{
    type:'bar',

    data:{
        labels:labels,

        datasets:[{

            label:'Average Score',

            data:scores,

            backgroundColor:[
                '#38bdf8',
                '#10b981',
                '#f59e0b',
                '#ef4444',
                '#8b5cf6',
                '#06b6d4'
            ],

            borderRadius:10,

            barThickness:45
        }]
    },

    options:{

        responsive:true,

        maintainAspectRatio:false,

        plugins:{

            legend:{
                labels:{
                    color:'white'
                }
            }
        },

        scales:{

            x:{
                ticks:{
                    color:'white'
                },

                grid:{
                    color:'rgba(255,255,255,0.05)'
                }
            },

            y:{
                beginAtZero:true,

                max:100,

                ticks:{
                    color:'white'
                },

                grid:{
                    color:'rgba(255,255,255,0.05)'
                }
            }
        }
    }
});

</script>

</body>
</html>