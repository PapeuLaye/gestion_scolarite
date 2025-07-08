package com.gestion_scolarite.dao;

import com.gestion_scolarite.model.Etudiant;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EtudiantDAO {
    private Connection connection;

    // Constructeur pour établir la connexion à la base de données
    public EtudiantDAO() {
        try {
            // Charger le driver JDBC
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Établir la connexion avec la base de données
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestion_scolarite", "root", "");

            System.out.println("✅ Connexion à la base de données réussie !");
        } catch (ClassNotFoundException e) {
            System.err.println("❌ Driver JDBC non trouvé !");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("❌ Erreur de connexion à la base de données !");
            e.printStackTrace();
        }
    }

    // Méthode pour fermer la connexion proprement
    public void fermerConnexion() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("✅ Connexion fermée !");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Vérifie si la connexion est valide avant d'exécuter une requête
    private boolean isConnectionValid() {
        if (this.connection == null) {
            System.err.println("❌ Impossible d'exécuter la requête : connexion non établie !");
            return false;
        }
        return true;
    }

    // Méthode pour ajouter un étudiant
    public int ajouterEtudiant(Etudiant etudiant) {
        if (!isConnectionValid()) return -1;

        String query = "INSERT INTO etudiants (nom, prenom, email, matricule, date_naissance, classe) VALUES (?, ?, ?, ?, ?, ?)";
        int idGenere = -1;

        try (PreparedStatement stmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, etudiant.getNom());
            stmt.setString(2, etudiant.getPrenom());
            stmt.setString(3, etudiant.getEmail());
            stmt.setString(4, etudiant.getMatricule());
            stmt.setString(5, etudiant.getDateNaissance());
            stmt.setString(6, etudiant.getClasse());

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        idGenere = generatedKeys.getInt(1);
                        System.out.println("✅ Étudiant ajouté avec ID = " + idGenere);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return idGenere;
    }


    // Méthode pour récupérer un étudiant par ID
    public Etudiant getEtudiantById(int id) {
        if (!isConnectionValid()) return null;

        String query = "SELECT * FROM etudiants WHERE id = ?";
        Etudiant etudiant = null;
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                etudiant = new Etudiant();
                etudiant.setId(rs.getInt("id"));
                etudiant.setNom(rs.getString("nom"));
                etudiant.setPrenom(rs.getString("prenom"));
                etudiant.setEmail(rs.getString("email"));
                etudiant.setMatricule(rs.getString("matricule"));
                etudiant.setDateNaissance(rs.getString("date_naissance"));
                etudiant.setClasse(rs.getString("classe"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return etudiant;
    }

    public void modifierEtudiant(Etudiant etudiant) {
        try {
            String query = "UPDATE etudiants SET nom = ?, prenom = ?, email = ?, matricule = ?, date_naissance = ?, classe = ? WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, etudiant.getNom());
            preparedStatement.setString(2, etudiant.getPrenom());
            preparedStatement.setString(3, etudiant.getEmail());
            preparedStatement.setString(4, etudiant.getMatricule());
            preparedStatement.setString(5, etudiant.getDateNaissance());
            preparedStatement.setString(6, etudiant.getClasse());
            preparedStatement.setInt(7, etudiant.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    // Méthode pour supprimer un étudiant avec suppression des dépendances
    public void supprimerEtudiant(int id) {
        if (!isConnectionValid()) return;

        try {
            // Étape 1 : Supprimer les notes liées à cet étudiant
            String deleteNotes = "DELETE FROM notes WHERE etudiant_id = ?";
            try (PreparedStatement psNotes = connection.prepareStatement(deleteNotes)) {
                psNotes.setInt(1, id);
                psNotes.executeUpdate();
                System.out.println("🗑️ Notes supprimées pour l'étudiant ID: " + id);
            }

            // Étape 2 : Supprimer le compte utilisateur lié à cet étudiant (optionnel)
            String deleteUser = "DELETE FROM utilisateurs WHERE id = ?";
            try (PreparedStatement psUser = connection.prepareStatement(deleteUser)) {
                psUser.setInt(1, id);
                psUser.executeUpdate();
                System.out.println("🗑️ Utilisateur supprimé pour l'étudiant ID: " + id);
            }

            // Étape 3 : Supprimer l'étudiant
            String deleteEtudiant = "DELETE FROM etudiants WHERE id = ?";
            try (PreparedStatement psEtudiant = connection.prepareStatement(deleteEtudiant)) {
                psEtudiant.setInt(1, id);
                int rowsDeleted = psEtudiant.executeUpdate();
                if (rowsDeleted > 0) {
                    System.out.println("✅ Étudiant supprimé avec succès !");
                } else {
                    System.out.println("⚠️ Aucun étudiant trouvé avec cet ID.");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Méthode pour obtenir tous les étudiants
    public List<Etudiant> getAllEtudiants() {
        if (!isConnectionValid()) return new ArrayList<>();

        List<Etudiant> etudiants = new ArrayList<>();
        String query = "SELECT * FROM etudiants";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Etudiant etudiant = new Etudiant();
                etudiant.setId(rs.getInt("id"));
                etudiant.setNom(rs.getString("nom"));
                etudiant.setPrenom(rs.getString("prenom"));
                etudiant.setEmail(rs.getString("email"));
                etudiant.setMatricule(rs.getString("matricule"));
                etudiant.setDateNaissance(rs.getString("date_naissance"));
                etudiant.setClasse(rs.getString("classe"));
                etudiants.add(etudiant);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return etudiants;
    }
}
