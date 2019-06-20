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
      System.out.println("logged into db");
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
      Util.showTableWindow(tv, "SQL Query Result");
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
      Util.showTableWindow(tv, "Client information");

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
      ResultSet task = login.executeQuery("select * from login_worker l, emp_packages p where username = '"
              + user + "' and pass_word = '" + pass + "' and l.worker_id = p.worker_id");

      login = conn.createStatement();
      ResultSet equipment = login.executeQuery("select id from login_worker l, emp_equip e where username = '"
              + user + "' and pass_word = '" + pass + "' and l.worker_id = e.worker_id");

      login = conn.createStatement();
      ResultSet warehouse = login.executeQuery("select id from login_worker l, emp_work_at w where username = '"
              + user + "' and pass_word = '" + pass + "' and l.worker_id = w.worker_id");

        TableView tv = Util.getTableView(task);
        Util.showTableWindow(tv, "Tasks");

        TableView tv2 = Util.getTableView(equipment);
        Util.showTableWindow(tv2, "Equipment ID");

        TableView tv3 = Util.getTableView(warehouse);
        Util.showTableWindow(tv3, "Warehouses");

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
      ResultSet id = login.executeQuery("select * from login_man where username = '" + user + "' and pass_word = '"
      + pass + "'");

      if (id.next() != false) {

        login = conn.createStatement();
        ResultSet incoming = login.executeQuery("select * from incoming_packages");

        login = conn.createStatement();
        ResultSet outoing = login.executeQuery("select * from outgoingpackage");

        login = conn.createStatement();
        ResultSet workers = login.executeQuery("SELECT worker_id, truck_id, package_id FROM combined worker;");

        login = conn.createStatement();
        ResultSet storedPackages = login.executeQuery("select * from storedpackages");

        login = conn.createStatement();
        ResultSet truckCapacities = login.executeQuery("select * from filledcap");

        login = conn.createStatement();
        ResultSet drivesAllForklifts = login.executeQuery("select w.worker_id from workers w where not exists " +
                "(select * from  forklifts f where not exists (select fd.forklift_id from forklift_drivers fd " +
                "where w.worker_id = fd.worker_id and fd.forklift_id = f.forklift_id));");

        login = conn.createStatement();
        ResultSet clientOrderedThisWeek = login.executeQuery("SELECT COUNT(client_id), package_id FROM " +
                "weeklyclients GROUP BY client_id;");

      }

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
