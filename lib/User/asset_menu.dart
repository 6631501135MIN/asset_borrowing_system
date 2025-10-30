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
      backgroundColor: const Color.fromARGB(255, 12, 24, 81),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: const Color.fromARGB(255, 12, 24, 81),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Asset List Macbook',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 12, 24, 81),
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(16),
                          children: [
                            requestCard(
                              icon: Icons.laptop_outlined,
                              title: 'Macbook Pro M1',
                              id: 'Mac-1',
                              status: 'Available',
                              statusColor: const Color.fromRGBO(76, 175, 80, 1),
                            ),
                            const SizedBox(height: 12),
                            requestCard(
                              icon: Icons.laptop_outlined,
                              title: 'Macbook Pro',
                              id: 'Mac-2',
                              status: 'Pending',
                              statusColor:
                                  const Color.fromARGB(255, 253, 244, 85),
                            ),
                            const SizedBox(height: 12),
                            requestCard(
                              icon: Icons.laptop_outlined,
                              title: 'Macbook Pro',
                              id: 'Mac-3',
                              status: 'Disable',
                              statusColor:
                                  const Color.fromARGB(255, 255, 64, 64),
                            ),
                            const SizedBox(height: 12),
                            requestCard(
                              icon: Icons.headphones_outlined,
                              title: 'Macbook Air M2',
                              id: 'Mac-4',
                              status: 'Borrowed',
                              statusColor: const Color(0xFFFFB020),
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

  // วิดเจ็ตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตตต
  Widget requestCard({
    required IconData icon,
    required String title,
    required String id,
    required String status,
    required Color statusColor,
  }) {
    Color backgroundColor = status.toLowerCase() == 'disable'
        ? const Color.fromARGB(255, 100, 100, 100)
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Status: $status',
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

