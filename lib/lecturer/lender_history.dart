import 'package:flutter/material.dart';

class LenderHistory extends StatefulWidget {
  const LenderHistory({super.key});

  @override
  State<LenderHistory> createState() => _LenderHistoryState();
}

class _LenderHistoryState extends State<LenderHistory> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final historyItems = <Map<String, dynamic>>[
      {
        "name": "PlayStation 5",
        "id": "PS5-1",
        "from": "16 Nov 2025",
        "to": "19 Nov 2025",
        "approvedBy": "Min",
        "status": "Approved",
        "icon": Icons.sports_esports_outlined,
      },
      {
        "name": "VR Headset",
        "id": "VR-1",
        "from": "11 Nov 2025",
        "to": "11 Nov 2025",
        "approvedBy": "Mink",
        "status": "Rejected",
        "icon": Icons.vrpano_outlined,
      },
      {
        "name": "iPad Pro M2",
        "id": "iPad-2",
        "from": "8 Oct 2025",
        "to": "10 Oct 2025",
        "approvedBy": "Chalisa",
        "status": "Approved",
        "icon": Icons.tablet_mac_outlined,
      },
    ];

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
              'Lender History',
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
                child: historyItems.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                        physics: const BouncingScrollPhysics(),
                        itemCount: historyItems.length,
                        itemBuilder: (context, index) {
                          final item = historyItems[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _buildHistoryCard(
                              icon: item['icon'] as IconData,
                              title: item['name'] as String,
                              id: item['id'] as String,
                              from: item['from'] as String,
                              to: item['to'] as String,
                              approvedBy: item['approvedBy'] as String,
                              status: item['status'] as String,
                              statusColor: item['status'] == 'Rejected'
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          );
                        },
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

  Widget _buildHistoryCard({
    required IconData icon,
    required String title,
    required String id,
    required String from,
    required String to,
    required String approvedBy,
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
                const SizedBox(height: 1),
                Text(
                  'Approved by: $approvedBy',
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

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 120,
              color: Colors.grey.withOpacity(0.3),
            ),
            const SizedBox(height: 24),
            const Text(
              'No history found yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1a2b5a),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                elevation: 2,
              ),
              child: const Text(
                'Go to requests',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
