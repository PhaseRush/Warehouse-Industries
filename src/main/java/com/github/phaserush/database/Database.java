package com.github.phaserush.database;

import javax.xml.transform.Result;
import java.sql.*;

import com.github.phaserush.util.Util;
import javafx.scene.control.TableView;
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

      TableView tv = Util.getTableView(rs);
      Util.showTableWindow(tv);
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
      ResultSet id = login.executeQuery("select * from login_cust log, packages p, cust_track t where " +
              "username = '" + user + "' and pass_word = '" + pass + "' and p.client_id = log.client_id and p.package_id" +
              " = t.id");

      TableView tv = Util.getTableView(id);
      Util.showTableWindow(tv);

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
      ResultSet task = login.executeQuery("select id from login_worker l, emp_packages p where username = '"
              + user + "' and pass_word = '" + pass + "' and l.worker_id = p.worker_id");

      login = conn.createStatement();
      ResultSet equipment = login.executeQuery("select id from login_worker l, emp_equip e where username = '"
              + user + "' and pass_word = '" + pass + "' and l.worker_id = e.worker_id");

      login = conn.createStatement();
      ResultSet warehouse = login.executeQuery("select id from login_worker l, emp_work_at w where username = '"
              + user + "' and pass_word = '" + pass + "' and l.worker_id = w.worker_id");

      // debugging stuff, can be removed in finished product
      ResultSetMetaData taskmd = task.getMetaData();
      int columnsNumber = taskmd.getColumnCount();
      while (task.next()) {
        for (int i = 1; i <= columnsNumber; i++) {
          String columnValue = task.getString(i);
          System.out.println(columnValue + " " + taskmd.getColumnName(i));
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
