<%@ page import="com.gestion_scolarite.model.Matiere" %>
<html>
<head>
  <title>Ajouter / Modifier Matière</title>
</head>
<body>
<h1>${matiere == null ? 'Ajouter une Matière' : 'Modifier une Matière'}</h1>
<form action="matieres" method="post">
  <input type="hidden" name="action" value="save"/>
  <input type="hidden" name="id" value="${matiere != null ? matiere.id : ''}"/>

  <label for="nom">Nom</label>
  <input type="text" name="nom" value="${matiere != null ? matiere.nom : ''}"/><br/>

  <label for="code">Code</label>
  <input type="text" name="code" value="${matiere != null ? matiere.code : ''}"/><br/>

  <label for="coefficient">Coefficient</label>
  <input type="number" name="coefficient" value="${matiere != null ? matiere.coefficient : ''}"/><br/>

  <input type="submit" value="${matiere == null ? 'Ajouter' : 'Modifier'}"/>
</form>
</body>
</html>
