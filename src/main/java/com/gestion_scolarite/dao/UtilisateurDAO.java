package com.gestion_scolarite.dao;

import com.gestion_scolarite.model.Utilisateur;
import java.sql.*;

public class UtilisateurDAO {
    private Connection connection;

    public UtilisateurDAO() {
        this.connection = DatabaseConnection.getConnection();
    }

    public Utilisateur authentifier(String email, String motDePasse) {
        try {
            String sql = "SELECT * FROM utilisateurs WHERE email = ? AND mot_de_passe = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, motDePasse); // Tu peux plus tard hasher le mot de passe
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Utilisateur user = new Utilisateur();
                user.setId(rs.getInt("id"));
                user.setNom(rs.getString("nom"));
                user.setEmail(rs.getString("email"));
                user.setMotDePasse(rs.getString("mot_de_passe"));
                user.setRole(rs.getString("role"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
