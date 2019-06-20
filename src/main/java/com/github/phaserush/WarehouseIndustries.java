package com.github.phaserush;

import com.github.phaserush.database.Database;
import com.github.phaserush.util.Config;
import com.github.phaserush.util.Util;
import com.google.gson.Gson;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.layout.Pane;
import javafx.stage.Stage;

import java.io.IOException;

/** JavaFX WarehouseIndustries */
public class WarehouseIndustries extends Application {

  private static Config config =
      new Gson().fromJson(Util.readFileToString("data/config.json"), Config.class);

  @Override
  public void start(Stage stage) throws IOException {
    Pane startPane = FXMLLoader.load(WarehouseIndustries.class.getResource("start.fxml"));

    stage.setTitle("Warehouse Industries Portal");
    stage.getIcons().add(new Image(WarehouseIndustries.class.getResourceAsStream("red_w.png")));
    stage.setScene(new Scene(startPane));
    stage.show();
  }

  public static void main(String[] args) {
    // attempt to connect to db
    Database.init(
        config.getDbName(), config.getPort(), config.getDbUserName(), config.getDbUserPass());

    launch(args); // can pass args as argument
  }
}
