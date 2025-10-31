// ==========================================
// File: lib/student/asset_list.dart
// StudentAssetList (Figma-style)
// ==========================================
import 'package:flutter/material.dart';

class StudentAssetList extends StatefulWidget {
  const StudentAssetList({super.key});

  @override
  State<StudentAssetList> createState() => _StudentAssetListState();
}

class _StudentAssetListState extends State<StudentAssetList> {
  int _selectedIndex = 0;
  final TextEditingController _search = TextEditingController();

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/student-assets');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/student-history');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/student-assets');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/student-profile');
        break;
    }
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1851),
      body: SafeArea(
        child: Column(
          children: [
            // Header (greeting + bell)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Hello Min Maung!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Icon(Icons.notifications_outlined, color: Colors.white, size: 24),
                ],
              ),
            ),

            // Centered title
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Asset List',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            // Inner rounded sheet
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F2F6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                ),
                child: Column(
                  children: [
                    // Rounded search header (pill inside a soft container)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6E7EB),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: SizedBox(
                          height: 40,
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              TextField(
                                controller: _search,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  hintText: 'Search Asset',
                                  hintStyle: TextStyle(
                                    color: Colors.white.withOpacity(0.55),
                                    fontSize: 14,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFF1a2b5a),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 0,
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              // circular search icon at right (as in Figma)
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF1a2b5a),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.search, color: Colors.white, size: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Cards + floating "Check Requests"
                    Expanded(
                      child: Stack(
                        children: [
                          ListView(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                            children: [
                              // Macbook → menu first
                              InkWell(
                                onTap: () => Navigator.pushNamed(context, '/student-asset-menu'),
                                borderRadius: BorderRadius.circular(16),
                                child: _assetCard(
                                  icon: Icons.laptop_outlined,
                                  title: 'Macbook',
                                  status: 'Available',
                                  statusColor: const Color(0xFF4CAF50),
                                  isDisabled: false,
                                ),
                              ),
                              const SizedBox(height: 14),

                              // iPad
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  '/student-borrow',
                                  arguments: {'id': 'ST-IPAD'},
                                ),
                                borderRadius: BorderRadius.circular(16),
                                child: _assetCard(
                                  icon: Icons.tablet_mac_outlined,
                                  title: 'iPad',
                                  status: 'Available',
                                  statusColor: const Color(0xFF4CAF50),
                                  isDisabled: false,
                                ),
                              ),
                              const SizedBox(height: 14),

                              // Playstation
                              InkWell(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  '/student-borrow',
                                  arguments: {'id': 'ST-PS'},
                                ),
                                borderRadius: BorderRadius.circular(16),
                                child: _assetCard(
                                  icon: Icons.sports_esports_outlined,
                                  title: 'Playstation',
                                  status: 'Available',
                                  statusColor: const Color(0xFF4CAF50),
                                  isDisabled: false,
                                ),
                              ),
                              const SizedBox(height: 14),

                              // VR Headset (disabled)
                              _assetCard(
                                icon: Icons.vrpano_outlined,
                                title: 'VR Headset',
                                status: 'Disable',
                                statusColor: const Color(0xFFD32F2F),
                                isDisabled: true,
                              ),
                            ],
                          ),

                          // Floating "Check Requests" pill
                          Positioned(
                            bottom: 16,
                            right: 16,
                            child: ElevatedButton(
                              onPressed: () => Navigator.pushNamed(context, '/student-requests'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1a2b5a),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                                shape: const StadiumBorder(),
                                elevation: 3,
                                shadowColor: const Color(0x33000000),
                              ),
                              child: const Text('Check Requests', style: TextStyle(fontWeight: FontWeight.w600)),
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

      // Bottom nav — uses existing student routes
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1a2b5a),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'Assets'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // Reusable card styled to match the screenshot
  Widget _assetCard({
    required IconData icon,
    required String title,
    required String status,
    required Color statusColor,
    required bool isDisabled,
  }) {
    final Color bg = isDisabled ? const Color(0xFF8D8D92) : const Color(0xFF132552);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x33000000), blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 14),
          const SizedBox(width: 2),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            status,
            style: TextStyle(
              color: isDisabled ? const Color(0xFFB71C1C) : statusColor,
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
