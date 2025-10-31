import 'package:flutter/material.dart';

class StudentBorrowRequests extends StatelessWidget {
  const StudentBorrowRequests({super.key});

  @override
  Widget build(BuildContext context) {
    final requests = List.generate(5, (i) {
      return {
        'id': 'REQ-10$i',
        'asset': i.isEven ? 'Macbook Pro' : 'Projector',
        'status': i % 3 == 0
            ? 'Approved'
            : (i % 3 == 1 ? 'Pending' : 'Rejected'),
      };
    });

    return Scaffold(
      backgroundColor: const Color(0xFF0C1851),
      appBar: AppBar(
        title: const Text('My Requests'),
        backgroundColor: const Color(0xFF0C1851),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: requests.length,
        itemBuilder: (context, i) {
          final r = requests[i];
          final color = r['status'] == 'Approved'
              ? Colors.green
              : r['status'] == 'Pending'
              ? const Color(0xFFFFB020)
              : Colors.red;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1a2b5a),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.assignment, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${r['asset']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        '${r['id']}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${r['status']}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
