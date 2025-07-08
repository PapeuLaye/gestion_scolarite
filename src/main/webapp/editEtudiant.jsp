<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.gestion_scolarite.model.Etudiant" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${etudiant == null ? 'Ajouter un Étudiant' : 'Modifier un Étudiant'} - Système Scolaire</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #64748b;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --info-color: #06b6d4;
            --dark-color: #1e293b;
            --light-color: #f8fafc;
            --border-color: #e2e8f0;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }

        .page-container {
            min-height: 100vh;
            padding: 2rem 1rem;
        }

        .page-header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .page-title {
            color: var(--dark-color);
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            background: linear-gradient(135deg, var(--primary-color), #8b5cf6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .breadcrumb-nav {
            background: rgba(255, 255, 255, 0.7);
            border-radius: 50px;
            padding: 0.75rem 1.5rem;
            margin-bottom: 0;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .breadcrumb-nav .breadcrumb-item a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .breadcrumb-nav .breadcrumb-item.active {
            color: var(--secondary-color);
        }

        .form-container {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 3rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            max-width: 800px;
            margin: 0 auto;
        }

        .form-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .form-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), #8b5cf6);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2rem;
            color: white;
            box-shadow: 0 10px 25px rgba(37, 99, 235, 0.3);
        }

        .form-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--dark-color);
            margin-bottom: 0.5rem;
        }

        .form-subtitle {
            color: var(--secondary-color);
            font-size: 1.1rem;
        }

        .form-group {
            margin-bottom: 2rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.75rem;
            font-weight: 600;
            color: var(--dark-color);
            font-size: 1rem;
        }

        .form-label i {
            margin-right: 0.5rem;
            color: var(--primary-color);
            width: 20px;
        }

        .form-control {
            width: 100%;
            padding: 1rem 1.25rem;
            border: 2px solid var(--border-color);
            border-radius: 15px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.9);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            background: white;
        }

        .form-control:invalid {
            border-color: var(--danger-color);
        }

        .form-control:valid {
            border-color: var(--success-color);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 3rem;
            flex-wrap: wrap;
        }

        .btn {
            padding: 1rem 2.5rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            min-width: 160px;
            justify-content: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), #3b82f6);
            color: white;
            box-shadow: 0 5px 15px rgba(37, 99, 235, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(37, 99, 235, 0.4);
            color: white;
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.9);
            color: var(--secondary-color);
            border: 2px solid var(--border-color);
        }

        .btn-secondary:hover {
            background: var(--secondary-color);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(100, 116, 139, 0.3);
        }

        .input-group {
            position: relative;
        }

        .input-group .form-control {
            padding-left: 3rem;
        }

        .input-group-icon {
            position: absolute;
            left: 1.25rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--secondary-color);
            font-size: 1.1rem;
            z-index: 10;
        }

        .validation-message {
            margin-top: 0.5rem;
            font-size: 0.85rem;
            color: var(--danger-color);
            display: none;
        }

        .form-control:invalid + .validation-message {
            display: block;
        }

        .success-message {
            background: linear-gradient(135deg, var(--success-color), #059669);
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            display: none;
        }

        .back-btn {
            position: absolute;
            top: 2rem;
            left: 2rem;
            background: rgba(255, 255, 255, 0.9);
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .back-btn:hover {
            background: var(--primary-color);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(37, 99, 235, 0.3);
        }

        @media (max-width: 768px) {
            .page-container {
                padding: 1rem;
            }

            .form-container {
                padding: 2rem 1.5rem;
            }

            .page-title {
                font-size: 2rem;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .form-actions {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                min-width: 200px;
            }

            .back-btn {
                position: relative;
                top: 0;
                left: 0;
                margin-bottom: 1rem;
            }
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-container {
            animation: fadeInUp 0.6s ease forwards;
        }

        .form-group {
            animation: fadeInUp 0.4s ease forwards;
        }

        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
        .form-group:nth-child(3) { animation-delay: 0.3s; }
        .form-group:nth-child(4) { animation-delay: 0.4s; }
        .form-group:nth-child(5) { animation-delay: 0.5s; }
        .form-group:nth-child(6) { animation-delay: 0.6s; }

        /* Effet de focus progressif */
        .form-control:focus {
            animation: focusGlow 0.3s ease;
        }

        @keyframes focusGlow {
            0% { box-shadow: 0 0 0 0 rgba(37, 99, 235, 0.1); }
            100% { box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1); }
        }
    </style>
</head>
<body>
<div class="page-container">
    <!-- Bouton de retour -->
    <a href="etudiants" class="back-btn">
        <i class="fas fa-arrow-left"></i>
        Retour à la liste
    </a>

    <!-- En-tête de la page -->
    <div class="page-header">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb breadcrumb-nav">
                <li class="breadcrumb-item">
                    <a href="dashboard_admin.jsp">
                        <i class="fas fa-tachometer-alt me-1"></i>
                        Dashboard
                    </a>
                </li>
                <li class="breadcrumb-item">
                    <a href="etudiants">
                        <i class="fas fa-user-graduate me-1"></i>
                        Étudiants
                    </a>
                </li>
                <li class="breadcrumb-item active">
                    <i class="fas fa-edit me-1"></i>
                    ${etudiant == null ? 'Ajouter' : 'Modifier'}
                </li>
            </ol>
        </nav>
        <h1 class="page-title">
            <i class="fas fa-user-graduate me-3"></i>
            ${etudiant == null ? 'Ajouter un Étudiant' : 'Modifier un Étudiant'}
        </h1>
    </div>

    <!-- Formulaire -->
    <div class="form-container">
        <div class="form-header">
            <div class="form-icon">
                <i class="fas fa-${etudiant == null ? 'user-plus' : 'user-edit'}"></i>
            </div>
            <h2 class="form-title">
                ${etudiant == null ? 'Nouveau Étudiant' : 'Modifier les Informations'}
            </h2>
            <p class="form-subtitle">
                ${etudiant == null ? 'Ajoutez un nouvel étudiant au système' : 'Modifiez les informations de l\'étudiant'}
            </p>
        </div>

        <div class="success-message" id="successMessage">
            <i class="fas fa-check-circle me-2"></i>
            Étudiant ${etudiant == null ? 'ajouté' : 'modifié'} avec succès !
        </div>

        <form action="etudiants" method="post" id="studentForm" novalidate>
            <input type="hidden" name="action" value="save"/>
            <input type="hidden" name="id" value="${etudiant != null ? etudiant.id : ''}"/>

            <!-- Ligne 1: Nom et Prénom -->
            <div class="form-row">
                <div class="form-group">
                    <label for="nom" class="form-label">
                        <i class="fas fa-user"></i>
                        Nom *
                    </label>
                    <div class="input-group">
                        <i class="fas fa-user input-group-icon"></i>
                        <input type="text"
                               id="nom"
                               name="nom"
                               class="form-control"
                               value="${etudiant != null ? etudiant.nom : ''}"
                               required
                               minlength="2"
                               placeholder="Entrez le nom de famille"/>
                        <div class="validation-message">
                            Le nom doit contenir au moins 2 caractères.
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="prenom" class="form-label">
                        <i class="fas fa-user"></i>
                        Prénom *
                    </label>
                    <div class="input-group">
                        <i class="fas fa-user input-group-icon"></i>
                        <input type="text"
                               id="prenom"
                               name="prenom"
                               class="form-control"
                               value="${etudiant != null ? etudiant.prenom : ''}"
                               required
                               minlength="2"
                               placeholder="Entrez le prénom"/>
                        <div class="validation-message">
                            Le prénom doit contenir au moins 2 caractères.
                        </div>
                    </div>
                </div>
            </div>

            <!-- Ligne 2: Classe et Email -->
            <div class="form-row">
                <div class="form-group">
                    <label for="classe" class="form-label">
                        <i class="fas fa-graduation-cap"></i>
                        Classe *
                    </label>
                    <div class="input-group">
                        <i class="fas fa-graduation-cap input-group-icon"></i>
                        <input type="text"
                               id="classe"
                               name="classe"
                               class="form-control"
                               value="${etudiant != null ? etudiant.classe : ''}"
                               required
                               placeholder="Ex: 6ème A, Terminal S"/>
                        <div class="validation-message">
                            Veuillez indiquer la classe.
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="email" class="form-label">
                        <i class="fas fa-envelope"></i>
                        Email *
                    </label>
                    <div class="input-group">
                        <i class="fas fa-envelope input-group-icon"></i>
                        <input type="email"
                               id="email"
                               name="email"
                               class="form-control"
                               value="${etudiant != null ? etudiant.email : ''}"
                               required
                               placeholder="exemple@email.com"/>
                        <div class="validation-message">
                            Veuillez entrer une adresse email valide.
                        </div>
                    </div>
                </div>
            </div>

            <!-- Ligne 3: Matricule et Date de naissance -->
            <div class="form-row">
                <div class="form-group">
                    <label for="matricule" class="form-label">
                        <i class="fas fa-id-card"></i>
                        Matricule *
                    </label>
                    <div class="input-group">
                        <i class="fas fa-id-card input-group-icon"></i>
                        <input type="text"
                               id="matricule"
                               name="matricule"
                               class="form-control"
                               value="${etudiant != null ? etudiant.matricule : ''}"
                               required
                               pattern="[A-Z0-9]{6,10}"
                               placeholder="Ex: ETU2024001"/>
                        <div class="validation-message">
                            Le matricule doit contenir 6 à 10 caractères alphanumériques.
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="dateNaissance" class="form-label">
                        <i class="fas fa-calendar"></i>
                        Date de Naissance *
                    </label>
                    <div class="input-group">
                        <i class="fas fa-calendar input-group-icon"></i>
                        <input type="date"
                               id="dateNaissance"
                               name="dateNaissance"
                               class="form-control"
                               value="${etudiant != null ? etudiant.dateNaissance : ''}"
                               required
                               max="2010-12-31"/>
                        <div class="validation-message">
                            Veuillez sélectionner une date de naissance valide.
                        </div>
                    </div>
                </div>
            </div>

            <!-- Actions -->
            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i>
                    ${etudiant == null ? 'Ajouter l\'étudiant' : 'Enregistrer les modifications'}
                </button>
                <a href="etudiants" class="btn btn-secondary">
                    <i class="fas fa-times"></i>
                    Annuler
                </a>
            </div>
        </form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Validation du formulaire
    document.getElementById('studentForm').addEventListener('submit', function(e) {
        const form = this;
        const inputs = form.querySelectorAll('input[required]');
        let isValid = true;

        inputs.forEach(input => {
            if (!input.checkValidity()) {
                isValid = false;
                input.classList.add('is-invalid');
            } else {
                input.classList.remove('is-invalid');
            }
        });

        if (!isValid) {
            e.preventDefault();
            // Scroll vers le premier champ invalide
            const firstInvalid = form.querySelector('.is-invalid');
            if (firstInvalid) {
                firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
                firstInvalid.focus();
            }
        }
    });

    // Validation en temps réel
    document.querySelectorAll('input').forEach(input => {
        input.addEventListener('input', function() {
            if (this.checkValidity()) {
                this.classList.remove('is-invalid');
                this.classList.add('is-valid');
            } else {
                this.classList.remove('is-valid');
                this.classList.add('is-invalid');
            }
        });
    });

    // Génération automatique du matricule
    document.getElementById('nom').addEventListener('input', generateMatricule);
    document.getElementById('prenom').addEventListener('input', generateMatricule);

    function generateMatricule() {
        const nom = document.getElementById('nom').value.trim();
        const prenom = document.getElementById('prenom').value.trim();
        const matriculeField = document.getElementById('matricule');

        if (nom && prenom && !matriculeField.value) {
            const year = new Date().getFullYear();
            const initials = (nom.charAt(0) + prenom.charAt(0)).toUpperCase();
            const randomNum = Math.floor(Math.random() * 1000).toString().padStart(3, '0');
            matriculeField.value = `ETU${year}${initials}${randomNum}`;
        }
    }

    // Animation d'entrée
    document.addEventListener('DOMContentLoaded', function() {
        const formGroups = document.querySelectorAll('.form-group');
        formGroups.forEach((group, index) => {
            setTimeout(() => {
                group.style.opacity = '1';
                group.style.transform = 'translateY(0)';
            }, index * 100);
        });
    });

    // Confirmation avant annulation si des données sont saisies
    document.querySelector('.btn-secondary').addEventListener('click', function(e) {
        const form = document.getElementById('studentForm');
        const formData = new FormData(form);
        let hasData = false;

        for (let [key, value] of formData.entries()) {
            if (key !== 'action' && key !== 'id' && value.trim()) {
                hasData = true;
                break;
            }
        }

        if (hasData) {
            if (!confirm('⚠️ Vous avez des données non sauvegardées.\nÊtes-vous sûr de vouloir annuler ?')) {
                e.preventDefault();
            }
        }
    });
</script>
</body>
</html>