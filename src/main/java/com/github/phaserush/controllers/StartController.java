package com.github.phaserush.controllers;

import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.TextField;

public class StartController {

  @FXML private TextField tf_username;

  @FXML private TextField tf_password;

  @FXML private TextField tf_sql;

  @FXML
  void onSubmitAsClient(ActionEvent event) {
    printFields();
  }

  @FXML
  void onSubmitAsEmployee(ActionEvent event) {
    printFields();
  }

  @FXML
  void onSubmitAsManager(ActionEvent event) {
    printFields();
  }

  @FXML
  void onSubmitSQL(ActionEvent event) {
    printFields();
  }

  private void printFields() {
    System.out.println(
        String.format(
            "Name:\t%s\nPassword:\t%s\nSQL:\t%s",
            tf_username.getCharacters(), tf_password.getCharacters(), tf_sql.getCharacters()));
  }
}
