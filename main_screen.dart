import 'package:flutter/material.dart';
import 'package:sawa_chat/theme.dart';
import 'package:sawa_chat/screens/home_screen.dart';
import 'package:sawa_chat/screens/rooms_screen.dart';
import 'package:sawa_chat/screens/messages_screen.dart';
import 'package:sawa_chat/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    RoomsScreen(),
    MessagesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.darkSurface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: AppColors.gold,
            unselectedItemColor: AppColors.textTertiary,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group_rounded),
                label: 'الغرف',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_rounded),
                label: 'الرسائل',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'الملف',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
