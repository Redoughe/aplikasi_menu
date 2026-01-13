import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Home/home.dart';
import 'Menu Makan/menumakan.dart'; // hanya untuk tipe
import '../providers/cart_provider.dart' hide CartProvider;

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
