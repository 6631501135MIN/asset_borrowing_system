import 'package:flutter/material.dart';
import 'assetdetailpage.dart';
import 'asset_list.dart';

class EditAsset extends StatefulWidget {
  const EditAsset({super.key});

  @override
  State<EditAsset> createState() => _EditAssetState();
}

const Color primaryDarkBlue = Color(0xFF0C1851);

class _EditAssetState extends State<EditAsset> {
  int _selectedIndex = 0;
  int? _selectedIconGroup = 1;

  // (ฟังก์ชัน _buildAppBar, _buildNavItem, _buildBottomNavigationBar,
  // _buildTextField, _buildIconSelector... ทั้งหมดเหมือนเดิม)

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
              'Edit Assets',
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

  Widget _buildTextField() {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 12.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildIconSelector() {
    const String macbookIcon = 'asset/images/MacBook.png';
    const String psIcon = 'asset/images/PS.png';
    const String ipadIcon = 'asset/images/iPad.png';
    const String vrIcon = 'asset/images/VR.png';

    Widget buildRadioIcon(int value, String imagePath) {
      return Row(
        children: [
          Radio<int>(
            value: value,
            groupValue: _selectedIconGroup,
            onChanged: (val) {
              setState(() {
                _selectedIconGroup = val;
              });
            },
            activeColor: Colors.white,
            fillColor: MaterialStateProperty.all(Colors.white),
          ),
          Image.asset(imagePath, color: Colors.white, width: 60, height: 60),
        ],
      );
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [buildRadioIcon(1, macbookIcon), buildRadioIcon(2, psIcon)],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [buildRadioIcon(3, ipadIcon), buildRadioIcon(4, vrIcon)],
        ),
      ],
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
              decoration: BoxDecoration(
                color: Colors.grey.shade200, 
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: primaryDarkBlue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'asset/images/MacBook.png',
                              color: Colors.white,
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Macbook Air M3',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            SizedBox(
                              width: 80,
                              child: const Text(
                                'Rename',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(width: 250, child: _buildTextField()),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            SizedBox(
                              width: 80,
                              child: const Text(
                                'ID',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(width: 200, child: _buildTextField()),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _buildIconSelector(),
                        SizedBox(height: 24),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.add, color: Colors.black),
                            label: Text(
                              'Add icon',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade300,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'save',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 0, 145, 29),
                                fixedSize: Size(120, 44),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AssetDetailPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'cancel',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 163, 0, 0),
                                fixedSize: Size(120, 44),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}