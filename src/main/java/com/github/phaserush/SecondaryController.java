package com.github.phaserush;

import javafx.fxml.FXML;

import java.io.IOException;

public class SecondaryController {

  @FXML
  private void switchToPrimary() throws IOException {
    WarehouseIndustries.setRoot("primary");
  }
}
