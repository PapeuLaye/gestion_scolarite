<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gestion_scolarite.model.Enseignant" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion des Enseignants</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid black;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .actions a {
            margin-right: 10px;
        }
    </style>
</head>
<body>
<h1>Liste des Enseignants</h1>

<table>
    <thead>
    <tr>
        <th>Nom</th>
        <th>Prénom</th>
        <th>Email</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Enseignant> enseignants = (List<Enseignant>) request.getAttribute("enseignants");
        if (enseignants != null && !enseignants.isEmpty()) {
            for (Enseignant enseignant : enseignants) {
    %>
    <tr>
        <td><%= enseignant.getNom() %>
        </td>
        <td><%= enseignant.getPrenom() %>
        </td>
        <td><%= enseignant.getEmail() %>
        </td>
        <td class="actions">
            <a href="enseignants?action=edit&id=<%= enseignant.getId() %>">Modifier</a> |
            <a href="enseignants?action=delete&id=<%= enseignant.getId() %>"
               onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet enseignant ?');">Supprimer</a>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="4" style="text-align: center;">Aucun enseignant trouvé.</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

<br>
<a href="editEnseignant.jsp">Ajouter un enseignant</a>
</body>
</html>
