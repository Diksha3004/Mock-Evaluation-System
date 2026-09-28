
<%@page import="java.util.*"%>
<%@page import="com.mockevaluation.dao.*"%>
<%@page import="com.mockevaluation.model.*"%>
<%@page import="com.mockevaluation.model.User"%>

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
<title>Evaluator Assignment</title>

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

/* SIDEBAR */

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

/* MAIN CONTENT */

.main-content{
    margin-left:260px;
    padding:25px;
}

/* TOPBAR */

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

/* GLASS CARD */

.glass-card{
    background:rgba(255,255,255,0.05);
    backdrop-filter:blur(15px);
    border-radius:20px;
    padding:30px;
    box-shadow:0 10px 30px rgba(0,0,0,.3);
}

/* FORM */

.form-label{
    color:#cbd5e1;
    margin-bottom:8px;
}

.form-select{
    background:#1e293b;
    border:none;
    color:white;
}

.form-select:focus{
    background:#1e293b;
    color:white;
    box-shadow:0 0 0 2px #38bdf8;
}

.btn-assign{
    background:#38bdf8;
    border:none;
    padding:12px 25px;
    border-radius:10px;
    color:white;
    font-weight:600;
    transition:.3s;
}

.btn-assign:hover{
    background:#0ea5e9;
    transform:translateY(-2px);
}

/* TABLE */

.table-container{
    margin-top:30px;
}

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

/* FOOTER */

.footer{
    text-align:center;
    margin-top:25px;
    color:#94a3b8;
}

</style>

</head>

<body>

<!-- SIDEBAR -->

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

        <li><a href="round.jsp"><i class="bi bi-diagram-3"></i> Rounds</a></li>

        <li><a href="assignment.jsp" class="active"><i class="bi bi-person-check"></i> Assignment</a></li>

        <li><a href="report.jsp"><i class="bi bi-bar-chart"></i> Reports</a></li>
        
         <li><a href="user.jsp"><i class="bi bi-person-gear"></i>Users</a></li>

    </ul>

</div>

<!-- MAIN CONTENT -->

<div class="main-content">

    <!-- TOPBAR -->

    <div class="topbar">

        <h3>
            <i class="bi bi-person-check-fill"></i>
            Evaluator Assignment
        </h3>

        <a href="../logout"
           class="btn btn-danger">

           <i class="bi bi-box-arrow-right"></i>
           Logout

        </a>

    </div>

    <!-- FORM CARD -->

    <div class="glass-card">

        <h4 class="mb-4">Assign Evaluator</h4>

        <form action="../AssignmentServlet"
              method="post">

            <div class="mb-3">

                <label class="form-label">
                    Participant
                </label>

                <select name="participantId"
                        class="form-select">

                    <%
                    ParticipantDAO pdao =
                    new ParticipantDAO();

                    ArrayList<Participant> plist =
                    pdao.getAllParticipants();

                    for(Participant p : plist){
                    %>

                    <option value="<%=p.getParticipantId()%>">
                        <%=p.getFullName()%>
                    </option>

                    <%
                    }
                    %>

                </select>

            </div>

            <div class="mb-3">

                <label class="form-label">
                    Evaluator
                </label>

                <select name="evaluatorId"
                        class="form-select">

                    <%
                    UserDAO udao =
                    new UserDAO();

                    ArrayList<User> ulist =
                    udao.getEvaluators();

                    for(User u : ulist){
                    %>

                    <option value="<%=u.getUserId()%>">
                        <%=u.getFullName()%>
                    </option>

                    <%
                    }
                    %>

                </select>

            </div>

            <div class="mb-3">

                <label class="form-label">
                    Round
                </label>

                <select name="roundId"
                        class="form-select">

                    <%
                    EvaluationRoundDAO rdao =
                    new EvaluationRoundDAO();

                    ArrayList<EvaluationRound> rlist =
                    rdao.getAllRounds();

                    for(EvaluationRound r : rlist){
                    %>

                    <option value="<%=r.getRoundId()%>">
                        <%=r.getRoundName()%>
                    </option>

                    <%
                    }
                    %>

                </select>

            </div>

            <button type="submit"
                    class="btn-assign">

                <i class="bi bi-person-plus-fill"></i>
                Assign Evaluator

            </button>

        </form>

    </div>

    <!-- TABLE -->

    <div class="glass-card table-container">

        <h4 class="mb-3">
            All Assignments
        </h4>

        <table class="table table-hover table-bordered align-middle">

            <thead>

            <tr>
                <th>ID</th>
                <th>Participant ID</th>
                <th>Evaluator ID</th>
                <th>Round ID</th>
                <th>Actions</th>
            </tr>

            </thead>

            <tbody>

            <%
            AssignmentDAO dao =
            new AssignmentDAO();

            ArrayList<Assignment> list =
            dao.getAllAssignments();

            for(Assignment a : list){
            %>

            <tr>

                <td><%=a.getAssignmentId()%></td>
                <td><%=a.getParticipantId()%></td>
                <td><%=a.getEvaluatorId()%></td>
                <td><%=a.getRoundId()%></td>
                
                <td>

<a href="editAssignment.jsp?id=<%= a.getAssignmentId() %>"
class="btn btn-warning btn-sm">

Edit

</a>

<a href="../deleteAssignment?id=<%= a.getAssignmentId() %>"
class="btn btn-danger btn-sm"
onclick="return confirm('Delete Assignment?')">

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
        © 2026 Mock Evaluation System | Evaluator Assignment Module
    </div>

</div>

</body>
</html>
