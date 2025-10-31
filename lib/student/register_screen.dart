import 'package:flutter/material.dart';

class StudentRegisterScreen extends StatefulWidget {
  const StudentRegisterScreen({super.key});

  @override
  State<StudentRegisterScreen> createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _obscure = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1851),
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: const Color(0xFF0C1851),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _field(controller: _name, hint: 'Full Name', icon: Icons.person),
          const SizedBox(height: 12),
          _field(controller: _email, hint: 'Email', icon: Icons.email),
          const SizedBox(height: 12),
          _field(
            controller: _password,
            hint: 'Password',
            icon: Icons.lock,
            isPassword: true,
            obscure: _obscure,
            toggleObscure: () => setState(() => _obscure = !_obscure),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? true) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/student-assets',
                  (r) => false,
                );
              }
            },
            child: const Text('Create Account'),
          ),
        ],
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscure = false,
    VoidCallback? toggleObscure,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? obscure : false,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white60),
          prefixIcon: Icon(icon, color: Colors.white54),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white54,
                  ),
                  onPressed: toggleObscure,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
        ),
      ),
    );
  }
}
