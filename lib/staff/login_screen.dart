import 'package:flutter/material.dart';

class StaffLoginScreen extends StatefulWidget {
  const StaffLoginScreen({super.key});

  @override
  State<StaffLoginScreen> createState() => _StaffLoginScreenState();
}

class _StaffLoginScreenState extends State<StaffLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocus = FocusNode();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final form = _formKey.currentState;
    if (form == null) return;
    if (!form.validate()) return;

    // Show before navigating (avoid disposed context)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login successful!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    if (!mounted) return;
    // Staff lands on staff-home (mapped to staff assets)
    Navigator.pushReplacementNamed(context, '/staff-home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C1851),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 80),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.layers,
                    size: 50,
                    color: Color(0xFF0A1647),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Hello Staff!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 48),

                _buildTextField(
                  controller: _usernameController,
                  hintText: 'Enter your ID, username or email address',
                  prefixIcon: Icons.credit_card_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [
                    AutofillHints.username,
                    AutofillHints.email,
                  ],
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Please enter your username'
                      : null,
                ),
                const SizedBox(height: 20),

                _buildTextField(
                  controller: _passwordController,
                  hintText: 'Enter Password',
                  prefixIcon: Icons.key_outlined,
                  obscureText: _obscurePassword,
                  focusNode: _passwordFocus,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleLogin(),
                  autofillHints: const [AutofillHints.password],
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.white38,
                      size: 22,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (v) => (v == null || v.isEmpty)
                      ? 'Please enter your password'
                      : null,
                ),
                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4169E1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    Widget? suffixIcon,
    bool obscureText = false,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    List<String>? autofillHints,
    FocusNode? focusNode,
    void Function(String)? onFieldSubmitted,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A4B8D), width: 1.5),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        autofillHints: autofillHints,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          prefixIcon: Icon(prefixIcon, color: Colors.white38, size: 22),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
