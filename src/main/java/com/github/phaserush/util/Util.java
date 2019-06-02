package com.github.phaserush.util;

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
}
