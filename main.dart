import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sawa_chat/theme.dart';
import 'package:sawa_chat/providers/app_state.dart';
import 'package:sawa_chat/screens/auth_screen.dart';
import 'package:sawa_chat/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        title: 'سوا شات',
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        home: const AppInitializer(),
      ),
    );
  }
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await context.read<AppState>().initialize();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    if (!appState.isInitialized) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.darkBackground, AppColors.darkSurface],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
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
                const Text(
                  'سوا شات',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'تجربة صوتية فاخرة ثلاثية الأبعاد',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 32),
                const CircularProgressIndicator(color: AppColors.gold),
              ],
            ),
          ),
        ),
      );
    }

    return appState.isLoggedIn ? const MainScreen() : const AuthScreen();
  }
}
