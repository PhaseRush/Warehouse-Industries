package com.github.phaserush;

import com.github.phaserush.database.Database;
import com.github.phaserush.util.Config;
import com.github.phaserush.util.Util;
import com.google.gson.Gson;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

/** JavaFX WarehouseIndustries */
public class WarehouseIndustries extends Application {

  private static Scene scene;

  private static Config config =
      new Gson().fromJson(Util.readFileToString("data/config.json"), Config.class);

  @Override
  public void start(Stage stage) throws IOException {
    scene = new Scene(loadFXML("primary"));
    stage.setScene(scene);
    stage.show();
  }

  static void setRoot(String fxml) throws IOException {
    scene.setRoot(loadFXML(fxml));
  }

  private static Parent loadFXML(String fxml) throws IOException {
    FXMLLoader fxmlLoader = new FXMLLoader(WarehouseIndustries.class.getResource(fxml + ".fxml"));
    return fxmlLoader.load();
  }

  public static void main(String[] args) {
    // attempt to connect to db
    Database.init(config.getDbName(), config.getPort(), config.getDbUserName(), config.getDbUserPass());

    launch();
  }
}
