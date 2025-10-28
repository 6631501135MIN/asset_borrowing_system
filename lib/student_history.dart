import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentHistoryPage extends StatelessWidget {
  const StudentHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final historyItems = [
      {
        "name": "PlayStation 5",
        "id": "PS5-1",
        "from": "16 Nov 2025",
        "to": "19 Nov 2025",
        "approvedBy": "Aj.God",
        "status": "Borrowing",
        "icon": "assets/PS_Controller.png",
      },
      {
        "name": "iPad Pro M4",
        "id": "iPad-1",
        "from": "2 Nov 2025",
        "to": "5 Nov 2025",
        "approvedBy": "Aj.Paweena",
        "status": "Returned",
        "icon": "assets/iPad.png",
      },
      {
        "name": "Macbook Air M3",
        "id": "Mac-1",
        "from": "16 Oct 2025",
        "to": "18 Oct 2025",
        "approvedBy": "Aj.Surapong",
        "status": "Returned",
        "icon": "assets/MacBook.png",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0C1C64),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Hello Min Maung!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(Icons.notifications_none, color: Colors.white),
                ],
              ),
            ),

            // Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Text(
                "Borrower History",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // History List
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF4F4F8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: historyItems.length,
                  itemBuilder: (context, index) {
                    final item = historyItems[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0E1939),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            item['icon'].toString(),
                            width: 40,
                            height: 40,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item["name"].toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "ID: ${item["id"]}",
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "From: ${item["from"]}\nTo: ${item["to"]}",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Approved by: ${item["approvedBy"]}",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    item["status"].toString(),
                                    style: TextStyle(
                                      color: item["status"] == "Borrowing"
                                          ? Colors.orangeAccent
                                          : Colors.greenAccent,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF0C1C64),
        unselectedItemColor: const Color(0xFF0C1C64),
        currentIndex: 1,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/Empty_Box.png", width: 24, height: 24),
            label: "Assets",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/Activity_History.png",
              width: 24,
              height: 24,
            ),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/Home_Page.png", width: 24, height: 24),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/User.png", width: 24, height: 24),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
