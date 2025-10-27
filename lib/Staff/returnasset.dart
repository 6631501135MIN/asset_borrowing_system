import 'package:flutter/material.dart';
import 'asset_list.dart';


class ReturnAsset {
  final String name;
  final String id;
  final String fromDate;
  final String toDate;
  final String imagePath;

  ReturnAsset({
    required this.name,
    required this.id,
    required this.fromDate,
    required this.toDate,
    required this.imagePath,
  });
}

class GetReturnAssetsPage extends StatefulWidget {
  const GetReturnAssetsPage({super.key});

  @override
  State<GetReturnAssetsPage> createState() => _GetReturnAssetsPageState();
}

const Color primaryDarkBlue = Color(0xFF0C1851);

class _GetReturnAssetsPageState extends State<GetReturnAssetsPage> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<ReturnAsset> _allAssets = [
    ReturnAsset(
      name: 'Macbook Air M3',
      id: 'Mac-1',
      fromDate: '20 Nov 2025',
      toDate: '27 Nov 2025',
      imagePath: 'asset/images/MacBook.png',
    ),
    ReturnAsset(
      name: 'Playstation 5',
      id: 'PS5-1',
      fromDate: '20 Nov 2025',
      toDate: '20 Nov 2025',
      imagePath: 'asset/images/PS.png',
    ),
    ReturnAsset(
      name: 'iPad Pro M4',
      id: 'iPad-1',
      fromDate: '8 Oct 2025',
      toDate: '10 Oct 2025',
      imagePath: 'asset/images/iPad.png',
    ),
  ];

  late List<ReturnAsset> _filteredAssets;

  String _searchQuery = '';

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
            .where(
              (asset) => asset.name.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }
  
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: primaryDarkBlue,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hello Staff!',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Center(
            child: const Text(
              'Get Return Assets',
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
    );
  }

  BottomNavigationBarItem _buildNavItem(String label, String imagePath) {
    final navItems = ['Assets', 'History', 'Home', 'Profile'];
    final currentLabel = navItems[_selectedIndex];
    bool isSelected = label == currentLabel;

    return BottomNavigationBarItem(
      icon: Image.asset(
        imagePath,
        width: 40,
        height: 40,
        color: isSelected ? primaryDarkBlue : Colors.grey,
      ),
      label: label,
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: primaryDarkBlue,
      unselectedItemColor: Colors.grey,
      currentIndex: _selectedIndex,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Asset_list()),
            (Route<dynamic> route) => false, 
          );
        } else {
          setState(() {
            _selectedIndex = index;
          });
        }
      },
      items: [
        _buildNavItem('Assets', 'asset/images/Asset.png'),
        _buildNavItem('History', 'asset/images/History.png'),
        _buildNavItem('Home', 'asset/images/Home.png'),
        _buildNavItem('Profile', 'asset/images/User.png'),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        controller: _searchController,
        onChanged: _filterAssets,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search Asset',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          filled: true,
          fillColor: primaryDarkBlue,
          suffixIcon: const Icon(Icons.search, color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
        ),
      ),
    );
  }

  void _showReturnDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: primaryDarkBlue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Are you sure getting Assets?',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 0, 145, 29),
                        fixedSize: Size(100, 44),
                      ),
                      child: const Text('YES',
                          style: TextStyle(color: Colors.white)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(dialogContext).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 163, 0, 0),
                        fixedSize: Size(100, 44),
                      ),
                      child: const Text('NO',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAssetCard(ReturnAsset asset) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, left: 20.0, right: 20.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: primaryDarkBlue,
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
              color: Colors.white,
              width: 36,
              height: 36,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    asset.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ID: ${asset.id}',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8), fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'From: ${asset.fromDate}',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8), fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'To: ${asset.toDate}',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8), fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () {
                _showReturnDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 128, 164),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Return', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDarkBlue,
      appBar: _buildAppBar(),
      bottomNavigationBar: _buildBottomNavigationBar(),
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
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 0),
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
                                'No asset found "${_searchController.text}"',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.grey),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                        return _buildAssetCard(_filteredAssets[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}