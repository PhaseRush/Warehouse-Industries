package com.github.phaserush.util;

import com.github.phaserush.WarehouseIndustries;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Pos;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.VBox;
import javafx.stage.Modality;
import javafx.stage.Stage;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class Util {

  public static String readFileToString(String path) {
    try {
      return Files.readString(Path.of(path));
    } catch (IOException e) {
      e.printStackTrace();
    }
    return null;
  }

  // will refactor to a fxml to make nicer
  public static void showAlert(String title, String message) {
    Stage alertWindow = new Stage();
    alertWindow.setTitle(title);
    alertWindow.setMinWidth(300);
    alertWindow.initModality(Modality.APPLICATION_MODAL); // forces user to take care of this window

    Label label = new Label(message);

    Button closeButton = new Button("Okay");
    closeButton.setOnAction(click -> alertWindow.close());

    VBox layout = new VBox();
    layout.getChildren().addAll(label, closeButton);
    layout.setAlignment(Pos.CENTER);

    Scene scene = new Scene(layout);
    alertWindow.setScene(scene);
    alertWindow.showAndWait(); // blocks until user resolves (clicks ok)
  }

  public static void setRoot(String fxml) throws IOException {
    WarehouseIndustries.scene.setRoot(loadFXML(fxml));
  }

  private static Parent loadFXML(String fxml) throws IOException {
    FXMLLoader fxmlLoader = new FXMLLoader(WarehouseIndustries.class.getResource(fxml + ".fxml"));
    return fxmlLoader.load();
  }
}
