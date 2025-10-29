import 'package:asset_borrowing_system/Borrower_History.dart';
import 'package:asset_borrowing_system/Lender_History.dart';
import 'package:asset_borrowing_system/Staff_History.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asset Borrowing System',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const StaffHistory(),
      debugShowCheckedModeBanner: false,
    );
  }
}
