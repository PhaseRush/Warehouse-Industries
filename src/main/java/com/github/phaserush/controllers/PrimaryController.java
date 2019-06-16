package com.github.phaserush.controllers;

import com.github.phaserush.util.Util;
import javafx.fxml.FXML;

import java.io.IOException;

public class PrimaryController {

  @FXML
  private void switchToSecondary() throws IOException {
    Util.setRoot("secondary");
  }
}
