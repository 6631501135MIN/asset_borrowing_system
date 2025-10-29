import 'package:flutter/material.dart';

class StaffHistory extends StatelessWidget {
  const StaffHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final historyItems = <Map<String, String>>[
      {
        "name": "PlayStation 5",
        "id": "PS5-1",
        "from": "16 Nov 2025",
        "to": "19 Nov 2025",
        "borrowedBy": "Min",
        "approvedBy": "Aj.God",
        "status": "Borrowing",
        "icon": "assets/PS_Controller.png",
      },
      {
        "name": "Macbook Pro M2",
        "id": "Mac-2",
        "from": "14 Nov 2025",
        "to": "16 Nov 2025",
        "borrowedBy": "Joy",
        "returnedBy": "Joy",
        "approvedBy": "Aj.King",
        "status": "Returned",
        "icon": "assets/MacBook.png",
      },
      {
        "name": "iPad Air M2",
        "id": "iPad-2",
        "from": "1 Nov 2025",
        "to": "18 Nov 2025",
        "borrowedBy": "Ray",
        "approvedBy": "Aj.Fon",
        "status": "Borrowing",
        "icon": "assets/iPad.png",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0C1C64),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF0C1C64),
        unselectedItemColor: const Color(0xFF0C1C64),
        currentIndex: 1,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        iconSize: 40,
        selectedFontSize: 18,
        unselectedFontSize: 18,

        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/Empty_Box.png", width: 40, height: 40),
            label: "Assets",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/Activity_History.png",
              width: 30,
              height: 40,
            ),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/Home_Page.png", width: 30, height: 40),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/User.png", width: 30, height: 40),
            label: "Profile",
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Hello John Smith!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  Icon(Icons.notifications_none, color: Colors.white, size: 26),
                ],
              ),
            ),

            // Title
            Center(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Text(
                  "Staff History",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            // History List
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF4F4F8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: historyItems.isEmpty
                    ? _buildEmptyState(context)
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: historyItems.length,
                        itemBuilder: (context, index) {
                          final item = historyItems[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 14),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0E1939),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        item['icon'].toString(),
                                        width: 40,
                                        height: 60,
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        item["name"].toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          height: 1.3,
                                        ),
                                      ),
                                      SizedBox(width: 24),
                                      Text(
                                        "ID: ${item["id"]}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "From: ${item["from"]}\nTo: ${item["to"]}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.5,
                                          height: 1.4,
                                        ),
                                      ),
                                      Text(
                                        item["status"].toString(),
                                        style: TextStyle(
                                          color: item["status"] == "Borrowing"
                                              ? Colors.orange
                                              : Colors.green,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "Borrowed By: ${item['borrowedBy']}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.5,
                                              height: 1.4,
                                            ),
                                          ),
                                          item['returnedBy'] != null
                                              ? Text(
                                                  "Returned By: ${item['returnedBy']}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16.5,
                                                    height: 1.4,
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                      Text(
                                        "Approved by: ${item["approvedBy"]}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.5,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/searchIcon.png", width: 220, height: 220),
          const SizedBox(height: 28),
          const Text(
            "No history found yet",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Activity of your assets will appear.",
            style: TextStyle(fontSize: 16, color: Colors.black, height: 1.4),
          ),
          const SizedBox(height: 28),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0C1C64),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              elevation: 0,
            ),
            child: const Text(
              "Go to assets",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
