/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnectionManager {
    private static DBConnectionManager instance;

    private final String url = "jdbc:mysql://localhost:3306/ocean_view_resort?useSSL=false&serverTimezone=UTC";
    private final String user = "root";
    private final String pass = ""; // WAMP default often blank

    private DBConnectionManager() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            throw new RuntimeException("MySQL Driver not found!", ex);
        }
    }

    public static synchronized DBConnectionManager getInstance() {
        if (instance == null) instance = new DBConnectionManager();
        return instance;
    }

    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, pass);
    }
}