import 'package:flutter/material.dart';
import 'package:asset_borrowing_system/lecturer/asset_menu.dart';

class LecturerAssetList extends StatefulWidget {
  const LecturerAssetList({super.key});

  @override
  State<LecturerAssetList> createState() => _LecturerAssetListState();
}

class _LecturerAssetListState extends State<LecturerAssetList> {
  int _selectedIndex = 0;

  final TextEditingController _searchController = TextEditingController();

  final List<_AssetItem> _assets = const [
    _AssetItem(icon: Icons.laptop_outlined, title: 'Macbook', status: 'Available', statusColor: Colors.green),
    _AssetItem(icon: Icons.tablet_mac_outlined, title: 'iPad', status: 'Available', statusColor: Colors.green),
    _AssetItem(icon: Icons.sports_esports_outlined, title: 'Playstation', status: 'Available', statusColor: Colors.green),
    _AssetItem(icon: Icons.vrpano_outlined, title: 'VR Headset', status: 'Disabled', statusColor: Colors.red),
  ];

  String _query = '';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/history');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _assets.where((a) => a.title.toLowerCase().contains(_query.toLowerCase())).toList();

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
                    'Hello Aj.Surapong!',
                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined, color: Colors.white, size: 22),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  ),
                ],
              ),
            ),
            const Text(
              'Manage Asset List',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 20), // was 10 → keep white sheet lower

            // Rounded inner sheet
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF2F2F6),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),  // was 28 → a little more rounded
                    topRight: Radius.circular(36), // was 28
                  ),
                ),
                child: Column(
                  children: [
                    // Search area — longer & thinner
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: FractionallySizedBox(
                        widthFactor: 0.95,
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 34,
                          child: TextField(
                            controller: _searchController,
                            onChanged: (v) => setState(() => _query = v),
                            decoration: InputDecoration(
                              hintText: 'Search Asset',
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.55),
                                fontSize: 14,
                              ),
                              filled: true,
                              fillColor: const Color(0xFF1a2b5a),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.search, color: Colors.white, size: 20),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                            ),
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                            textInputAction: TextInputAction.search,
                          ),
                        ),
                      ),
                    ),

                    // List + smaller "Check Requests" button
                    Expanded(
                      child: Stack(
                        children: [
                          ListView.separated(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                            itemCount: filtered.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 12),
                            itemBuilder: (context, i) {
                              final a = filtered[i];
                              return GestureDetector(
                                onTap: () {
                                  if (a.title == 'Macbook') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const LecturerAssetMenu()),
                                    );
                                  }
                                },
                                child: _buildAssetCard(
                                  icon: a.icon,
                                  title: a.title,
                                  status: a.status,
                                  statusColor: a.statusColor,
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 16,
                            right: 16,
                            child: ElevatedButton(
                              onPressed: () => Navigator.pushNamed(context, '/requests'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1a2b5a),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                minimumSize: const Size(150, 40),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                                elevation: 3,
                              ),
                              child: const Text('Check Requests', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
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

      // DO NOT TOUCH bottom navbar
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

  Widget _buildAssetCard({
    required IconData icon,
    required String title,
    required String status,
    required Color statusColor,
  }) {
    final bool disabled = status.toLowerCase() == 'disabled';
    final Color backgroundColor = disabled ? const Color(0xFF8D8D92) : const Color(0xFF132552);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Color(0x1F000000), blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            status,
            style: TextStyle(
              color: disabled ? Colors.red : statusColor, // disabled letter now red
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _AssetItem {
  final IconData icon;
  final String title;
  final String status;
  final Color statusColor;
  const _AssetItem({required this.icon, required this.title, required this.status, required this.statusColor});
}
