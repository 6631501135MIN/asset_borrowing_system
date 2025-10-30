import 'package:flutter/material.dart';
// import 'User/asset_list.dart';
import 'User/asset_menu.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Borrow Request Macbook',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const BorrowRequest(),
    );
  }
}
