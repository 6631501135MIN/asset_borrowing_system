import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';
import '../widgets/asset_item.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 2; // Home is selected by default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Hello John Smith!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                
                // Dashboard Title
                const Center(
                  child: Text(
                    'Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                
                // Stat Cards Grid
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.3,
                  children: const [
                    StatCard(
                      icon: Icons.work_outline,
                      value: '50',
                      label: 'Total Assets',
                      iconColor: Color(0xFF1A237E),
                      iconBackground: Color(0xFFE8EAF6),
                    ),
                    StatCard(
                      icon: Icons.check_circle_outline,
                      value: '30',
                      label: 'Available',
                      iconColor: Color(0xFF2E7D32),
                      iconBackground: Color(0xFFE8F5E9),
                    ),
                    StatCard(
                      icon: Icons.cancel_outlined,
                      value: '5',
                      label: 'Disabled',
                      iconColor: Color(0xFFC62828),
                      iconBackground: Color(0xFFFFEBEE),
                    ),
                    StatCard(
                      icon: Icons.arrow_forward,
                      value: '15',
                      label: 'Borrowed',
                      iconColor: Color(0xFFEF6C00),
                      iconBackground: Color(0xFFFFF3E0),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                
                // Available Assets Section
                const Text(
                  'Available Assets',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Assets List
                const Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AssetItem(
                            icon: Icons.laptop_mac,
                            label: 'Macbook',
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: AssetItem(
                            icon: Icons.tablet_mac,
                            label: 'iPad',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: AssetItem(
                            icon: Icons.sports_esports,
                            label: 'PlayStation',
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: AssetItem(
                            icon: Icons.headset,
                            label: 'VR Headset',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0D1642),
        selectedItemColor: const Color(0xFF5C6BC0),
        unselectedItemColor: Colors.white70,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Assets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
