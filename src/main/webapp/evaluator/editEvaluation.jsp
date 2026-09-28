<%@ page import="com.mockevaluation.dao.EvaluationDAO"%>
<%@ page import="com.mockevaluation.model.Evaluation"%>

<%
long id =
Long.parseLong(
request.getParameter("id"));

EvaluationDAO dao =
new EvaluationDAO();

Evaluation e =
dao.getEvaluationById(id);
%>

<!DOCTYPE html>

<html>
<head>

<meta charset="UTF-8">

<title>Edit Evaluation</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>

body{
    background:#0f172a;
    font-family:'Segoe UI',sans-serif;
    color:white;
}

.edit-container{
    max-width:700px;
    margin:60px auto;
}

.card-custom{
    background:#1e293b;
    padding:35px;
    border-radius:20px;
    box-shadow:0 10px 25px rgba(0,0,0,0.4);
}

.page-title{
    text-align:center;
    color:#38bdf8;
    margin-bottom:30px;
    font-weight:600;
}

.form-label{
    color:#cbd5e1;
    font-weight:500;
}

.form-control{
    background:#334155;
    border:none;
    color:white;
}

.form-control:focus{
    background:#475569;
    color:white;
    border:1px solid #38bdf8;
    box-shadow:none;
}

.btn-update{
    background:#10b981;
    border:none;
    width:100%;
    padding:12px;
    font-size:16px;
    font-weight:600;
}

.btn-update:hover{
    background:#059669;
}

.btn-back{
    margin-top:15px;
    width:100%;
}

</style>

</head>

<body>

<div class="edit-container">

<div class="card-custom">

<h2 class="page-title">

<i class="bi bi-pencil-square"></i>

Edit Evaluation

</h2>

<form action="../updateEvaluation"
method="post">

<input type="hidden"
name="evaluationId"
value="<%=e.getEvaluationId()%>">

<div class="mb-3">

<label class="form-label">

Score

</label>

<input type="number"
name="score"
value="<%=e.getScore()%>"
class="form-control"
required>

</div>

<div class="mb-3">

<label class="form-label">

Feedback

</label>

<textarea
name="feedback"
rows="5"
class="form-control"
required><%=e.getFeedback()%></textarea>

</div>

<button type="submit"
class="btn btn-update">

<i class="bi bi-check-circle-fill"></i>

Update Evaluation

</button>

<a href="evaluationHistory.jsp"
class="btn btn-warning btn-back">

<i class="bi bi-arrow-left"></i>

Back to History

</a>

</form>

</div>

</div>

</body>
</html>
