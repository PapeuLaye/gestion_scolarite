<%@ page import="java.util.List" %>
<%@ page import="com.gestion_scolarite.model.Note" %>

<html>
<head>
    <title>Gestion des Notes</title>
</head>
<body>
<h1>Liste des Notes de l'Étudiant #${idEtudiant}</h1>

<table border="1">
    <thead>
    <tr>
        <th>Matière</th>
        <th>Note</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Note> notesList = (List<Note>) request.getAttribute("notes");
        if (notesList != null && !notesList.isEmpty()) {
            for (Note note : notesList) {
    %>
    <tr>
        <td><%= note.getNomMatiere() %>
        </td>
        <td><%= note.getNote() %>
        </td>
        <td>
            <a href="notes?action=edit&noteId=<%= note.getId() %>">Modifier</a> |
            <a href="notes?action=delete&id=<%= note.getId() %>&idEtudiant=<%= note.getIdEtudiant() %>"
               onclick="return confirm('Supprimer cette note ?');">
                Supprimer
            </a>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="3" style="text-align:center;">Aucune note disponible.</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>

<p><strong>Moyenne générale :</strong> ${moyenne}</p>

<br>
<a href="notes?action=add&idEtudiant=${idEtudiant}">Ajouter une Note</a>
</body>
</html>
