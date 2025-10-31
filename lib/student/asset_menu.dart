import 'package:flutter/material.dart';

class StudentAssetMenu extends StatelessWidget {
  const StudentAssetMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      {'icon': Icons.laptop_mac, 'label': 'Laptops'},
      {'icon': Icons.tablet_mac, 'label': 'Tablets'},
      {'icon': Icons.videocam, 'label': 'Projectors'},
      {'icon': Icons.headphones, 'label': 'Accessories'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0C1851),
      appBar: AppBar(
        title: const Text('Browse Assets'),
        backgroundColor: const Color(0xFF0C1851),
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, i) {
          final item = items[i];
          return InkWell(
            onTap: () => Navigator.pushNamed(context, '/student-assets'),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1a2b5a),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item['icon'] as IconData, color: Colors.white, size: 42),
                  const SizedBox(height: 8),
                  Text(
                    item['label'] as String,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
