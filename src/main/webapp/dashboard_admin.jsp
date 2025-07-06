<%@ page import="com.gestion_scolarite.model.Utilisateur" %>
<%
  Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
  if (utilisateur == null || !"ADMIN".equals(utilisateur.getRole())) {
    response.sendRedirect("login.jsp");
    return;
  }
%>
<html>
<head><title>Tableau de Bord Admin</title></head>
<body>
<h1>Bienvenue, <%= utilisateur.getNom() %> (ADMIN)</h1>

<ul>
  <li><a href="etudiants">Gérer les étudiants</a></li>
  <li><a href="enseignants">Gérer les enseignants</a></li>
  <li><a href="matieres">Gérer les matières</a></li>
  <li><a href="notes">Gérer les notes</a></li>
  <li><a href="logout">Déconnexion</a></li>
</ul>
</body>
</html>
