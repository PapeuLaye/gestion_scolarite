<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="com.gestion_scolarite.model.Note" %>
<%@ page import="com.gestion_scolarite.model.Matiere" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
  Note note = (Note) request.getAttribute("note");
  List<Matiere> matieres = (List<Matiere>) request.getAttribute("matieres");
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Modifier une note</title>
</head>
<body>

<h1>Modifier la note de l’étudiant #<%= note.getIdEtudiant() %></h1>

<form method="post" action="notes">
  <input type="hidden" name="action" value="update"/>
  <input type="hidden" name="id" value="<%= note.getId() %>"/>
  <input type="hidden" name="idEtudiant" value="<%= note.getIdEtudiant() %>"/>

  <select name="idMatiere" required>
    <c:forEach var="matiere" items="${matieres}">
      <option value="${matiere.id}"
        ${matiere.id == note.idMatiere ? 'selected' : ''}>
          ${matiere.nom} (${matiere.code})
      </option>
    </c:forEach>
  </select>

  <label for="note">Note :</label>
  <input type="number" name="note" step="0.01" value="<%= note.getNote() %>" required/><br/><br/>

  <button type="submit">Mettre à jour</button>
</form>

<br>
<a href="notes?action=list&id=<%= note.getIdEtudiant() %>">Retour à la liste des notes</a>
</body>
</html>
