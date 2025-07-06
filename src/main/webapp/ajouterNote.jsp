<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Ajouter une note</title>
</head>
<body>
<h1>Ajouter une note pour l’étudiant #${etudiantId}</h1>

<form method="post" action="notes">
    <input type="hidden" name="action" value="save"/>
    <input type="hidden" name="idEtudiant" value="${etudiantId}"/>

    <label for="idMatiere">Matière :</label>
    <select name="idMatiere" required>
        <c:forEach var="matiere" items="${matieres}">
            <option value="${matiere.id}">${matiere.nom} (${matiere.code})</option>
        </c:forEach>
    </select><br/><br/>

    <label for="note">Note :</label>
    <input type="number" name="note" step="0.01" required/><br/><br/>

    <button type="submit">Enregistrer</button>
</form>

<br>
<a href="notes?action=list&id=${etudiantId}">Retour à la liste des notes</a>
</body>
</html>
