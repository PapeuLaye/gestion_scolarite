package com.gestion_scolarite.dao;

import com.gestion_scolarite.model.Matiere;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MatiereDAO {

    private Connection connection;

    public MatiereDAO() {
        this.connection = DatabaseConnection.getConnection(); // Connexion à la base de données
    }

    public List<Matiere> getAllMatieres() {
        List<Matiere> matieres = new ArrayList<>();
        try {
            String query = "SELECT * FROM matieres";
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                Matiere matiere = new Matiere();
                matiere.setId(resultSet.getInt("id"));
                matiere.setNom(resultSet.getString("nom"));
                matiere.setCode(resultSet.getString("code"));
                matiere.setCoefficient(resultSet.getInt("coefficient"));
                matieres.add(matiere);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return matieres;
    }

    public Matiere getMatiereById(int id) {
        Matiere matiere = null;
        try {
            String query = "SELECT * FROM matieres WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                matiere = new Matiere();
                matiere.setId(resultSet.getInt("id"));
                matiere.setNom(resultSet.getString("nom"));
                matiere.setCode(resultSet.getString("code"));
                matiere.setCoefficient(resultSet.getInt("coefficient"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return matiere;
    }

    public void ajouterMatiere(Matiere matiere) {
        try {
            String query = "INSERT INTO matieres (nom, code, coefficient) VALUES (?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, matiere.getNom());
            preparedStatement.setString(2, matiere.getCode());
            preparedStatement.setInt(3, matiere.getCoefficient());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void modifierMatiere(Matiere matiere) {
        try {
            String query = "UPDATE matieres SET nom = ?, code = ?, coefficient = ? WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, matiere.getNom());
            preparedStatement.setString(2, matiere.getCode());
            preparedStatement.setInt(3, matiere.getCoefficient());
            preparedStatement.setInt(4, matiere.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void supprimerMatiere(int id) {
        try {
            String query = "DELETE FROM matieres WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e)               {
            e.printStackTrace();
        }
    }
}
