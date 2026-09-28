<%@ page import="com.mockevaluation.dao.TechnologyDAO"%>
<%@ page import="com.mockevaluation.model.Technology"%>

<%
long id =
Long.parseLong(
request.getParameter("id"));

TechnologyDAO dao =
new TechnologyDAO();

Technology t =
dao.getTechnologyById(id);
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Edit Technology</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body class="container mt-5">

<h2>Edit Technology</h2>

<form action="../updateTechnology"
method="post">

<input type="hidden"
name="technologyId"
value="<%= t.getTechnologyId() %>">

<div class="mb-3">

<label>Technology Name</label>

<input type="text"
name="technologyName"
class="form-control"
value="<%= t.getTechnologyName() %>"
required>

</div>

<div class="mb-3">

<label>Description</label>

<textarea
name="description"
class="form-control"
rows="4"><%= t.getDescription() %></textarea>

</div>

<button type="submit"
class="btn btn-success">

Update Technology

</button>

<a href="technology.jsp"
class="btn btn-secondary">

Cancel

</a>

</form>

</body>
</html>