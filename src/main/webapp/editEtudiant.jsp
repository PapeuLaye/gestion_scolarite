<%@ page import="com.gestion_scolarite.model.Etudiant" %>
<html>
<head>
    <title>Ajouter / Modifier Étudiant</title>
</head>
<body>
<h1>${etudiant == null ? 'Ajouter un Étudiant' : 'Modifier un Étudiant'}</h1>

<form action="etudiants" method="post">
    <input type="hidden" name="action" value="save"/>
    <input type="hidden" name="id" value="${etudiant != null ? etudiant.id : ''}"/>

    <label for="nom">Nom</label>
    <input type="text" name="nom" value="${etudiant != null ? etudiant.nom : ''}" required/><br/>

    <label for="prenom">Prénom</label>
    <input type="text" name="prenom" value="${etudiant != null ? etudiant.prenom : ''}" required/><br/>

    <label for="classe">Classe</label>
    <input type="text" name="classe" value="${etudiant != null ? etudiant.classe : ''}" required/><br/>

    <label for="email">Email</label>
    <input type="email" name="email" value="${etudiant != null ? etudiant.email : ''}" required/><br/>

    <label for="matricule">Matricule</label>
    <input type="text" name="matricule" value="${etudiant != null ? etudiant.matricule : ''}" required/><br/>

    <label for="dateNaissance">Date de Naissance</label>
    <input type="date" name="dateNaissance" value="${etudiant != null ? etudiant.dateNaissance : ''}" required/><br/>

    <input type="submit" value="${etudiant == null ? 'Ajouter' : 'Modifier'}"/>
</form>
</body>
</html>
