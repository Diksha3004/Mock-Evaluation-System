<%@ page import="java.util.ArrayList"%>
<%@ page import="com.mockevaluation.dao.RoundDAO"%>
<%@ page import="com.mockevaluation.dao.TechnologyDAO"%>
<%@ page import="com.mockevaluation.model.Round"%>
<%@ page import="com.mockevaluation.model.Technology"%>

<%
long id =
Long.parseLong(
request.getParameter("id"));

RoundDAO roundDAO =
new RoundDAO();

TechnologyDAO techDAO =
new TechnologyDAO();

Round r =
roundDAO.getRoundById(id);

ArrayList<Technology> techList =
techDAO.getAllTechnologies();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Edit Round</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body class="container mt-5">

<h2>Edit Evaluation Round</h2>

<form action="../updateRound"
method="post">

<input type="hidden"
name="roundId"
value="<%= r.getRoundId() %>">

<div class="mb-3">

<label>Round Name</label>

<input type="text"
name="roundName"
class="form-control"
value="<%= r.getRoundName() %>"
required>

</div>

<div class="mb-3">

<label>Technology</label>

<select
name="technologyId"
class="form-control">

<%
for(Technology t : techList){
%>

<option
value="<%= t.getTechnologyId() %>"

<%= r.getTechnologyId()==t.getTechnologyId()
?"selected":""
%>>

<%= t.getTechnologyName() %>

</option>

<%
}
%>

</select>

</div>

<button type="submit"
class="btn btn-success">

Update Round

</button>

<a href="round.jsp"
class="btn btn-secondary">

Cancel

</a>

</form>

</body>
</html>