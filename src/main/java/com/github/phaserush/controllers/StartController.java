package com.github.phaserush.controllers;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.chart.PieChart;
import javafx.scene.control.TextField;
import com.github.phaserush.database.Database;

public class StartController {

  @FXML private TextField tf_username;

  @FXML private TextField tf_password;

  @FXML private TextField tf_sql;

  @FXML
  void onSubmitAsClient(ActionEvent event) {
    // user put in username and password, then clicked log in as client
    // tf_username will be what they typed into the username field, etc
    Database.clientLogin(tf_username, tf_password);
    printFields();
  }

  @FXML
  void onSubmitAsEmployee(ActionEvent event) {
    // user put in username and password, then clicked log in as employee
    // tf_username will be what they typed into the username field, etc
    Database.employeeLogin(tf_username, tf_password);
    printFields();
  }

  @FXML
  void onSubmitAsManager(ActionEvent event) {
    // user put in username and password, then clicked log in as manager
    // tf_username will be what they typed into the username field, etc
    Database.managerLogin(tf_username, tf_password);
    printFields();
  }

  @FXML
  void onSubmitSQL(ActionEvent event) {
    // user input string to be interpreted as sql query, stored in tf_sql
    // handle query accordingly
    Database.query(tf_sql);
    printFields();
  }



  private void printFields() {
    System.out.println(
        String.format(
            "Name:\t%s\nPassword:\t%s\nSQL:\t%s",
            tf_username.getCharacters(), tf_password.getCharacters(), tf_sql.getCharacters()));
  }
}
