<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gestion_scolarite.model.Etudiant" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion des Étudiants</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid black; padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        .actions a { margin-right: 10px; }
    </style>
</head>
<body>
<h1>Liste des Étudiants</h1>

<table>
    <thead>
    <tr>
        <th>Nom</th>
        <th>Prénom</th>
        <th>Classe</th>
        <th>Email</th>
        <th>Matricule</th>
        <th>Date de Naissance</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Etudiant> etudiants = (List<Etudiant>) request.getAttribute("etudiants");
        if (etudiants != null && !etudiants.isEmpty()) {
            for (Etudiant etudiant : etudiants) {
    %>
    <tr>
        <td><%= etudiant.getNom() %></td>
        <td><%= etudiant.getPrenom() %></td>
        <td><%= etudiant.getClasse()%></td>
        <td><%= etudiant.getEmail() %></td>
        <td><%= etudiant.getMatricule() %></td>
        <td><%= etudiant.getDateNaissance() %></td>
        <td class="actions">
            <a href="etudiants?action=edit&id=<%= etudiant.getId() %>">Modifier</a> |
            <a href="etudiants?action=delete&id=<%= etudiant.getId() %>" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet étudiant ?');">Supprimer</a>
            <a href="notes?action=list&id=<%= etudiant.getId() %>">Mes Notes</a>

        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="6" style="text-align: center;">Aucun étudiant trouvé.</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

<br>
<a href="editEtudiant.jsp">Ajouter un étudiant</a>
</body>
</html>
