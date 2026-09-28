
<%@page import="java.util.*"%>
<%@page import="com.mockevaluation.dao.*"%>
<%@page import="com.mockevaluation.model.*"%>
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
<title>Evaluation Round Management</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

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
    margin:0;
}

/* Glass Card */

.glass-card{
    background:rgba(255,255,255,0.05);
    backdrop-filter:blur(15px);
    border-radius:20px;
    padding:30px;
    box-shadow:0 10px 30px rgba(0,0,0,.3);
}

/* Form */

.form-label{
    color:#cbd5e1;
    font-weight:500;
}

.form-control,
.form-select{
    background:#1e293b;
    border:none;
    color:white;
}

.form-control:focus,
.form-select:focus{
    background:#1e293b;
    color:white;
    box-shadow:0 0 0 2px #38bdf8;
}

.btn-add{
    background:#38bdf8;
    border:none;
    color:white;
    padding:12px 25px;
    border-radius:10px;
    font-weight:600;
    transition:.3s;
}

.btn-add:hover{
    background:#0ea5e9;
    transform:translateY(-2px);
}

/* Table */

.table{
    color:white;
}

.table thead{
    background:#1e293b;
}

.table tbody tr{
    background:#172033;
}

.table tbody tr:hover{
    background:#22304a;
}

/* Footer */

.footer{
    text-align:center;
    margin-top:25px;
    color:#94a3b8;
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

        <li><a href="dashboard.jsp"><i class="bi bi-grid"></i> Dashboard</a></li>

        <li><a href="batch.jsp"><i class="bi bi-collection"></i> Batch</a></li>

        <li><a href="technology.jsp"><i class="bi bi-cpu"></i> Technology</a></li>

        <li><a href="participant.jsp"><i class="bi bi-people"></i> Participants</a></li>

        <li><a href="round.jsp" class="active"><i class="bi bi-diagram-3"></i> Rounds</a></li>

        <li><a href="assignment.jsp"><i class="bi bi-person-check"></i> Assignment</a></li>

        <li><a href="report.jsp"><i class="bi bi-bar-chart"></i> Reports</a></li>
        
        <li><a href="user.jsp"><i class="bi bi-person-gear"></i>Users</a></li>

    </ul>

</div>

<!-- Main Content -->

<div class="main-content">

    <div class="topbar">

        <h3>
            <i class="bi bi-diagram-3-fill"></i>
            Evaluation Round Management
        </h3>

        <a href="../logout"
           class="btn btn-danger">

            <i class="bi bi-box-arrow-right"></i>
            Logout

        </a>

    </div>

    <!-- Add Round Form -->

    <div class="glass-card">

        <h4 class="mb-4">
            Add New Evaluation Round
        </h4>

        <form action="../EvaluationRoundServlet"
              method="post">

            <div class="mb-3">

                <label class="form-label">
                    Round Name
                </label>

                <input type="text"
                       name="roundName"
                       class="form-control"
                       placeholder="Enter Round Name"
                       required>

            </div>

            <div class="mb-3">

                <label class="form-label">
                    Technology
                </label>

                <select name="technologyId"
                        class="form-select">

                    <%
                    TechnologyDAO techDAO =
                    new TechnologyDAO();

                    ArrayList<Technology> techList =
                    techDAO.getAllTechnologies();

                    for(Technology t : techList){
                    %>

                    <option value="<%= t.getTechnologyId()%>">
                        <%= t.getTechnologyName()%>
                    </option>

                    <%
                    }
                    %>

                </select>

            </div>

            <button type="submit"
                    class="btn-add">

                <i class="bi bi-plus-circle-fill"></i>
                Add Round

            </button>

        </form>

    </div>

    <!-- Round Table -->

    <div class="glass-card mt-4">

        <h4 class="mb-3">
            All Evaluation Rounds
        </h4>

        <table class="table table-hover table-bordered align-middle">

            <thead>

            <tr>
                <th>ID</th>
                <th>Round Name</th>
                <th>Technology ID</th>
                <th>Actions</th>
            </tr>

            </thead>

            <tbody>

            <%
            EvaluationRoundDAO dao =
            new EvaluationRoundDAO();

            ArrayList<EvaluationRound> list =
            dao.getAllRounds();

            for(EvaluationRound r : list){
            %>

            <tr>

                <td><%= r.getRoundId()%></td>
                <td><%= r.getRoundName()%></td>
                <td><%= r.getTechnologyId()%></td>
                
                <td>

<a href="editRound.jsp?id=<%= r.getRoundId() %>"
class="btn btn-warning btn-sm">

Edit

</a>

<a href="../deleteRound?id=<%= r.getRoundId() %>"
class="btn btn-danger btn-sm"
onclick="return confirm('Delete Round?')">

Delete

</a>

</td>

            </tr>

            <%
            }
            %>

            </tbody>

        </table>

    </div>

    <div class="footer">
        © 2026 Mock Evaluation System | Evaluation Round Module
    </div>

</div>

</body>
</html>

