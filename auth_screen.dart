import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sawa_chat/providers/app_state.dart';
import 'package:sawa_chat/theme.dart';
import 'package:sawa_chat/widgets/gradient_button.dart';
import 'package:sawa_chat/screens/main_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  bool _isLogin = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _handleEmailAuth() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showError('الرجاء ملء جميع الحقول');
      return;
    }

    setState(() => _isLoading = true);

    final appState = context.read<AppState>();
    bool success;

    if (_isLogin) {
      success = await appState.login(_emailController.text, _passwordController.text);
    } else {
      if (_usernameController.text.isEmpty) {
        _showError('الرجاء إدخال اسم المستخدم');
        setState(() => _isLoading = false);
        return;
      }
      success = await appState.register(
        _emailController.text,
        _passwordController.text,
        _usernameController.text,
      );
    }

    setState(() => _isLoading = false);

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);
    final success = await context.read<AppState>().signInWithGoogle();
    setState(() => _isLoading = false);

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    }
  }

  Future<void> _handleFacebookSignIn() async {
    setState(() => _isLoading = true);
    final success = await context.read<AppState>().signInWithFacebook();
    setState(() => _isLoading = false);

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainScreen()),
      );
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.error),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.darkBackground, AppColors.darkSurface],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [AppColors.gold, AppColors.neonBlue],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.gold.withValues(alpha: 0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.mic,
                        size: 60,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'سوا شات',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: [AppColors.gold, AppColors.neonBlue],
                          ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'تجربة صوتية فاخرة ثلاثية الأبعاد',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: AppColors.darkCard,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            _isLogin ? 'تسجيل الدخول' : 'إنشاء حساب جديد',
                            style: Theme.of(context).textTheme.headlineMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          if (!_isLogin) ...[
                            TextField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                hintText: 'اسم المستخدم',
                                prefixIcon: Icon(Icons.person, color: AppColors.gold),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: 'البريد الإلكتروني',
                              prefixIcon: Icon(Icons.email, color: AppColors.gold),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              hintText: 'كلمة المرور',
                              prefixIcon: Icon(Icons.lock, color: AppColors.gold),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 24),
                          if (_isLoading)
                            const Center(child: CircularProgressIndicator(color: AppColors.gold))
                          else
                            GradientButton(
                              text: _isLogin ? 'دخول' : 'تسجيل',
                              onPressed: _handleEmailAuth,
                              icon: Icons.login,
                            ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () => setState(() => _isLogin = !_isLogin),
                            child: Text(
                              _isLogin ? 'ليس لديك حساب? سجل الآن' : 'لديك حساب? سجل الدخول',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'أو تسجيل الدخول عبر',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(
                          icon: Icons.g_mobiledata,
                          color: AppColors.error,
                          onPressed: _handleGoogleSignIn,
                        ),
                        const SizedBox(width: 16),
                        _buildSocialButton(
                          icon: Icons.facebook,
                          color: const Color(0xFF1877F2),
                          onPressed: _handleFacebookSignIn,
                        ),
                        const SizedBox(width: 16),
                        _buildSocialButton(
                          icon: Icons.phone,
                          color: AppColors.neonBlue,
                          onPressed: () {
                            _showError('قريباً: تسجيل الدخول بالهاتف');
                          },
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
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.darkCard,
        border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
      ),
      child: IconButton(
        icon: Icon(icon, color: color, size: 28),
        onPressed: _isLoading ? null : onPressed,
      ),
    );
  }
}
