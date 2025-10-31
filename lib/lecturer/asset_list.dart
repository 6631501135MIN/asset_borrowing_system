import 'package:flutter/material.dart';
import 'package:asset_borrowing_system/lecturer/asset_menu.dart';

class LecturerAssetList extends StatefulWidget {
  const LecturerAssetList({super.key});

  @override
  State<LecturerAssetList> createState() => _LecturerAssetListState();
}

class _LecturerAssetListState extends State<LecturerAssetList> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Already on Assets page
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/history');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1851),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hello Aj.Surapong!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              'Asset List',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                      child: SizedBox(
                        height: 40,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search Asset',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.55),
                              fontSize: 14,
                            ),
                            filled: true,
                            fillColor: const Color(0xFF1a2b5a),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 20,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 0,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          ListView(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const LecturerAssetMenu(),
                                    ),
                                  );
                                },
                                child: _buildAssetCard(
                                  icon: Icons.laptop_outlined,
                                  title: 'Macbook',
                                  status: 'Available',
                                  statusColor: Colors.green,
                                ),
                              ),
                              const SizedBox(height: 12),
                              _buildAssetCard(
                                icon: Icons.tablet_mac_outlined,
                                title: 'iPad',
                                status: 'Available',
                                statusColor: Colors.green,
                              ),
                              const SizedBox(height: 12),
                              _buildAssetCard(
                                icon: Icons.sports_esports_outlined,
                                title: 'PlayStation',
                                status: 'Available',
                                statusColor: Colors.green,
                              ),
                              const SizedBox(height: 12),
                              _buildAssetCard(
                                icon: Icons.vrpano_outlined,
                                title: 'VR Headset',
                                status: 'Disabled',
                                statusColor: Colors.red,
                              ),
                              const SizedBox(height: 80),
                            ],
                          ),
                          Positioned(
                            bottom: 16,
                            right: 16,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/requests');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1a2b5a),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                elevation: 4,
                              ),
                              child: const Text(
                                'Check Requests',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1a2b5a),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Assets',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildAssetCard({
    required IconData icon,
    required String title,
    required String status,
    required Color statusColor,
  }) {
    Color backgroundColor = status.toLowerCase() == 'disabled'
        ? Colors.grey
        : const Color(0xFF1a2b5a);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
