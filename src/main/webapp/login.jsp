<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Connexion</title>
</head>
<body>
<h2>Connexion</h2>
<form method="post" action="login">
    <label>Email:</label><input type="text" name="email" required><br>
    <label>Mot de passe:</label><input type="password" name="motDePasse" required><br>
    <button type="submit">Se connecter</button>
</form>

<% if (request.getParameter("erreur") != null) { %>
<p style="color:red;">Identifiants incorrects ou rôle inconnu.</p>
<% } %>
</body>
</html>
