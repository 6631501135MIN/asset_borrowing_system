import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App', style: TextStyle(color: Colors.grey)),
          backgroundColor: Color.fromARGB(255, 3, 3, 139),
        ),
        body: Center(
          child: Text(
            'Hello world',
            style: TextStyle(fontSize: 22, color: Color.fromARGB(255, 3, 3, 139)),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          backgroundColor: Color.fromARGB(255, 3, 3, 139),
          child: Icon(Icons.add, color: Colors.grey),
        ),
      ),
    ),
  );
}