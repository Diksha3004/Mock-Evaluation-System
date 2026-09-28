<%@ page language="java" %>
<%@ page import="com.mockevaluation.model.User"%>
<%@ page import="com.mockevaluation.dao.ParticipantDAO"%>
<%@ page import="com.mockevaluation.dao.UserDAO"%>
<%@ page import="com.mockevaluation.dao.TechnologyDAO"%>
<%@ page import="com.mockevaluation.dao.EvaluationDAO"%>
<%@ page import="com.mockevaluation.dao.LoginActivityDAO"%>

<%
User user =
(User)session.getAttribute("user");

if(user == null)
{
    response.sendRedirect(
            "../index.jsp");
    return;
}

if(!user.getRole().equals("ADMIN"))
{
    response.sendRedirect(
            "../evaluator/dashboard.jsp");
    return;
}
%>
<%
ParticipantDAO participantDAO =
new ParticipantDAO();

UserDAO userDAO =
new UserDAO();

TechnologyDAO technologyDAO =
new TechnologyDAO();

EvaluationDAO evaluationDAO =
new EvaluationDAO();

int totalParticipants =
participantDAO.getTotalParticipants();

int totalEvaluators =
userDAO.getTotalEvaluators();

int totalTechnologies =
technologyDAO.getTotalTechnologies();

int totalEvaluations =
evaluationDAO.getTotalEvaluations();

double avgScore =
evaluationDAO.getAverageScore();

LoginActivityDAO loginDAO =
new LoginActivityDAO();

int totalLogins =
loginDAO.getTotalLogins();
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

