package com.mockevaluation.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static Connection con;

    public static Connection getConnection() {
        try {
            if (con == null || con.isClosed()) {
                Class.forName("com.mysql.cj.jdbc.Driver");

                String url = System.getenv().getOrDefault(
                        "MOCK_DB_URL",
                        "jdbc:mysql://localhost:3306/mock_evaluation_system");
                String user = System.getenv().getOrDefault("MOCK_DB_USER", "root");
                String password = System.getenv("MOCK_DB_PASSWORD");

                if (password == null) {
                    throw new IllegalStateException(
                            "MOCK_DB_PASSWORD environment variable is not set.");
                }

                con = DriverManager.getConnection(url, user, password);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}
