<%@ page import="java.util.List" %>
<%@ page import="com.gestion_scolarite.model.Absence" %>

<html>
<head>
    <title>Gestion des Absences</title>
</head>
<body>
<h1>Liste des Absences</h1>
<table border="1">
    <thead>
    <tr>
        <th>Matière</th>
        <th>Date d'absence</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="absence" items="${absences}">
        <tr>
            <td>${absence.matiere.nom}</td>
            <td>${absence.dateAbsence}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
