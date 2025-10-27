import 'package:flutter/material.dart';

class Asset {
  final String name;
  final bool isAvailable;
  final Color backgroundColor;
  final String imagePath;

  Asset({
    required this.name,
    this.isAvailable = true,
    required this.backgroundColor,
    required this.imagePath,
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
      imagePath: 'asset/images/MacBook.png',
    ),
    Asset(
      name: 'iPad',
      backgroundColor: primaryDarkBlue,
      imagePath: 'asset/images/iPad.png',
    ),
    Asset(
      name: 'Playstation',
      backgroundColor: primaryDarkBlue,
      imagePath: 'asset/images/PS.png',
    ),
    Asset(
      name: 'VR Headset',
      isAvailable: false,
      backgroundColor: Colors.grey.shade700,
      imagePath: 'asset/images/VR.png',
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
      if (query.isEmpty) {
        _filteredAssets = _allAssets;
      } else {
        _filteredAssets = _allAssets
            .where((asset) =>
                asset.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Widget _buildAssetTile(Asset asset) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
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
            Image.asset(
              asset.imagePath,
              width: 50,
              height: 50,
              color: Colors.white,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                asset.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
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
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Add Assets',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryDarkBlue,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                elevation: 5,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Get return Assets',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryDarkBlue,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                elevation: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String label, String imagePath) {
    final navItems = ['Assets', 'History', 'Home', 'Profile'];
    final currentLabel = navItems[_selectedIndex];
    bool isSelected = label == currentLabel;

    return BottomNavigationBarItem(
      icon: Image.asset(
        imagePath,
        width: 24,
        height: 24,
        color: isSelected ? primaryDarkBlue : Colors.grey,
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDarkBlue,
      appBar: AppBar(
        backgroundColor: primaryDarkBlue,
        elevation: 0,
        centerTitle: false, 
        title: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, 
          children: [
            const Text(
              'Hello Staff!', 
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Center(
              child: const Text(
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(Icons.notifications, color: Colors.white),
          ),
        ],
        toolbarHeight: 100,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primaryDarkBlue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          _buildNavItem('Assets', 'asset/images/Asset.png'),
          _buildNavItem('History', 'asset/images/History.png'),
          _buildNavItem('Home', 'asset/images/Home.png'),
          _buildNavItem('Profile', 'asset/images/User.png'),
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
                            return Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Center(
                                child: Text(
                                  'No Asset ${_searchController.text}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey),
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