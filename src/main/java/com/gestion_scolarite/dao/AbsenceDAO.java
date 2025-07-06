package com.gestion_scolarite.dao;

import com.gestion_scolarite.model.Absence;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AbsenceDAO {

    private Connection connection;

    public AbsenceDAO() {
        this.connection = DatabaseConnection.getConnection();
    }

    public void enregistrerAbsence(Absence absence) {
        try {
            String query = "INSERT INTO absences (id_etudiant, id_matiere, date_absence) VALUES (?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, absence.getIdEtudiant());
            preparedStatement.setInt(2, absence.getIdMatiere());
            preparedStatement.setDate(3, Date.valueOf(absence.getDateAbsence()));
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Absence> getAbsencesByEtudiant(int idEtudiant) {
        List<Absence> absences = new ArrayList<>();
        try {
            String query = "SELECT * FROM absences WHERE id_etudiant = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, idEtudiant);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Absence absence = new Absence();
                absence.setId(resultSet.getInt("id"));
                absence.setIdEtudiant(resultSet.getInt("id_etudiant"));
                absence.setIdMatiere(resultSet.getInt("id_matiere"));
                absence.setDateAbsence(resultSet.getDate("date_absence").toLocalDate());
                absences.add(absence);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return absences;
    }
}
