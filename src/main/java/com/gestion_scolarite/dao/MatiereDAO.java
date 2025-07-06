package com.gestion_scolarite.dao;

import com.gestion_scolarite.model.Matiere;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MatiereDAO {

    private Connection connection;

    public MatiereDAO() {
        this.connection = DatabaseConnection.getConnection();
    }

    // Récupérer toutes les matières
    public List<Matiere> getAllMatieres() {
        List<Matiere> matieres = new ArrayList<>();
        String query = "SELECT * FROM matieres";
        try (PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Matiere matiere = new Matiere();
                matiere.setId(rs.getInt("id"));
                matiere.setNom(rs.getString("nom"));
                matiere.setCode(rs.getString("code"));
                matiere.setCoefficient(rs.getInt("coefficient"));
                matieres.add(matiere);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return matieres;
    }

    // Récupérer une matière par ID
    public Matiere getMatiereById(int id) {
        String query = "SELECT * FROM matieres WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Matiere matiere = new Matiere();
                matiere.setId(rs.getInt("id"));
                matiere.setNom(rs.getString("nom"));
                matiere.setCode(rs.getString("code"));
                matiere.setCoefficient(rs.getInt("coefficient"));
                return matiere;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Ajouter une matière
    public void ajouterMatiere(Matiere matiere) {
        String query = "INSERT INTO matieres (nom, code, coefficient) VALUES (?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, matiere.getNom());
            ps.setString(2, matiere.getCode());
            ps.setFloat(3, matiere.getCoefficient());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Modifier une matière
    public void modifierMatiere(Matiere matiere) {
        String query = "UPDATE matieres SET nom = ?, code = ?, coefficient = ? WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, matiere.getNom());
            ps.setString(2, matiere.getCode());
            ps.setFloat(3, matiere.getCoefficient());
            ps.setInt(4, matiere.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Supprimer une matière
    public void supprimerMatiere(int id) {
        String query = "DELETE FROM matieres WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}