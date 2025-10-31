// ==========================================
// File: lib/student/borrow_request.dart
// ==========================================
import 'package:flutter/material.dart';

class StudentBorrowRequests extends StatefulWidget {
  const StudentBorrowRequests({super.key});

  @override
  State<StudentBorrowRequests> createState() => _StudentBorrowRequestsState();
}

class _StudentBorrowRequestsState extends State<StudentBorrowRequests> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return; // avoid redundant rebuilds
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0: // Assets
        Navigator.pushReplacementNamed(context, '/student-assets');
        break;
      case 1: // History
        Navigator.pushReplacementNamed(context, '/student-history');
        break;
      case 2: // Home (no explicit student home; send to assets hub)
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
            const Text(
              'Request Status',
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
                      child: Container(
                        padding: const EdgeInsets.all(5),
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
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                        children: [
                          _buildRequestCard(
                            icon: Icons.laptop_outlined,
                            title: 'Macbook Air M3',
                            id: 'Mac-1',
                            from: '20 Nov 2025',
                            to: '27 Nov 2025',
                            status: 'Pending',
                            statusColor: const Color(0xFFFFB020),
                          ),
                          const SizedBox(height: 12),
                          _buildRequestCard(
                            icon: Icons.tablet_mac_outlined,
                            title: 'iPad Pro M4',
                            id: 'iPad-1',
                            from: '20 Nov 2025',
                            to: '21 Nov 2025',
                            status: 'Rejected',
                            statusColor: Colors.red,
                          ),
                          const SizedBox(height: 12),
                          _buildRequestCard(
                            icon: Icons.vrpano_outlined,
                            title: 'VR Headset',
                            id: 'VR-1',
                            from: '20 Nov 2025',
                            to: '23 Nov 2025',
                            status: 'Approved',
                            statusColor: Colors.green,
                          ),
                          const SizedBox(height: 12),
                          _buildRequestCard(
                            icon: Icons.headphones_outlined,
                            title: 'Sony WH-1000XM5',
                            id: 'HP-1',
                            from: '22 Nov 2025',
                            to: '25 Nov 2025',
                            status: 'Pending',
                            statusColor: const Color(0xFFFFB020),
                          ),
                          const SizedBox(height: 12),
                          _buildRequestCard(
                            icon: Icons.camera_alt_outlined,
                            title: 'Canon EOS R5',
                            id: 'CAM-1',
                            from: '23 Nov 2025',
                            to: '30 Nov 2025',
                            status: 'Approved',
                            statusColor: Colors.green,
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

  Widget _buildRequestCard({
    required IconData icon,
    required String title,
    required String id,
    required String from,
    required String to,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1a2b5a),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'ID: $id',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  'From: $from',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  'To: $to',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 12,
                  ),
                ),
              ],
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
