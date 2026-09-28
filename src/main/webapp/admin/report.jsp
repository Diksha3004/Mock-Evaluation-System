
<%@page import="com.mockevaluation.dao.*"%>
<%@ page import="com.mockevaluation.model.User"%>

<%
User user = (User)session.getAttribute("user");

if(user == null)
{
    response.sendRedirect("../index.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Reports Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>

body{
    margin:0;
    background:#0f172a;
    color:white;
    font-family:'Segoe UI',sans-serif;
}

/* Sidebar */

.sidebar{
    width:260px;
    height:100vh;
    background:#111827;
    position:fixed;
    left:0;
    top:0;
    padding:25px;
    overflow-y:auto;
    overflow-x:hidden;
}

.logo{
    font-size:24px;
    font-weight:bold;
    color:#38bdf8;
    margin-bottom:35px;
}

.menu{
    list-style:none;
    padding:0;
}

.menu li{
    margin-bottom:10px;
}

.menu a{
    display:block;
    padding:12px 15px;
    color:#cbd5e1;
    text-decoration:none;
    border-radius:12px;
    transition:.3s;
}

.menu a:hover,
.menu a.active{
    background:#1e293b;
    color:white;
}

/* Main Content */

.main-content{
    margin-left:260px;
    padding:25px;
}

/* Topbar */

.topbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:25px;
}

.topbar h3{
    color:#38bdf8;
}

/* Cards */

.stat-card{
    background:rgba(255,255,255,0.05);
    backdrop-filter:blur(15px);
    border-radius:20px;
    padding:25px;
    text-align:center;
    transition:.3s;
    box-shadow:0 10px 30px rgba(0,0,0,.3);
}

.stat-card:hover{
    transform:translateY(-5px);
}

.stat-card i{
    font-size:35px;
    color:#38bdf8;
}

.stat-card h2{
    margin-top:10px;
    font-weight:bold;
}

/* Chart Card */

.chart-card{
    background:rgba(255,255,255,0.05);
    backdrop-filter:blur(15px);
    border-radius:20px;
    padding:25px;
    margin-top:25px;
    box-shadow:0 10px 30px rgba(0,0,0,.3);
}

/* Footer */

.footer{
    text-align:center;
    color:#94a3b8;
    margin-top:25px;
}

.chart-container{
    width:100%;
    max-width:900px;
    height:350px;
    margin:auto;
    position:relative;
}

#reportChart{
    width:100% !important;
    height:100% !important;
}



</style>

</head>

<body>

<%
ParticipantDAO participantDAO =
new ParticipantDAO();

EvaluationDAO evaluationDAO =
new EvaluationDAO();

int totalParticipants =
participantDAO.getTotalParticipants();

int totalEvaluations =
evaluationDAO.getTotalEvaluations();

double averageScore =
evaluationDAO.getAverageScore();
%>

<!-- Sidebar -->

<div class="sidebar">

    <div class="logo">
        <i class="bi bi-mortarboard-fill"></i>
        MockEval
    </div>

    <ul class="menu">

        <li><a href="dashboard.jsp"><i class="bi bi-grid"></i> Dashboard</a></li>

        <li><a href="report.jsp" class="active"><i class="bi bi-bar-chart"></i> Reports</a></li>
        
       <li><a href="batchReport.jsp"><i class="bi bi-bar-chart-fill"></i>Batch Wise Report</a></li>

	   <li><a href="technologyReport.jsp"><i class="bi bi-pie-chart-fill"></i>Technology Report</a></li>

	   <li><a href="topPerformers.jsp"><i class="bi bi-trophy-fill"></i>Top Performers</a></li>

	   <li><a href="participantDetailedReport.jsp"><i class="bi bi-person-lines-fill"></i>Participant Report</a></li>

	   <li><a href="evaluatorPerformanceReport.jsp"><i class="bi bi-award-fill"></i>Evaluator Report</a></li>

	   <li><a href="evaluatorWorkload.jsp"><i class="bi bi-clipboard-data-fill"></i>Workload Dashboard</a></li>

	   <li><a href="../exportReport"><i class="bi bi-file-earmark-pdf-fill"></i>Export PDF</a></li>
	   
    </ul>

</div>

<!-- Main Content -->

<div class="main-content">

    <div class="topbar">
    
        <h3>
            <i class="bi bi-bar-chart-fill"></i>
            Reports Dashboard
        </h3>
        
        <a href="../logout"
           class="btn btn-danger">
            <i class="bi bi-box-arrow-right"></i>
            Logout
        </a>

    </div>

    <!-- Statistics Cards -->

    <div class="row g-4">

        <div class="col-md-4">

            <div class="stat-card">

                <i class="bi bi-people-fill"></i>

                <h5>Total Participants</h5>

                <h2><%= totalParticipants %></h2>

            </div>

        </div>

        <div class="col-md-4">

            <div class="stat-card">

                <i class="bi bi-clipboard-check-fill"></i>

                <h5>Total Evaluations</h5>

                <h2><%= totalEvaluations %></h2>

            </div>

        </div>

        <div class="col-md-4">

            <div class="stat-card">

                <i class="bi bi-award-fill"></i>

                <h5>Average Score</h5>

                <h2><%= String.format("%.2f", averageScore) %></h2>

            </div>

        </div>

    </div>

    <!-- Analytics Chart -->

    <div class="chart-card">

    <h4 class="mb-4">
        Evaluation Analytics
    </h4>

    <div class="chart-container">

        <canvas id="reportChart"></canvas>

    </div>

</div>

    <div class="footer">
        © 2026 Mock Evaluation System | Reports Dashboard
    </div>

</div>

<script>

const ctx =
document.getElementById('reportChart');

new Chart(ctx, {

    type:'bar',

    data:{

        labels:[
            'Participants',
            'Evaluations',
            'Average Score'
        ],

        datasets:[{

            label:'Statistics',

            data:[
                <%= totalParticipants %>,
                <%= totalEvaluations %>,
                <%= averageScore %>
            ],

            backgroundColor:[
                '#38bdf8',
                '#10b981',
                '#f59e0b'
            ]

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

