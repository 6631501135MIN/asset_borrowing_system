import 'package:flutter/material.dart';

class StudentRegisterScreen extends StatefulWidget {
  const StudentRegisterScreen({super.key});

  @override
  State<StudentRegisterScreen> createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final _phone = TextEditingController();

  bool _obscurePwd = true;
  bool _obscureCfm = true;

  // Colors (kept consistent with your app)
  static const Color pageBg = Color(0xFF0C1851); // main background
  static const Color panelBg = Color(
    0xFF0E1B5C,
  ); // inner panel (slightly different to show the card)
  static const Color brandBlue = Color(0xFF1a2b5a);
  static const Color borderBlue = Color(0xFF2A4B8D);

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    _phone.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/student-assets',
        (r) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: pageBg,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Center(
            child: Container(
              width:
                  430, // keeps a nice narrow card on large screens; harmless on phones
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
              decoration: BoxDecoration(
                color: panelBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Logo
                    Container(
                      width: 62,
                      height: 62,
                      decoration: BoxDecoration(
                        color: pageBg,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.layers,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Please fill your account Information',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 13.5),
                    ),
                    const SizedBox(height: 18),

                    // First & Last name (side by side)
                    Row(
                      children: [
                        Expanded(
                          child: _field(
                            controller: _firstName,
                            hint: 'First Name',
                            prefixIcon: Icons.badge_outlined,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Required'
                                : null,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _field(
                            controller: _lastName,
                            hint: 'Last Name',
                            prefixIcon: Icons.badge_outlined,
                            validator: (v) => (v == null || v.trim().isEmpty)
                                ? 'Required'
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    _field(
                      controller: _username,
                      hint: 'Username',
                      prefixIcon: Icons.person_outline,
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 12),

                    _field(
                      controller: _email,
                      hint: 'Email Address',
                      prefixIcon: Icons.mail_outline,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return 'Required';
                        final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v);
                        return ok ? null : 'Invalid email';
                      },
                    ),
                    const SizedBox(height: 12),

                    _field(
                      controller: _password,
                      hint: 'Password',
                      prefixIcon: Icons.vpn_key_outlined,
                      isPassword: true,
                      obscure: _obscurePwd,
                      onToggleObscure: () =>
                          setState(() => _obscurePwd = !_obscurePwd),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (v.length < 6) return 'Min 6 characters';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    _field(
                      controller: _confirm,
                      hint: 'Confirm Password',
                      prefixIcon: Icons.vpn_key_outlined,
                      isPassword: true,
                      obscure: _obscureCfm,
                      onToggleObscure: () =>
                          setState(() => _obscureCfm = !_obscureCfm),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (v != _password.text)
                          return 'Passwords do not match';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    _field(
                      controller: _phone,
                      hint: 'Phone Number',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      prefixText: '(+66)  ',
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    const SizedBox(height: 18),

                    // REGISTER button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brandBlue,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.25),
                            ),
                          ),
                        ),
                        child: const Text(
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Cancel
                    TextButton(
                      onPressed: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        } else {
                          Navigator.pushReplacementNamed(
                            context,
                            '/student-login',
                          );
                        }
                      },
                      child: const Text(
                        'Cancel Registration',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Reusable field styled like your Figma
  Widget _field({
    required TextEditingController controller,
    required String hint,
    required IconData prefixIcon,
    String? prefixText,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool isPassword = false,
    bool obscure = false,
    VoidCallback? onToggleObscure,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderBlue, width: 1.3),
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        obscureText: isPassword ? obscure : false,
        style: const TextStyle(color: Colors.white, fontSize: 14.5),
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: Colors.white70, size: 20),
          prefixText: prefixText,
          prefixStyle: const TextStyle(color: Colors.white70, fontSize: 14),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.55)),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: onToggleObscure,
                  icon: Icon(
                    obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.white60,
                    size: 20,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
