<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.gestion_scolarite.model.Note" %>
<%
  Note note = (Note) request.getAttribute("note");
%>
<html>
<head>
  <title>Modifier une note</title>
</head>
<body>
<h1>Modifier la note de l’étudiant #<%= note.getIdEtudiant() %></h1>

<form method="post" action="notes">
  <input type="hidden" name="action" value="update"/>
  <input type="hidden" name="id" value="<%= note.getId() %>"/>
  <input type="hidden" name="idEtudiant" value="<%= note.getIdEtudiant() %>"/>

  <label for="idMatiere">ID de la Matière :</label>
  <input type="number" name="idMatiere" value="<%= note.getIdMatiere() %>" required/><br/><br/>

  <label for="note">Note :</label>
  <input type="number" name="note" step="0.01" value="<%= note.getNote() %>" required/><br/><br/>

  <button type="submit">Mettre à jour</button>
</form>

<br>
<a href="notes?action=list&id=<%= note.getIdEtudiant() %>">Retour à la liste des notes</a>
</body>
</html>
