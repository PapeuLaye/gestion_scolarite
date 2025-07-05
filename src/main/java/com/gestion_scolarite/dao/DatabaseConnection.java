package com.gestion_scolarite.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/gestion_scolarite";
    private static final String USER = "root"; // Remplace par ton utilisateur MySQL
    private static final String PASSWORD = ""; // Remplace par ton mot de passe MySQL
    private static Connection connection;

    // Méthode pour obtenir une connexion unique
    public static Connection getConnection() {
        if (connection == null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Charger le driver JDBC
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("Connexion réussie à la base de données !");
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                throw new RuntimeException("Erreur de connexion à la base de données.");
            }
        }
        return connection;
    }
}
