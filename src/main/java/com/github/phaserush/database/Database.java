package com.github.phaserush.database;

import javax.xml.transform.Result;
import java.sql.*;

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

// Execute an arbitrary sql query

  public static void query(TextField textField) {
    String text = textField.getText();
    try {
      Statement smt = conn.createStatement();
      ResultSet rs = smt.executeQuery(text);
    } catch (SQLException ex) {
      System.out.println("SQLException: " + ex.getMessage());
      System.out.println("SQLState: " + ex.getSQLState());
      System.out.println("VendorError: " + ex.getErrorCode());
    }
  }

  public static void clientLogin(TextField username, TextField password) {
    String user = username.getText();
    String pass = password.getText();
    try {
      Statement login = conn.createStatement();
      ResultSet id = login.executeQuery("select client_id from login_cust where username = '" + user +
              "' and pass_word = '" + pass + "'");

      // debugging stuff, can be removed in finished product
      ResultSetMetaData idmd = id.getMetaData();
      int columnsNumber = idmd.getColumnCount();
      while (id.next()) {
        for (int i = 1; i <= columnsNumber; i++) {
          String columnValue = id.getString(i);
          System.out.println(columnValue + " " + idmd.getColumnName(i));
        }
      }
      //end debugging stuff

    } catch (SQLException ex) {
      System.out.println("SQLException: " + ex.getMessage());
      System.out.println("SQLState: " + ex.getSQLState());
      System.out.println("VendorError: " + ex.getErrorCode());
    }
  }

  public static void employeeLogin(TextField username, TextField password) {
    String user = username.getText();
    String pass = password.getText();
    try {
      Statement login = conn.createStatement();
      ResultSet id = login.executeQuery("select worker_id from login_worker where username = '" + user +
              "' and pass_word = '" + pass + "'");

      // debugging stuff, can be removed in finished product
      ResultSetMetaData idmd = id.getMetaData();
      int columnsNumber = idmd.getColumnCount();
      while (id.next()) {
        for (int i = 1; i <= columnsNumber; i++) {
          String columnValue = id.getString(i);
          System.out.println(columnValue + " " + idmd.getColumnName(i));
        }
      }
      //end debugging stuff

    } catch (SQLException ex) {
      System.out.println("SQLException: " + ex.getMessage());
      System.out.println("SQLState: " + ex.getSQLState());
      System.out.println("VendorError: " + ex.getErrorCode());
    }
  }

  public static void managerLogin(TextField username, TextField password) {
    String user = username.getText();
    String pass = password.getText();
    try {
      Statement login = conn.createStatement();
      ResultSet id = login.executeQuery("select manager_id from login_man where username = '" + user +
              "' and pass_word = '" + pass + "'");

      // debugging stuff, can be removed in finished product
      ResultSetMetaData idmd = id.getMetaData();
      int columnsNumber = idmd.getColumnCount();
      while (id.next()) {
        for (int i = 1; i <= columnsNumber; i++) {
          String columnValue = id.getString(i);
          System.out.println(columnValue + " " + idmd.getColumnName(i));
        }
      }
      //end debugging stuff

    } catch (SQLException ex) {
      System.out.println("SQLException: " + ex.getMessage());
      System.out.println("SQLState: " + ex.getSQLState());
      System.out.println("VendorError: " + ex.getErrorCode());
    }
  }

}
