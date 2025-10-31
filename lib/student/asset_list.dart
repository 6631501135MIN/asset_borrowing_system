import 'package:flutter/material.dart';

class StudentAsset {
  final String name;
  final String id;
  final bool available;
  final IconData icon;

  StudentAsset({
    required this.name,
    required this.id,
    required this.icon,
    this.available = true,
  });
}

class StudentAssetList extends StatefulWidget {
  const StudentAssetList({super.key});

  @override
  State<StudentAssetList> createState() => _StudentAssetListState();
}

class _StudentAssetListState extends State<StudentAssetList> {
  int _selectedIndex = 0;

  void _onTap(int i) {
    setState(() => _selectedIndex = i);
    switch (i) {
      case 0:
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/student-history');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/student-profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final assets = <StudentAsset>[
      StudentAsset(name: 'Macbook Pro', id: 'ST-001', icon: Icons.laptop_mac),
      StudentAsset(
        name: 'Projector',
        id: 'ST-002',
        icon: Icons.videocam,
        available: false,
      ),
      StudentAsset(name: 'iPad', id: 'ST-003', icon: Icons.tablet_mac),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0C1851),
      appBar: AppBar(
        title: const Text('Assets'),
        backgroundColor: const Color(0xFF0C1851),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/student-requests'),
            icon: const Icon(Icons.assignment),
            tooltip: 'Borrow Requests',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: assets.length,
        itemBuilder: (context, idx) {
          final a = assets[idx];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                '/student-borrow',
                arguments: {'id': a.id},
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1a2b5a),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Icon(a.icon, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            a.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'ID: ${a.id}',
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
                        color: a.available ? Colors.green : Colors.orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        a.available ? 'Available' : 'Borrowed',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.chevron_right, color: Colors.white),
                  ],
                ),
              ),
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
