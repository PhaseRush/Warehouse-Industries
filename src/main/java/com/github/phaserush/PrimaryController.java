package com.github.phaserush;

import javafx.fxml.FXML;

import java.io.IOException;

public class PrimaryController {

  @FXML
  private void switchToSecondary() throws IOException {
    WarehouseIndustries.setRoot("secondary");
  }
}
