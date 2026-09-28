
<%@ page import="java.util.*" %>
<%@ page import="com.mockevaluation.dao.BatchDAO" %>
<%@ page import="com.mockevaluation.model.Batch" %>
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
<title>Batch Management</title>

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

.logo i{
    margin-right:8px;
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
}

.form-control{
    background:#1e293b;
    border:none;
    color:white;
}

.form-control:focus{
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

        <li><a href="batch.jsp" class="active"><i class="bi bi-collection"></i> Batch</a></li>

        <li><a href="technology.jsp"><i class="bi bi-cpu"></i> Technology</a></li>

        <li><a href="participant.jsp"><i class="bi bi-people"></i> Participants</a></li>

        <li><a href="round.jsp"><i class="bi bi-diagram-3"></i> Rounds</a></li>

        <li><a href="assignment.jsp"><i class="bi bi-person-check"></i> Assignment</a></li>

        <li><a href="report.jsp"><i class="bi bi-bar-chart"></i> Reports</a></li>
        
        <li><a href="user.jsp"><i class="bi bi-person-gear"></i>Users</a></li>
        
        

    </ul>

</div>

<!-- Main Content -->

<div class="main-content">

    <div class="topbar">

        <h3>
            <i class="bi bi-collection-fill"></i>
            Batch Management
        </h3>

        <a href="../logout"
           class="btn btn-danger">

            <i class="bi bi-box-arrow-right"></i>
            Logout

        </a>

    </div>

    <!-- Add Batch Form -->

    <div class="glass-card">

        <h4 class="mb-4">
            Add New Batch
        </h4>

        <form action="../BatchServlet"
              method="post">

            <div class="mb-3">

                <label class="form-label">
                    Batch Name
                </label>

                <input type="text"
                       name="batchName"
                       class="form-control"
                       required>

            </div>

            <div class="mb-3">

                <label class="form-label">
                    Start Date
                </label>

                <input type="date"
                       name="startDate"
                       class="form-control">

            </div>

            <div class="mb-3">

                <label class="form-label">
                    End Date
                </label>

                <input type="date"
                       name="endDate"
                       class="form-control">

            </div>

            <button type="submit"
                    class="btn-add">

                <i class="bi bi-plus-circle-fill"></i>
                Add Batch

            </button>

        </form>

    </div>

    <!-- Batch Table -->

    <div class="glass-card mt-4">

        <h4 class="mb-3">
            All Batches
        </h4>

        <table class="table table-hover table-bordered align-middle">

            <thead>

            <tr>
                <th>ID</th>
                <th>Batch Name</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Actions</th>
            </tr>

            </thead>

            <tbody>

            <%
            BatchDAO dao = new BatchDAO();

            ArrayList<Batch> list =
                    dao.getAllBatches();

            for(Batch b : list){
            %>

            <tr>

<td><%= b.getBatchId() %></td>

<td><%= b.getBatchName() %></td>

<td><%= b.getStartDate() %></td>

<td><%= b.getEndDate() %></td>

<td>

<a href="editBatch.jsp?id=<%= b.getBatchId() %>"
class="btn btn-warning btn-sm">

<i class="bi bi-pencil-square"></i>
Edit

</a>

<a href="../deleteBatch?id=<%= b.getBatchId() %>"
class="btn btn-danger btn-sm"
onclick="return confirm('Delete Batch?')">

<i class="bi bi-trash"></i>
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
        © 2026 Mock Evaluation System | Batch Management Module
    </div>

</div>

</body>
</html>

