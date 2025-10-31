import 'package:flutter/material.dart';

class BorrowAssetPage extends StatelessWidget {
  const BorrowAssetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      backgroundColor: const Color(0xFF0C1851),
      appBar: AppBar(
        title: const Text('Borrow Asset'),
        backgroundColor: const Color(0xFF0C1851),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Requesting: ${args?['id'] ?? '-'}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            const Text('Reason', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 6),
            TextField(
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xFF1a2b5a),
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/student-requests');
              },
              icon: const Icon(Icons.send),
              label: const Text('Submit Request'),
            ),
          ],
        ),
      ),
    );
  }
}
