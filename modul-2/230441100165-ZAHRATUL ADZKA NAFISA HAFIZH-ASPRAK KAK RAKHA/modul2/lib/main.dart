import 'package:flutter/material.dart';
import 'pages/tambah_wisata.dart'; // pastikan import ini ada

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tambah Wisata',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const TambahWisata(), // GANTI INI
    );
  }
}
