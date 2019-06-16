package com.github.phaserush.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
  private static Connection conn;

  public static void init(String dbName, String port, String dbUsername, String dbPassword) {
    try {
      conn =
          DriverManager.getConnection(
              "jdbc:mysql://localhost:" + port + "/" + dbName, dbUsername, dbPassword);
    } catch (SQLException ex) {
      System.out.println("SQLException: " + ex.getMessage());
      System.out.println("SQLState: " + ex.getSQLState());
      System.out.println("VendorError: " + ex.getErrorCode());
    }
  }
}
