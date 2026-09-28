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
dao.getParticipantDetailedReport();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Participant Detailed Report</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

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
}

h2{
    color:#38bdf8;
}

table{
    color:white !important;
}

.search-box{
    margin-bottom:20px;
}

</style>

</head>

<body>

<div class="container-box">

<h2>
Participant Detailed Report
</h2>

<div class="search-box">

<input type="text"
id="searchInput"
class="form-control"
placeholder="Search Participant">

</div>

<div class="card-custom">

<table
class="table table-dark table-hover"
id="participantTable">

<thead>

<tr>

<th>Name</th>
<th>Batch</th>
<th>Technology</th>
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
<td><%= row[3] %></td>
<td><%= row[4] %></td>

</tr>

<%
}
%>

</tbody>

</table>

</div>

<br>

<a href="report.jsp"
class="btn btn-info">

Back Reports

</a>

</div>

<script>

document
.getElementById("searchInput")
.addEventListener("keyup",
function(){

let value =
this.value.toLowerCase();

let rows =
document.querySelectorAll(
"#participantTable tbody tr");

rows.forEach(function(row){

let text =
row.innerText.toLowerCase();

row.style.display =
text.includes(value)
? ""
: "none";

});

});

</script>

</body>
</html>