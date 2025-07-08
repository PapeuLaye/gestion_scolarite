<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.gestion_scolarite.model.Enseignant" %>
<html>
<head>
  <title>Ajouter / Modifier Enseignant</title>
</head>
<body>
<h1>${enseignant == null ? 'Ajouter un Enseignant' : 'Modifier un Enseignant'}</h1>
<form action="enseignants" method="post">
  <input type="hidden" name="action" value="save"/>
  <input type="hidden" name="id" value="${enseignant != null ? enseignant.id : ''}"/>

  <label for="nom">Nom</label>
  <input type="text" name="nom" value="${enseignant != null ? enseignant.nom : ''}"/><br/>

  <label for="prenom">Prénom</label>
  <input type="text" name="prenom" value="${enseignant != null ? enseignant.prenom : ''}"/><br/>

  <label for="email">Email</label>
  <input type="text" name="email" value="${enseignant != null ? enseignant.email : ''}"/><br/>

  <input type="submit" value="${enseignant == null ? 'Ajouter' : 'Modifier'}"/>
</form>
</body>
</html>
