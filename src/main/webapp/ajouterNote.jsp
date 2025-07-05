<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Ajouter une note</title>
</head>
<body>
<h1>Ajouter une note pour l’étudiant #${param.idEtudiant}</h1>

<form method="post" action="notes">
    <input type="hidden" name="action" value="save"/>
    <input type="hidden" name="idEtudiant" value="${param.idEtudiant}"/>

    <label for="idMatiere">ID de la Matière :</label>
    <input type="number" name="idMatiere" required/><br/><br/>

    <label for="note">Note :</label>
    <input type="number" name="note" step="0.01" required/><br/><br/>

    <button type="submit">Enregistrer</button>
</form>

<br>
<a href="notes?action=list&id=${param.idEtudiant}">Retour à la liste des notes</a>
</body>
</html>
