<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gestion_scolarite.model.Matiere" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Matières</title>
</head>
<body>
<h1>Liste des Matières</h1>

<table border="1">
    <thead>
    <tr>
        <th>Nom</th>
        <th>Code</th>
        <th>Coefficient</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Matiere> matieres = (List<Matiere>) request.getAttribute("matieres");
        if (matieres != null && !matieres.isEmpty()) {
            for (Matiere matiere : matieres) {
    %>
    <tr>
        <td><%= matiere.getNom() %></td>
        <td><%= matiere.getCode() %></td>
        <td><%= matiere.getCoefficient() %></td>
        <td>
            <a href="matieres?action=edit&id=<%= matiere.getId() %>">Modifier</a> |
            <a href="matieres?action=delete&id=<%= matiere.getId() %>"
               onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette matière ?');">Supprimer</a>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="4">Aucune matière enregistrée.</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

<br>
<a href="editMatiere.jsp">Ajouter une Matière</a>
</body>
</html>
