package com.github.phaserush.database;

import javax.xml.transform.Result;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import javafx.scene.control.TextField;

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

<<<<<<< HEAD
  public static void query(TextField textField) {
    String text = textField.getText();
    try {
      Statement smt = conn.createStatement();
      ResultSet rs = smt.executeQuery(text);
      while (rs.next()) {
        String lastName = rs.getString("Lname");
        System.out.println(lastName + "\n");
      }
    } catch (SQLException ex) {
      System.out.println("SQLException: " + ex.getMessage());
      System.out.println("SQLState: " + ex.getSQLState());
      System.out.println("VendorError: " + ex.getErrorCode());
    }
  }

=======
  // write sql executor code here
>>>>>>> 570af6055e15dd278dd211aa0342aa7726050498
}
