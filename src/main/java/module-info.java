module com.github.phaserush {
    requires javafx.controls;
    requires javafx.fxml;

    opens com.github.phaserush to javafx.fxml;
    exports com.github.phaserush;
}