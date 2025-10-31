import 'package:flutter/material.dart';

class BorrowerHistory extends StatefulWidget {
  const BorrowerHistory({super.key});

  @override
  State<BorrowerHistory> createState() => _BorrowerHistoryState();
}

class _BorrowerHistoryState extends State<BorrowerHistory> {
  int _selectedIndex = 1;

  void _onTap(int i) {
    setState(() => _selectedIndex = i);
    switch (i) {
      case 0:
        Navigator.pushReplacementNamed(context, '/student-assets');
        break;
      case 1:
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/student-profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final historyItems = List.generate(6, (i) {
      return {
        'icon': i.isEven ? Icons.laptop_mac : Icons.videocam,
        'name': i.isEven ? 'Macbook Pro' : 'Projector',
        'id': 'ST-00${i + 1}',
        'from': '2025-10-0${(i % 7) + 1}',
        'to': '2025-10-1${(i % 7) + 1}',
        'status': i.isEven ? 'Borrowed' : 'Returned',
      };
    });

    return Scaffold(
      backgroundColor: const Color(0xFF0C1851),
      appBar: AppBar(
        title: const Text('My History'),
        backgroundColor: const Color(0xFF0C1851),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: historyItems.length,
        itemBuilder: (context, index) {
          final item = historyItems[index];
          final color = (item['status'] == 'Borrowed')
              ? Colors.orange
              : Colors.green;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1a2b5a),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(item['icon'] as IconData, color: Colors.white, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'ID: ${item['id']}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      Text(
                        'From: ${item["from"]}  •  To: ${item["to"]}',
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
                    item['status'] as String,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: 'Assets',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
