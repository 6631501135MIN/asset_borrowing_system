// lib/screens/lecturer_login_screen.dart
import 'package:flutter/material.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocus = FocusNode();
  bool _obscurePassword = true;

  String? _usernameError; // outside-the-box validator message
  String? _passwordError; // outside-the-box validator message

  static const _bg = Color(0xFF0C1851);
  static const _boxFill = Color(0xFF081038);

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      if (_usernameError != null &&
          _usernameController.text.trim().isNotEmpty) {
        setState(() => _usernameError = null);
      }
    });
    _passwordController.addListener(() {
      if (_passwordError != null && _passwordController.text.isNotEmpty) {
        setState(() => _passwordError = null);
      }
    });
  }

  @override
  void dispose() {
    _usernameController
      ..text = ''
      ..dispose();
    _passwordController
      ..text = ''
      ..dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState == null) return;

    String? userErr;
    String? passErr;

    if (_usernameController.text.trim().isEmpty) {
      userErr = 'Please enter your username';
    }
    if (_passwordController.text.isEmpty) {
      passErr = 'Please enter your password';
    }

    setState(() {
      _usernameError = userErr;
      _passwordError = passErr;
    });

    if (userErr != null || passErr != null) return;

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/student-assets');
  }

  BoxDecoration _boxDecoration(BuildContext context) => BoxDecoration(
        color: _boxFill,
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 36),
                      const Icon(Icons.layers, color: Colors.white, size: 48),

                      const SizedBox(height: 20),
                      const Text(
                        'Welcome to the Assets Borrowing System',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 60),

                      // Username
                      SizedBox(
                        width: 300,
                        child: _boxedField(
                          context: context,
                          controller: _usernameController,
                          hintText: 'Enter your ID, username or email address',
                          prefixIcon: Icons.credit_card_outlined,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [
                            AutofillHints.username,
                            AutofillHints.email,
                          ],
                          validator: null,
                        ),
                      ),
                      if (_usernameError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _usernameError!,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 24),

                      // Password
                      SizedBox(
                        width: 300,
                        child: _boxedField(
                          context: context,
                          controller: _passwordController,
                          hintText: 'Enter Password',
                          prefixIcon: Icons.key_outlined,
                          obscureText: _obscurePassword,
                          focusNode: _passwordFocus,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _handleLogin(),
                          autofillHints: const [AutofillHints.password],
                          suffixIcon: IconButton(
                            onPressed: () =>
                                setState(() => _obscurePassword = !_obscurePassword),
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 20,
                              color: Colors.white70,
                            ),
                          ),
                          validator: null,
                        ),
                      ),
                      if (_passwordError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _passwordError!,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 30),

                      // Login button
                      InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: _handleLogin,
                        child: Ink(
                          width: 120,
                          decoration: _boxDecoration(context).copyWith(
                            color: const Color(0xFF1D2965),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // 🔗 Go to register
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12.5,
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/student-register'),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.5,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Text field wrapped in a Setting-style box.
  Widget _boxedField({
    required BuildContext context,
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
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: _boxDecoration(context),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 8.0),
            child: Icon(prefixIcon, color: Colors.white70, size: 20),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              obscureText: obscureText,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              onFieldSubmitted: onFieldSubmitted,
              autofillHints: autofillHints,
              cursorColor: Colors.white,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13.5,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color(0x99FFFFFF),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          if (suffixIcon != null) suffixIcon,
        ],
      ),
    );
  }
}
