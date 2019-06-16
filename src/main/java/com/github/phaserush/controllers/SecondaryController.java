package com.github.phaserush.controllers;

import com.github.phaserush.util.Util;
import javafx.fxml.FXML;

import java.io.IOException;

public class SecondaryController {

  @FXML
  private void switchToPrimary() throws IOException {
    Util.setRoot("primary");
  }
}
