// ==========================================
// File: lib/student/asset_list.dart
// (Figma-style Asset List with main.dart routes)
// ==========================================
import 'package:flutter/material.dart';

class StudentAssetList extends StatefulWidget {
  const StudentAssetList({super.key});

  @override
  State<StudentAssetList> createState() => _StudentAssetListState();
}

class _StudentAssetListState extends State<StudentAssetList> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0: // Assets
        Navigator.pushReplacementNamed(context, '/student-assets');
        break;
      case 1: // History
        Navigator.pushReplacementNamed(context, '/student-history');
        break;
      case 2: // Home (use assets as home for students)
        Navigator.pushReplacementNamed(context, '/student-assets');
        break;
      case 3: // Profile
        Navigator.pushReplacementNamed(context, '/student-profile');
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
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Hello Min Maung!',
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

            // Title
            const Text(
              'Asset List',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            // Content container
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      // Search
                      SizedBox(
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
                      const SizedBox(height: 12),

                      // List
                      Expanded(
                        child: Stack(
                          children: [
                            ListView(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 72),
                              children: [
                                // ✅ CHANGE: go to the menu first
                                InkWell(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    '/student-asset-menu',
                                  ),
                                  child: simpleAssetCard(
                                    icon: Icons.laptop_outlined,
                                    title: 'Macbook',
                                    status: 'Available',
                                    statusColor: const Color.fromRGBO(
                                      76,
                                      175,
                                      80,
                                      1,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                InkWell(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    '/student-borrow',
                                    arguments: {'id': 'ST-IPAD'},
                                  ),
                                  child: simpleAssetCard(
                                    icon: Icons.tablet_mac_outlined,
                                    title: 'iPad',
                                    status: 'Available',
                                    statusColor: const Color.fromRGBO(
                                      76,
                                      175,
                                      80,
                                      1,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                InkWell(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    '/student-borrow',
                                    arguments: {'id': 'ST-PS'},
                                  ),
                                  child: simpleAssetCard(
                                    icon: Icons.videogame_asset,
                                    title: 'PlayStation',
                                    status: 'Available',
                                    statusColor: const Color.fromRGBO(
                                      76,
                                      175,
                                      80,
                                      1,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                InkWell(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    '/student-borrow',
                                    arguments: {'id': 'ST-VR'},
                                  ),
                                  child: simpleAssetCard(
                                    icon: Icons.vrpano_outlined,
                                    title: 'VR Headset',
                                    status: 'Disable',
                                    statusColor: const Color.fromARGB(
                                      255,
                                      255,
                                      64,
                                      64,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // Check Requests button
                            Positioned(
                              bottom: 0,
                              right: 16,
                              child: ElevatedButton(
                                onPressed: () => Navigator.pushNamed(
                                  context,
                                  '/student-requests',
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1a2b5a),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text('Check Requests'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom navigation wired to main.dart student routes
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

  // Card widget
  Widget simpleAssetCard({
    required IconData icon,
    required String title,
    required String status,
    required Color statusColor,
  }) {
    final bool isDisabled = status.toLowerCase() == 'disable';
    final Color backgroundColor = isDisabled
        ? const Color.fromARGB(255, 128, 128, 128)
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
