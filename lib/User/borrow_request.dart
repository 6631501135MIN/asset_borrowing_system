import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BorrowRequest extends StatefulWidget {
  const BorrowRequest({super.key});

  @override
  State<BorrowRequest> createState() => _BorrowRequestState();
}

class _BorrowRequestState extends State<BorrowRequest> {
  DateTime? fromDate;
  DateTime? toDate;
  int _selectedIndex = 0;

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> selectDate(BuildContext context, bool isFrom) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isFrom)
          fromDate = picked;
        else
          toDate = picked;
      });
    }
  }

  void saveRequest() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text('Successfully submitted'),
          ],
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1851),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
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
                    constraints:
                        const BoxConstraints(minWidth: 32, minHeight: 32),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Center(
                child: const Text(
                  'Asset List',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Color.fromARGB(255, 12, 24, 81),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Borrow Request',
                            style: TextStyle(
                              color: Color.fromARGB(255, 12, 24, 81),
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

// การ์โดดดดดดดดดดดดดดด
                      Center(
                        child: Container(
                          width: 300,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 26, 43, 90),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Macbook Pro M1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Icon(Icons.laptop,
                                  color: Colors.white, size: 80),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'ID: Mac-1',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(height: 16),

                              Row(
                                children: [
                                  const Text('From: ',
                                      style: TextStyle(color: Colors.white)),
                                  SizedBox(
                                    width: 80,
                                    height: 30,
                                    child: TextButton.icon(
                                      icon: const Icon(Icons.calendar_today,
                                          size: 12),
                                      label: Text(
                                        fromDate != null
                                            ? formatter.format(fromDate!)
                                            : 'Select',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      onPressed: () =>
                                          selectDate(context, true),
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor:
                                            const Color(0xFF1a2b5a),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Text('To: ',
                                      style: TextStyle(color: Colors.white)),
                                  SizedBox(
                                    width: 80,
                                    height: 30,
                                    child: TextButton.icon(
                                      icon: const Icon(Icons.calendar_today,
                                          size: 12),
                                      label: Text(
                                        toDate != null
                                            ? formatter.format(toDate!)
                                            : 'Select',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      onPressed: () =>
                                          selectDate(context, false),
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor:
                                            const Color(0xFF1a2b5a),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

// ฌซฟฟป้ะ
                              SizedBox(
                                width: 80,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: saveRequest,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(76, 175, 80, 1),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
}
