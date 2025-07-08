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
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Modifier une note</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      min-height: 100vh;
      padding: 20px;
      position: relative;
    }

    .container {
      max-width: 600px;
      margin: 0 auto;
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      border-radius: 20px;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
      padding: 40px;
      animation: slideIn 0.6s ease-out;
    }

    @keyframes slideIn {
      from {
        opacity: 0;
        transform: translateY(-30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .page-header {
      text-align: center;
      margin-bottom: 30px;
      position: relative;
    }

    .page-header h1 {
      color: #333;
      font-size: 2rem;
      font-weight: 600;
      margin-bottom: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
    }

    .page-header h1::before {
      content: "✏️";
      font-size: 1.5rem;
    }

    .student-badge {
      background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
      color: white;
      padding: 8px 16px;
      border-radius: 20px;
      font-size: 0.9rem;
      font-weight: 500;
      display: inline-block;
      margin-top: 10px;
    }

    .form-container {
      background: #f8f9fa;
      border-radius: 15px;
      padding: 30px;
      margin-bottom: 30px;
      border: 1px solid #e9ecef;
    }

    .current-note-info {
      background: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
      color: white;
      padding: 20px;
      border-radius: 12px;
      margin-bottom: 25px;
      text-align: center;
      animation: pulse 2s infinite;
    }

    @keyframes pulse {
      0%, 100% { transform: scale(1); }
      50% { transform: scale(1.02); }
    }

    .current-note-info h3 {
      font-size: 1.2rem;
      margin-bottom: 10px;
    }

    .current-note-value {
      font-size: 2rem;
      font-weight: bold;
      margin: 10px 0;
    }

    .form-group {
      margin-bottom: 25px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      color: #555;
      font-weight: 600;
      font-size: 1rem;
    }

    .form-group select,
    .form-group input {
      width: 100%;
      padding: 15px 20px;
      border: 2px solid #e1e5e9;
      border-radius: 12px;
      font-size: 1rem;
      transition: all 0.3s ease;
      background: white;
    }

    .form-group select:focus,
    .form-group input:focus {
      outline: none;
      border-color: #f39c12;
      box-shadow: 0 0 0 3px rgba(243, 156, 18, 0.1);
    }

    .form-group select {
      cursor: pointer;
    }

    .form-group input[type="number"] {
      text-align: center;
      font-size: 1.2rem;
      font-weight: 600;
    }

    .update-btn {
      width: 100%;
      padding: 15px;
      background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
      color: white;
      border: none;
      border-radius: 12px;
      font-size: 1.1rem;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
    }

    .update-btn::before {
      content: "🔄";
      font-size: 1rem;
    }

    .update-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 20px rgba(243, 156, 18, 0.3);
    }

    .update-btn:active {
      transform: translateY(0);
    }

    .back-link {
      display: inline-flex;
      align-items: center;
      gap: 10px;
      color: #667eea;
      text-decoration: none;
      font-weight: 500;
      padding: 12px 20px;
      border: 2px solid #667eea;
      border-radius: 10px;
      transition: all 0.3s ease;
    }

    .back-link::before {
      content: "←";
      font-size: 1.2rem;
    }

    .back-link:hover {
      background: #667eea;
      color: white;
      transform: translateX(-5px);
    }

    .decorative-elements {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      overflow: hidden;
      pointer-events: none;
    }

    .circle {
      position: absolute;
      border-radius: 50%;
      background: rgba(255, 255, 255, 0.1);
      animation: float 6s ease-in-out infinite;
    }

    .circle:nth-child(1) {
      width: 100px;
      height: 100px;
      top: 15%;
      left: 5%;
      animation-delay: 0s;
    }

    .circle:nth-child(2) {
      width: 150px;
      height: 150px;
      top: 70%;
      right: 5%;
      animation-delay: 2s;
    }

    .circle:nth-child(3) {
      width: 80px;
      height: 80px;
      bottom: 15%;
      left: 15%;
      animation-delay: 4s;
    }

    @keyframes float {
      0%, 100% { transform: translateY(0px); }
      50% { transform: translateY(-20px); }
    }

    .form-info {
      background: #fff3cd;
      border-left: 4px solid #f39c12;
      padding: 15px;
      margin-bottom: 25px;
      border-radius: 0 8px 8px 0;
      color: #856404;
    }

    .form-info::before {
      content: "⚠️";
      margin-right: 10px;
    }

    .comparison-container {
      display: flex;
      gap: 20px;
      margin-bottom: 25px;
    }

    .comparison-box {
      flex: 1;
      padding: 15px;
      border-radius: 10px;
      text-align: center;
    }

    .old-note {
      background: #f8d7da;
      border: 1px solid #f5c6cb;
      color: #721c24;
    }

    .new-note {
      background: #d4edda;
      border: 1px solid #c3e6cb;
      color: #155724;
    }

    @media (max-width: 768px) {
      .container {
        padding: 25px 20px;
      }

      .page-header h1 {
        font-size: 1.5rem;
      }

      .form-container {
        padding: 20px;
      }

      .comparison-container {
        flex-direction: column;
        gap: 10px;
      }
    }

    .form-group {
      animation: fadeInUp 0.6s ease-out;
    }

    .form-group:nth-child(1) { animation-delay: 0.1s; }
    .form-group:nth-child(2) { animation-delay: 0.2s; }
    .form-group:nth-child(3) { animation-delay: 0.3s; }

    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .note-indicator {
      position: absolute;
      right: 20px;
      top: 50%;
      transform: translateY(-50%);
      font-size: 1.5rem;
      color: #f39c12;
      opacity: 0;
      transition: opacity 0.3s ease;
    }

    .note-input-wrapper {
      position: relative;
    }

    .form-group input[type="number"]:focus + .note-indicator {
      opacity: 1;
    }

    .change-preview {
      background: #e9ecef;
      border-radius: 10px;
      padding: 15px;
      margin-top: 15px;
      text-align: center;
      font-weight: 500;
      color: #495057;
      opacity: 0;
      transition: opacity 0.3s ease;
    }

    .change-preview.visible {
      opacity: 1;
    }
  </style>
</head>
<body>
<div class="decorative-elements">
  <div class="circle"></div>
  <div class="circle"></div>
  <div class="circle"></div>
</div>

<div class="container">
  <div class="page-header">
    <h1>Modifier la note</h1>
    <div class="student-badge">
      👨‍🎓 Étudiant #<%= note.getIdEtudiant() %>
    </div>
  </div>

  <div class="current-note-info">
    <h3>📊 Note actuelle</h3>
    <div class="current-note-value"><%= note.getNote() %>/20</div>
    <small>Cliquez sur les champs ci-dessous pour modifier</small>
  </div>

  <div class="form-info">
    Modifiez les informations de la note. Les changements seront sauvegardés immédiatement.
  </div>

  <div class="form-container">
    <form method="post" action="notes">
      <input type="hidden" name="action" value="update"/>
      <input type="hidden" name="id" value="<%= note.getId() %>"/>
      <input type="hidden" name="idEtudiant" value="<%= note.getIdEtudiant() %>"/>

      <div class="form-group">
        <label for="idMatiere">📚 Matière</label>
        <select name="idMatiere" id="idMatiere" required>
          <c:forEach var="matiere" items="${matieres}">
            <option value="${matiere.id}"
              ${matiere.id == note.idMatiere ? 'selected' : ''}>
                ${matiere.nom} (${matiere.code})
            </option>
          </c:forEach>
        </select>
      </div>

      <div class="form-group">
        <label for="note">🎯 Nouvelle note (sur 20)</label>
        <div class="note-input-wrapper">
          <input type="number" name="note" id="note" step="0.01" min="0" max="20"
                 value="<%= note.getNote() %>" required/>
          <div class="note-indicator">📊</div>
        </div>
        <div class="change-preview" id="changePreview">
          <!-- Prévisualisation du changement -->
        </div>
      </div>

      <button type="submit" class="update-btn">
        Mettre à jour la note
      </button>
    </form>
  </div>

  <a href="notes?action=list&id=<%= note.getIdEtudiant() %>" class="back-link">
    Retour à la liste des notes
  </a>
</div>

<script>
  const originalNote = <%= note.getNote() %>;
  const noteInput = document.getElementById('note');
  const changePreview = document.getElementById('changePreview');

  // Animation au focus sur l'input note
  noteInput.addEventListener('input', function() {
    const value = parseFloat(this.value);
    const indicator = this.nextElementSibling;

    if (value >= 0 && value <= 20) {
      if (value >= 16) {
        indicator.textContent = '🥇';
      } else if (value >= 14) {
        indicator.textContent = '🥈';
      } else if (value >= 12) {
        indicator.textContent = '🥉';
      } else if (value >= 10) {
        indicator.textContent = '✅';
      } else {
        indicator.textContent = '📊';
      }
    }

    // Prévisualisation du changement
    if (value !== originalNote && !isNaN(value)) {
      const difference = (value - originalNote).toFixed(2);
      const sign = difference > 0 ? '+' : '';
      const emoji = difference > 0 ? '📈' : '📉';

      changePreview.innerHTML = `
                    ${emoji} Changement: ${originalNote} → ${value} (${sign}${difference})
                `;
      changePreview.classList.add('visible');
    } else {
      changePreview.classList.remove('visible');
    }
  });

  // Validation en temps réel
  noteInput.addEventListener('input', function() {
    const value = parseFloat(this.value);

    if (value > 20) {
      this.style.borderColor = '#dc3545';
      this.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
    } else if (value < 0) {
      this.style.borderColor = '#dc3545';
      this.style.boxShadow = '0 0 0 3px rgba(220, 53, 69, 0.1)';
    } else {
      this.style.borderColor = '#f39c12';
      this.style.boxShadow = '0 0 0 3px rgba(243, 156, 18, 0.1)';
    }
  });

  // Confirmation avant soumission si changement important
  document.querySelector('form').addEventListener('submit', function(e) {
    const newNote = parseFloat(noteInput.value);
    const difference = Math.abs(newNote - originalNote);

    if (difference > 5) {
      const confirmMessage = `⚠️ Attention: Vous allez modifier la note de ${originalNote} à ${newNote}.\n\nCela représente un changement important de ${difference.toFixed(2)} points.\n\nÊtes-vous sûr de vouloir continuer?`;

      if (!confirm(confirmMessage)) {
        e.preventDefault();
      }
    }
  });
</script>
</body>
</html>