body{
    background: linear-gradient(135deg,#0f172a,#1e293b);
    min-height:100vh;
    color:white;
    font-family:'Segoe UI',sans-serif;
}

/* NAVBAR */
.navbar{
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(12px);
    box-shadow:0 4px 20px rgba(0,0,0,.3);
}

.navbar-brand{
    font-size:24px;
    font-weight:bold;
    color:#fff !important;
}

/* HERO SECTION */
.hero{
    text-align:center;
    padding:50px 20px;
}

.hero h1{
    font-size:42px;
    font-weight:700;
}

.hero p{
    color:#cbd5e1;
}

/* DASHBOARD CARDS */
.dashboard-card{
    border:none;
    border-radius:20px;
    background:rgba(255,255,255,0.08);
    backdrop-filter:blur(10px);
    color:white;
    transition:0.4s;
    overflow:hidden;
}

.dashboard-card:hover{
    transform:translateY(-10px) scale(1.03);
    box-shadow:0 15px 30px rgba(0,0,0,.4);
}

.dashboard-card i{
    font-size:50px;
    margin-bottom:15px;
    color:#38bdf8;
}

.card-title{
    font-weight:600;
}

.btn-custom{
    border-radius:25px;
    width:100%;
}

/* FOOTER */
footer{
    margin-top:60px;
    background:rgba(255,255,255,0.08);
    padding:15px;
    text-align:center;
    color:#cbd5e1;
}

/* ANIMATION */
.fade-in{
    animation:fadeInUp 1s ease;
}

@keyframes fadeInUp{
    from{
        opacity:0;
        transform:translateY(40px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}


.dashboard-box{

    background:rgba(255,255,255,0.08);

    backdrop-filter:blur(10px);

    border-radius:20px;

    padding:25px;

    text-align:center;

    color:white;

    box-shadow:0 8px 20px rgba(0,0,0,0.3);

    transition:.3s;
}

.dashboard-box:hover{

    transform:translateY(-5px);
}

.dashboard-box h5{

    color:#cbd5e1;
}

.dashboard-box h1{

    color:#38bdf8;

    font-size:42px;

    font-weight:bold;
}

</style>

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">

        <a class="navbar-brand" href="#">
            <i class="bi bi-speedometer2"></i>
            Mock Evaluation System
        </a>

        <button class="navbar-toggler"
            data-bs-toggle="collapse"
            data-bs-target="#navbarNav">

            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse"
             id="navbarNav">

            <ul class="navbar-nav ms-auto">

                <li class="nav-item me-3">
                    <span class="nav-link">
                        Welcome Admin
                    </span>
                </li>

                <li class="nav-item">
                    <a href="../logout"
                       class="btn btn-danger">
                        <i class="bi bi-box-arrow-right"></i>
                        Logout
                    </a>
                </li>

            </ul>

        </div>
    </div>
</nav>

<!-- HERO SECTION -->

<div class="hero fade-in">
    <h1>Admin Dashboard</h1>
    <p>
        Manage Batches, Technologies, Participants,
        Evaluations and Reports from one place.
    </p>
</div>

<!-- DASHBOARD CARDS -->

<div class="container">

<div class="row g-4">

    <div class="col-md-4 fade-in">
        <div class="card dashboard-card p-4 text-center">
            <i class="bi bi-collection"></i>
            <h5 class="card-title">Batch Management</h5>
            <p>Manage all batches.</p>

            <a href="batch.jsp"
               class="btn btn-primary btn-custom">
               Open
            </a>
        </div>
    </div>

    <div class="col-md-4 fade-in">
        <div class="card dashboard-card p-4 text-center">
            <i class="bi bi-cpu"></i>
            <h5 class="card-title">Technology</h5>
            <p>Manage technologies.</p>

            <a href="technology.jsp"
               class="btn btn-warning btn-custom">
               Open
            </a>
        </div>
    </div>

    <div class="col-md-4 fade-in">
        <div class="card dashboard-card p-4 text-center">
            <i class="bi bi-people-fill"></i>
            <h5 class="card-title">Participants</h5>
            <p>Manage participants.</p>

            <a href="participant.jsp"
               class="btn btn-info btn-custom">
               Open
            </a>
        </div>
    </div>

    <div class="col-md-4 fade-in">
        <div class="card dashboard-card p-4 text-center">
            <i class="bi bi-diagram-3"></i>
            <h5 class="card-title">Rounds</h5>
            <p>Evaluation rounds.</p>

            <a href="round.jsp"
               class="btn btn-secondary btn-custom">
               Open
            </a>
        </div>
    </div>

    <div class="col-md-4 fade-in">
        <div class="card dashboard-card p-4 text-center">
            <i class="bi bi-person-check"></i>
            <h5 class="card-title">Assignments</h5>
            <p>Assign evaluators.</p>

            <a href="assignment.jsp"
               class="btn btn-dark btn-custom">
               Open
            </a>
        </div>
    </div>

    
    <div class="col-md-4 fade-in">
        <div class="card dashboard-card p-4 text-center">
            <i class="bi bi-clipboard-data"></i>
            <h5 class="card-title">Participant Progress</h5>
            <p>Check Progress</p>

            <a href="participantProgressReport.jsp"
               class="btn btn-success btn-custom">
               check
            </a>
        </div>
    </div>

    <div class="col-md-4 fade-in">
        <div class="card dashboard-card p-4 text-center">
            <i class="bi bi-bar-chart-line"></i>
            <h5 class="card-title">Reports Dashboard</h5>
            <p>Generate and view reports.</p>

            <a href="report.jsp"
               class="btn btn-danger btn-custom">
               Open Reports
            </a>
        </div>
    </div>
    
    <div class="col-md-4 fade-in">
        <div class="card dashboard-card p-4 text-center">
           <i class="bi bi-people"></i>
            <h5 class="card-title">User Management</h5>
            <p>Manage all Users</p>

            <a href="user.jsp"
               class="btn btn-warning btn-custom">
               Open 
            </a>
        </div>
    </div>
    
    <div class="col-md-4 fade-in">
        <div class="card dashboard-card p-4 text-center">
           <i class="bi bi-file-earmark-pdf-fill"></i>
            <h5 class="card-title">PDF</h5>
            <p>Generate PDF</p>

            <a href="../exportReport"
               class="btn btn-primary btn-custom">
               Download 
            </a>
        </div>
    </div>
    
     <div class="col-md-4 fade-in">
        <div class="card dashboard-card p-4 text-center">
           <i class="bi bi-trophy-fill"></i>
            <h5 class="card-title">Evaluator Leaderboard</h5>
            <p>Evaluator Leaderboard</p>

            <a href="leaderboard.jsp"
               class="btn btn-primary btn-custom">
               Open
            </a>
        </div>
    </div>
    
    <div class="col-md-4 fade-in">
        <div class="card dashboard-card p-4 text-center">
           <i class="bi bi-bar-chart-fill"></i>
            <h5 class="card-title">Round Wise Report</h5>
            <p>View round average score</p>

            <a href="roundWiseReport.jsp"
               class="btn btn-primary btn-custom">
               View 
            </a>
        </div>
    </div>
    
   
  
     
    
    <div class="row g-4 mb-4">
	<div class="col-md-4">
        <div class="dashboard-box">
            <h5>Total Participants</h5>
            <h1>
                <%= totalParticipants %>
            </h1>
        </div>
    </div>
    <div class="col-md-4">
        <div class="dashboard-box">
            <h5>Total Evaluators</h5>
            <h1>
                <%= totalEvaluators %>
            </h1>
        </div>
    </div>
    <div class="col-md-4">
        <div class="dashboard-box">
            <h5>Total Technologies</h5>
            <h1>
                <%= totalTechnologies %>
            </h1>
        </div>
    </div>
</div>
<div class="row g-4 mb-4">
    <div class="col-md-4">
        <div class="dashboard-box">
            <h5>Total Evaluations</h5>
            <h1>
                <%= totalEvaluations %>
            </h1>
        </div>
    </div>
    <div class="col-md-4">
        <div class="dashboard-box">
            <h5>Average Score</h5>
            <h1>
                <%= String.format("%.2f",avgScore) %>
            </h1>
        </div>
    </div>
</div>

<div class="row g-4 mb-4">
	<div class="col-md-4">
        <div class="dashboard-box">
            <h5>Login Activity</h5>
            <h1>
                <%= totalLogins %>
            </h1>
            
            <span class="status-text">
                Total User Sessions
            </span>
        </div>
    </div>
    

</div>

</div>

<!-- FOOTER -->

<footer>
    © 2026 Mock Evaluation System |
    Developed using JSP, Servlet, MySQL & Bootstrap
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>