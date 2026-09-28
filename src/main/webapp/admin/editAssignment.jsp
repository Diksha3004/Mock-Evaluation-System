<%@ page import="java.util.ArrayList"%>
<%@ page import="com.mockevaluation.dao.AssignmentDAO"%>
<%@ page import="com.mockevaluation.dao.UserDAO"%>
<%@ page import="com.mockevaluation.dao.RoundDAO"%>
<%@ page import="com.mockevaluation.model.Assignment"%>
<%@ page import="com.mockevaluation.model.User"%>
<%@ page import="com.mockevaluation.model.Round"%>

<%
long id =
Long.parseLong(
request.getParameter("id"));

AssignmentDAO assignmentDAO =
new AssignmentDAO();

UserDAO userDAO =
new UserDAO();

RoundDAO roundDAO =
new RoundDAO();

Assignment a =
assignmentDAO.getAssignmentById(id);

ArrayList<User> users =
userDAO.getAllUsers();

ArrayList<Round> rounds =
roundDAO.getAllRounds();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Edit Assignment</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
rel="stylesheet">

</head>

<body class="container mt-5">

<h2>Edit Assignment</h2>

<form action="../updateAssignment"
method="post">

<input type="hidden"
name="assignmentId"
value="<%= a.getAssignmentId() %>">

<div class="mb-3">

<label>Evaluator</label>

<select
name="evaluatorId"
class="form-control">

<%
for(User u : users){

if("EVALUATOR".equals(
u.getRole())){
%>

<option
value="<%= u.getUserId() %>"

<%= a.getEvaluatorId()==u.getUserId()
?"selected":""
%>>

<%= u.getFullName() %>

</option>

<%
}
}
%>

</select>

</div>

<div class="mb-3">

<label>Round</label>

<select
name="roundId"
class="form-control">

<%
for(Round r : rounds){
%>

<option
value="<%= r.getRoundId() %>"

<%= a.getRoundId()==r.getRoundId()
?"selected":""
%>>

<%= r.getRoundName() %>

</option>

<%
}
%>

</select>

</div>

<button type="submit"
class="btn btn-success">

Update Assignment

</button>

<a href="assignment.jsp"
class="btn btn-secondary">

Cancel

</a>

</form>

</body>
</html>