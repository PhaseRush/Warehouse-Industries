package com.github.phaserush.util;

import com.github.phaserush.WarehouseIndustries;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Pos;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.layout.VBox;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.util.Callback;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.ResultSet;
import java.sql.SQLException;

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

    /**
     * Returns a table that represents the result set
     *
     * @param rs
     * @return
     * @throws SQLException
     */
    public static TableView getTableView(ResultSet rs) {
        TableView tableView = new TableView();
        ObservableList<ObservableList> data = FXCollections.observableArrayList();

        /**
         * ******************************** TABLE COLUMN ADDED DYNAMICALLY *
         * ********************************
         */
        try {
            for (int i = 0; i < rs.getMetaData().getColumnCount(); i++) {
                final int j = i;
                TableColumn col = new TableColumn(rs.getMetaData().getColumnName(i + 1));
                col.setCellValueFactory((Callback<TableColumn.CellDataFeatures<ObservableList, String>, ObservableValue<String>>) param -> {
                    Object entryString = param.getValue().get(j);
                    return new SimpleStringProperty(entryString == null ? "null" : entryString.toString());
                });
                tableView.getColumns().addAll(col);
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            showAlert("SQLException when determining columns", sqle.getMessage());
        }

        /**
         * ****************************** Data added to ObservableList * ******************************
         */
        try {
            while (rs.next()) {
                // Iterate Row
                ObservableList<String> row = FXCollections.observableArrayList();
                for (int i = 1; i <= rs.getMetaData().getColumnCount(); i++) {
                    // Iterate Column
                    row.add(rs.getString(i));
                }
                System.out.println("Row [1] added " + row);
                data.add(row);
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            showAlert("SQLException when populating table data", sqle.getMessage());
        }

        // FINALLY ADDED TO TableView
        tableView.setItems(data);

        return tableView;
    }

    /**
     * show a new window with the table
     *
     * @param tableView
     */
    public static void showTableWindow(TableView tableView, String windowName) {
        Stage stage = new Stage();
        stage.setTitle(windowName);
        Scene scene = new Scene(tableView);
        stage.setScene(scene);
        stage.show();
    }

}
