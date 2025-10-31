import 'package:flutter/material.dart';

class EditAsset extends StatefulWidget {
  const EditAsset({super.key});

  @override
  State<EditAsset> createState() => _EditAssetState();
}

class _EditAssetState extends State<EditAsset> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController(text: 'Macbook Pro');
  final _id = TextEditingController(text: 'AS-001');
  int? _iconGroup = 1;
  int _selectedIndex = 0;

  @override
  void dispose() {
    _name.dispose();
    _id.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/staff-assets',
          (r) => false,
        );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1851),
      appBar: AppBar(
        title: const Text('Edit Asset'),
        backgroundColor: const Color(0xFF0C1851),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context,
            '/staff-assets',
            (r) => false,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _input('Name', _name),
          const SizedBox(height: 12),
          _input('ID', _id),
          const SizedBox(height: 16),
          const Text(
            'Select Icon',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(4, (i) => i + 1).map((v) {
              return ChoiceChip(
                label: Icon(
                  v == 1
                      ? Icons.laptop_mac
                      : v == 2
                      ? Icons.tablet_mac
                      : v == 3
                      ? Icons.desktop_mac
                      : Icons.videocam,
                ),
                selected: _iconGroup == v,
                onSelected: (_) => setState(() => _iconGroup = v),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? true) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/staff-assets',
                  (r) => false,
                );
              }
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: 'Assets',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _input(String label, TextEditingController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1a2b5a),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextFormField(
            controller: c,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
