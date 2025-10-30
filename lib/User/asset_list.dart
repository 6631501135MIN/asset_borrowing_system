import 'package:flutter/material.dart';

class BorrowRequest extends StatefulWidget {
  const BorrowRequest({super.key});

  @override
  State<BorrowRequest> createState() => _BorrowRequestState();
}

class _BorrowRequestState extends State<BorrowRequest> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: [
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

                      // ของงงงงงงงงงงงงงงงงงงล้านอัน เปลี่ยนสีการืดไงตาม
                      Expanded(
                        child: Stack(
                          children: [
                            ListView(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                              children: [
                                simpleAssetCard(
                                  icon: Icons.laptop_outlined,
                                  title: 'Macbook',
                                  status: 'Available',
                                  statusColor:
                                      const Color.fromRGBO(76, 175, 80, 1),
                                ),
                                const SizedBox(height: 12),
                                simpleAssetCard(
                                  icon: Icons.tablet_mac_outlined,
                                  title: 'iPad',
                                  status: 'Available',
                                  statusColor:
                                      const Color.fromRGBO(76, 175, 80, 1),
                                ),
                                const SizedBox(height: 12),
                                simpleAssetCard(
                                  icon: Icons.videogame_asset,
                                  title: 'PlayStation',
                                  status: 'Available',
                                  statusColor:
                                      const Color.fromRGBO(76, 175, 80, 1),
                                ),
                                const SizedBox(height: 12),
                                simpleAssetCard(
                                  icon: Icons.vrpano_outlined,
                                  title: 'VR Headset',
                                  status: 'Disable',
                                  statusColor:
                                      const Color.fromARGB(255, 255, 64, 64),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 1,
                              right: 16,
                              child: ElevatedButton(
                                onPressed: () {
                                  print('Check Requests');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1a2b5a),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF1a2b5a),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined), label: 'Assets'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

// วิดเจ็ตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตต
  Widget simpleAssetCard({
    required IconData icon,
    required String title,
    required String status,
    required Color statusColor,
  }) {
    Color backgroundColor = status.toLowerCase() == 'disable'
        ? const Color.fromARGB(255, 128, 128, 128)
        : const Color(0xFF1a2b5a);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Color(0x14000000), blurRadius: 5, offset: Offset(0, 2)),
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
