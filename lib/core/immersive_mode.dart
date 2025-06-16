import 'dart:io';
import 'package:flutter/services.dart';

class ImmersiveMode {
  static void enable() {
    if (Platform.isAndroid) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top], // 👈 SOLO la barra in alto visibile
      );
    }
  }
}
