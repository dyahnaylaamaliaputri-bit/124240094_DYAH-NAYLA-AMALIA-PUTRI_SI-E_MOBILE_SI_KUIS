import 'package:flutter/material.dart';

import 'root.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Alat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(53, 83, 255, 1)),
        useMaterial3: true,
      ),
      home: const Root(), // ← panggil Root di sini
    );
  }
}
