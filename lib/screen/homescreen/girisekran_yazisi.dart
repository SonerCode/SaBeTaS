// ignore_for_file: file_names

import 'package:flutter/material.dart';

class GirisMesaji extends StatelessWidget {
  const GirisMesaji({super.key});

  @override
  Widget build(BuildContext context) {
    // Mevcut zamanı al
    DateTime now = DateTime.now();
    int hour = now.hour;

    // Saate göre metni belirle
    String greeting;
    if (hour >= 6 && hour < 12) {
      greeting = "Günaydın ${String.fromCharCode(0x2600)}";
    } else if (hour >= 12 && hour < 18) {
      greeting = "İyi günler ${String.fromCharCode(0x1F319)}";
    } else {
      greeting = "İyi Akşamlar ${String.fromCharCode(0x1F319)}";
    }

    // Widget'ı döndür
    return Text(
      greeting,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}
