<%@ page import="com.mockevaluation.dao.BatchDAO"%>
<%@ page import="com.mockevaluation.model.Batch"%>

<%
long id =
Long.parseLong(
request.getParameter("id"));

BatchDAO dao =
new BatchDAO();

Batch b =
dao.getBatchById(id);
%>

<!DOCTYPE html>
<html>
<head>

<title>Edit Batch</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body>

<div class="container mt-5">

<h2>Edit Batch</h2>

<form action="../updateBatch"
method="post">

<input type="hidden"
name="batchId"
value="<%= b.getBatchId() %>">

<div class="mb-3">

<label>Batch Name</label>

<input type="text"
name="batchName"
value="<%= b.getBatchName() %>"
class="form-control">

</div>

<div class="mb-3">

<label>Start Date</label>

<input type="date"
name="startDate"
value="<%= b.getStartDate() %>"
class="form-control">

</div>

<div class="mb-3">

<label>End Date</label>

<input type="date"
name="endDate"
value="<%= b.getEndDate() %>"
class="form-control">

</div>

<button type="submit"
class="btn btn-success">

Update Batch

</button>

</form>

</div>

</body>
</html>