package com.gestion_scolarite.dao;

import com.gestion_scolarite.model.Note;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NoteDAO {

    private Connection connection;

    public NoteDAO() {
        this.connection = DatabaseConnection.getConnection(); // Connexion à la base de données
    }

    public void ajouterNote(Note note) {
        try {
            String query = "INSERT INTO notes (etudiant_id, matiere_id, note) VALUES (?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, note.getIdEtudiant());
            preparedStatement.setInt(2, note.getIdMatiere());
            preparedStatement.setDouble(3, note.getNote());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Note> getNotesByEtudiant(int idEtudiant) {
        List<Note> notes = new ArrayList<>();
        try {
            String query = "SELECT * FROM notes WHERE etudiant_id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, idEtudiant);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Note note = new Note();
                note.setId(resultSet.getInt("id"));
                note.setIdEtudiant(resultSet.getInt("etudiant_id"));
                note.setIdMatiere(resultSet.getInt("matiere_id"));
                note.setNote(resultSet.getDouble("note"));
                notes.add(note);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notes;
    }

    public void modifierNote(Note note) {
        try {
            String query = "UPDATE notes SET note = ? WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setDouble(1, note.getNote());
            preparedStatement.setInt(2, note.getId());
            preparedStatement.executeUpdate();
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void supprimerNote(int id) {
        try {
            String query = "DELETE FROM notes WHERE id = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Note> getAllNotes() {
        List<Note> notes = new ArrayList<>();
        try {
            String query = "SELECT * FROM notes";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Note note = new Note();
                note.setId(resultSet.getInt("id"));
                note.setIdEtudiant(resultSet.getInt("etudiant_id"));
                note.setIdMatiere(resultSet.getInt("matiere_id"));
                note.setNote(resultSet.getDouble("note"));
                notes.add(note);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return notes;
    }

    public Note getNoteById(int id) {
        String sql = "SELECT * FROM notes WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Note note = new Note();
                note.setId(rs.getInt("id"));
                note.setIdEtudiant(rs.getInt("etudiant_id"));
                note.setIdMatiere(rs.getInt("matiere_id"));
                note.setNote(rs.getFloat("note"));
                return note;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public float calculerMoyenne(int etudiantId) {
        String query = "SELECT AVG(note) AS moyenne FROM notes WHERE etudiant_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, etudiantId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getFloat("moyenne");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0f;
    }


}
