<%@ page import="com.mockevaluation.model.User" %>
<%@ page import="com.mockevaluation.dao.EvaluationDAO" %>

<%
User user = (User)session.getAttribute("user");


if(user == null){
    response.sendRedirect("../index.jsp");
    return;
}

EvaluationDAO dao =
new EvaluationDAO();

int totalAssignments =
dao.getTotalAssignments(
user.getUserId());

int completedEvaluations =
dao.getCompletedEvaluations(
user.getUserId());

int pendingEvaluations =
dao.getPendingEvaluations(
user.getUserId());

double avgScore =
dao.getEvaluatorAverageScore(
user.getUserId());

int[] analytics =
dao.getScoreAnalytics();
%>


<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Evaluator Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/style.css">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

.hero-card{
    background:linear-gradient(135deg,#38bdf8,#2563eb);
    border-radius:20px;
    padding:40px;
    color:white;
    box-shadow:0 10px 30px rgba(0,0,0,0.3);
    margin-bottom:30px;
}

.hero-card h1{
    font-size:36px;
    font-weight:700;
}

.hero-card p{
    font-size:18px;
    margin-top:10px;
}

.dashboard-box{
    background:rgba(255,255,255,0.05);
    backdrop-filter:blur(15px);
    border-radius:20px;
    padding:30px;
    text-align:center;
    transition:0.3s;
    height:100%;
    border:1px solid rgba(255,255,255,0.08);
    text-decoration:none;
    color:white;
    display:block;
}

.dashboard-box:hover{
    transform:translateY(-8px);
    color:white;
}

.dashboard-box i{
    font-size:50px;
    color:#38bdf8;
    margin-bottom:15px;
}

.dashboard-box h4{
    font-weight:600;
}

</style>

</head>

<body>

<!-- Sidebar -->

<div class="sidebar">

    <div class="logo">
        <i class="bi bi-mortarboard-fill"></i>
        MockEval
    </div>

    <ul class="menu">

        <li>
            <a href="dashboard.jsp" class="active">
                <i class="bi bi-grid"></i>
                Dashboard
            </a>
        </li>


        
       <li>
            <a href="myAssignments.jsp">
                <i class="bi bi-bar-chart"></i>
                My Assignments
            </a>
        </li>
        
         <li>
            <a href="evaluationHistory.jsp">
                <i class="bi bi-clipboard-data"></i>
                Evaluations
            </a>
        </li>
        
        



    </ul>

</div>

<!-- Main Content -->

<div class="main-content fade-in">

    <!-- Topbar -->

    <div class="topbar">

        <h3>
            <i class="bi bi-person-badge-fill"></i>
            Evaluator Dashboard
        </h3>

        <a href="../logout"
           class="btn btn-danger">

            <i class="bi bi-box-arrow-right"></i>
            Logout

        </a>

    </div>

    <!-- Welcome Card -->

    <div class="hero-card">

        <h1>
            Welcome,
            <%= user.getFullName() %>
        </h1>

        <p>
            Logged in as:
            <strong><%= user.getRole() %></strong>
        </p>

    </div>

    <!-- Statistics Cards -->
    
    <div class="row g-4 mb-4">

    <div class="col-md-3">

        <div class="dashboard-box">

            <i class="bi bi-person-check-fill"></i>

            <h4>
                <%= totalAssignments %>
            </h4>

            <p>Total Assignments</p>

        </div>

    </div>

    <div class="col-md-3">

        <div class="dashboard-box">

            <i class="bi bi-check-circle-fill"></i>

            <h4>
                <%= completedEvaluations %>
            </h4>

            <p>Completed</p>

        </div>

    </div>

    <div class="col-md-3">

        <div class="dashboard-box">

            <i class="bi bi-clock-fill"></i>

            <h4>
                <%= pendingEvaluations %>
            </h4>

            <p>Pending</p>

        </div>

    </div>

    <div class="col-md-3">

        <div class="dashboard-box">

            <i class="bi bi-star-fill"></i>

            <h4>
                <%= String.format("%.2f",
                avgScore) %>
            </h4>

            <p>Average Score</p>

        </div>

    </div>

</div>

    

<div class="row g-4 mb-4">

        <div class="col-md-6">

            <a href="report.jsp"
   class="dashboard-box">

                <i class="bi bi-bar-chart-fill"></i>

                <h4>
                    View Reports
                </h4>

                <p>
                    Analyze evaluation statistics and reports.
                </p>

            </a>

        </div> <br>
        
        <div class="col-md-6">

            <a href="analytics.jsp"
   class="dashboard-box">

                <i class="bi bi-bar-chart"></i>

                <h4>
                   Analytics Dashboard
                </h4>

                <p>
                    View evaluation pie charts
                </p>

            </a>

        </div>
    </div>
    </div>

   

    <!-- Footer -->

    <div class="footer">

        © 2026 Mock Evaluation System |
        Evaluator Dashboard

    </div>

</div>

</body>
</html>