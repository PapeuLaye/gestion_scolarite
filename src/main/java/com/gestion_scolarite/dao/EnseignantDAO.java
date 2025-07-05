package com.gestion_scolarite.dao;

import com.gestion_scolarite.model.Enseignant;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EnseignantDAO {

    private Connection connection;

    public EnseignantDAO() {
        this.connection = DatabaseConnection.getConnection(); // Connexion à la base de données
    }

    public List<Enseignant> getAllEnseignants() {
        List<Enseignant> enseignants = new ArrayList<>();
        try {
            String query = "SELECT * FROM enseignants";
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                Enseignant enseignant = new Enseignant();
                enseignant.setId(resultSet.getInt("id"));
                enseignant.setNom(resultSet.getString("nom"));
                enseignant.setPrenom(resultSet.getString("prenom"));
                enseignant.setEmail(resultSet.getString("email"));
                enseignants.add(enseignant);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enseignants;
    }

    public Enseignant getEnseignantById(int id) {
        Enseignant enseignant = null;
        try {
            String query = "SELECT * FROM enseignants WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                enseignant = new Enseignant();
                enseignant.setId(resultSet.getInt("id"));
                enseignant.setNom(resultSet.getString("nom"));
                enseignant.setPrenom(resultSet.getString("prenom"));
                enseignant.setEmail(resultSet.getString("email"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return enseignant;
    }

    public void ajouterEnseignant(Enseignant enseignant) {
        try {
            String query = "INSERT INTO enseignants (nom, prenom, email) VALUES (?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, enseignant.getNom());
            preparedStatement.setString(2, enseignant.getPrenom());
            preparedStatement.setString(3, enseignant.getEmail());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void modifierEnseignant(Enseignant enseignant) {
        try {
            String query = "UPDATE enseignants SET nom = ?, prenom = ?, email = ? WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, enseignant.getNom());
            preparedStatement.setString(2, enseignant.getPrenom());
            preparedStatement.setString(3, enseignant.getEmail());
            preparedStatement.setInt(4, enseignant.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void supprimerEnseignant(int id) {
        try {
            String query = "DELETE FROM enseignants WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
