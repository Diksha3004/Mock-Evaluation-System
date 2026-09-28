<%@ page import="java.util.ArrayList" %>
<%@ page import="com.mockevaluation.dao.ParticipantDAO" %>
<%@ page import="com.mockevaluation.dao.RoundDAO" %>
<%@ page import="com.mockevaluation.model.Participant" %>
<%@ page import="com.mockevaluation.model.Round" %>
<%@ page import="com.mockevaluation.model.User" %>

<%
User user =
(User)session.getAttribute("user");

if(user == null)
{
    response.sendRedirect("../index.jsp");
    return;
}

ParticipantDAO participantDAO =
new ParticipantDAO();

RoundDAO roundDAO =
new RoundDAO();

ArrayList<Participant> participants =
participantDAO.getAllParticipants();

ArrayList<Round> rounds =
roundDAO.getAllRounds();

String participantId =
request.getParameter("participantId");

String roundId =
request.getParameter("roundId");
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Submit Evaluation</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

body{
    background:#0f172a;
    color:white;
    font-family:'Segoe UI',sans-serif;
}

.card-box{
    max-width:700px;
    margin:auto;
    margin-top:40px;
    background:#1e293b;
    padding:30px;
    border-radius:20px;
    box-shadow:0 10px 30px rgba(0,0,0,0.4);
}

h2{
    color:#38bdf8;
    margin-bottom:25px;
}

.form-control,
.form-select{
    background:#334155;
    border:none;
    color:white;
}

.form-control:focus,
.form-select:focus{
    background:#334155;
    color:white;
}

.btn-save{
    background:#38bdf8;
    border:none;
    width:100%;
    padding:12px;
    font-size:18px;
    font-weight:bold;
}

.btn-save:hover{
    background:#0ea5e9;
}

</style>

</head>

<body>

<div class="container">

<div class="card-box">

<h2>
<i class="bi bi-clipboard-check-fill"></i>
Submit Evaluation
</h2>


<%
if("duplicate".equals(
request.getParameter("error"))){
%>

<div class="alert alert-danger">

Evaluation already submitted
for this participant and round.

</div>

<%
}
%>

<form action="<%=request.getContextPath()%>/addEvaluation"
method="post">

<input type="hidden"
name="evaluatorId"
value="<%= user.getUserId() %>">

<div class="mb-3">

<input type="hidden"
name="participantId"
value="<%= participantId %>">

<input type="hidden"
name="roundId"
value="<%= roundId %>">

<div class="mb-3">

<div class="mb-3">

<label>Participant ID</label>

<input type="text"
class="form-control"
value="<%= participantId %>"
readonly>

</div>

<div class="mb-3">

<label>Round ID</label>

<input type="text"
class="form-control"
value="<%= roundId %>"
readonly>

</div>

<label>
Score
</label>

<input type="number"
name="score"
min="0"
max="100"
class="form-control"
required>

</div>

<div class="mb-3">

<label>
Feedback
</label>

<textarea
name="feedback"
rows="4"
class="form-control"
required></textarea>

</div>

<button type="submit"
class="btn btn-save">

<i class="bi bi-check-circle-fill"></i>

Save Evaluation

</button>

</form>

<br><br><br>

<a href="dashboard.jsp"
class="btn btn-warning">

Back Dashboard

</a>

</div>

</div>

</body>
</html>