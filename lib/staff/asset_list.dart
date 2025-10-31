// ==========================================
// File: lib/staff/asset_list.dart
// FIX: use ReturnAssets() not GetReturnAssetsPage()
// ==========================================
import 'package:asset_borrowing_system/staff/add_asset.dart';
import 'package:asset_borrowing_system/staff/asset_details.dart';
import 'package:asset_borrowing_system/staff/return_asset.dart';
import 'package:flutter/material.dart';
 // contains class ReturnAssets

class Asset {
  final String name;
  final bool isAvailable;
  final Color backgroundColor;
  final IconData iconData;

  Asset({
    required this.name,
    this.isAvailable = true,
    required this.backgroundColor,
    required this.iconData,
  });
}

class Asset_list extends StatefulWidget {
  const Asset_list({super.key});

  @override
  State<Asset_list> createState() => _Asset_listState();
}

const Color primaryDarkBlue = Color(0xFF0C1851);
const Color secondaryDarkBlue = Color(0xFF0C1851);

class _Asset_listState extends State<Asset_list> {
  final List<Asset> _allAssets = [
    Asset(
      name: 'Macbook',
      backgroundColor: primaryDarkBlue,
      iconData: Icons.laptop_outlined,
    ),
    Asset(
      name: 'iPad',
      backgroundColor: primaryDarkBlue,
      iconData: Icons.tablet_mac_outlined,
    ),
    Asset(
      name: 'Playstation',
      backgroundColor: primaryDarkBlue,
      iconData: Icons.gamepad_outlined,
    ),
    Asset(
      name: 'VR Headset',
      isAvailable: false,
      backgroundColor: Color(0xFF616161),
      iconData: Icons.vrpano_outlined,
    ),
  ];

  late List<Asset> _filteredAssets;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _filteredAssets = _allAssets;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterAssets(String query) {
    setState(() {
      _searchQuery = query;
      _filteredAssets = query.isEmpty
          ? _allAssets
          : _allAssets
                .where(
                  (a) => a.name.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
    });
  }

  void _onBottomNavTap(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/staff-history');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/staff-home');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/staff-profile');
        break;
    }
  }

  Widget _buildAssetTile(Asset asset) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AssetDetailPage()),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: asset.backgroundColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(asset.iconData, color: Colors.white, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  asset.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
        color: primaryDarkBlue,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _filterAssets,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search Asset',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          prefixIcon: const Icon(Icons.search, color: Colors.white, size: 24),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18.0,
            horizontal: 20.0,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddAsset()),
              );
            },
            icon: const Icon(Icons.add, color: Colors.white, size: 24),
            label: const Text(
              'Add Assets',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryDarkBlue,
              padding: const EdgeInsets.symmetric(vertical: 15),
              fixedSize: const Size(160, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 5,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // FIX: push ReturnAssets() (your class)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReturnAssets()),
              );
              // Alternatively, if you prefer named route after main.dart change:
              // Navigator.pushNamed(context, '/return-assets');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: secondaryDarkBlue,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              fixedSize: const Size(160, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 5,
            ),
            child: const Text(
              'Get return Assets',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String label, IconData iconData) =>
      BottomNavigationBarItem(icon: Icon(iconData, size: 24), label: label);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDarkBlue,
      appBar: AppBar(
        backgroundColor: primaryDarkBlue,
        elevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Hello Staff!',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 5),
            Center(
              child: Text(
                'Manage Asset List',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
          const SizedBox(width: 16),
        ],
        toolbarHeight: 100,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primaryDarkBlue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        items: [
          _buildNavItem('Assets', Icons.inventory_2_outlined),
          _buildNavItem('History', Icons.history),
          _buildNavItem('Home', Icons.home_filled),
          _buildNavItem('Profile', Icons.person),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  _buildSearchBar(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListView.builder(
                        itemCount:
                            _filteredAssets.isEmpty && _searchQuery.isNotEmpty
                            ? 1
                            : _filteredAssets.length,
                        itemBuilder: (context, index) {
                          if (_filteredAssets.isEmpty &&
                              _searchController.text.isNotEmpty) {
                            return const Padding(
                              padding: EdgeInsets.only(top: 50.0),
                              child: Center(
                                child: Text(
                                  'No asset found',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                          return _buildAssetTile(_filteredAssets[index]);
                        },
                      ),
                    ),
                  ),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
