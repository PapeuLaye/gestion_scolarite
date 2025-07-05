<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gestion_scolarite.model.Matiere" %>

<html>
<head>
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
        if (matieres != null) {
            for (Matiere matiere : matieres) {
    %>
    <tr>
        <td><%= matiere.getNom() %></td>
        <td><%= matiere.getCode() %></td>
        <td><%= matiere.getCoefficient() %></td>
        <td>
            <a href="matieres?action=edit&id=<%= matiere.getId() %>">Modifier</a> |
            <a href="matieres?action=delete&id=<%= matiere.getId() %>" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet matière ?');">Supprimer</a>
        </td>
    </tr>
    <%
            }
        }
    %>
    </tbody>
</table>
<a href="editMatiere.jsp">Ajouter une Matière</a>
</body>
</html>
