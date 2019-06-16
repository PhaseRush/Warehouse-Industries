module com.github.phaserush {
  requires javafx.controls;
  requires javafx.fxml;
  requires java.sql; // this line solved a bug that took 4 hours to figure out
  requires java.logging;
  requires gson;

  opens com.github.phaserush to
      javafx.fxml;
  opens com.github.phaserush.util to
      gson;
  opens com.github.phaserush.controllers to
      javafx.fxml;

  exports com.github.phaserush;
}
