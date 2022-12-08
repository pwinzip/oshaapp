import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'tabs/assessment.dart';
import 'tabs/history.dart';
import 'tabs/home.dart';
import 'tabs/user.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _selectedPageIndex = 1;

  final pages = [
    const HistoryPage(),
    const HomePage(), // ok
    const AssessmentPage(),
    const UserPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'หน้าหลัก',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: pages.elementAt(_selectedPageIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "ประวัติ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "หน้าหลัก",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            label: "แบบประเมิน",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "บัญชีผู้ใช้",
          ),
        ],
        selectedIconTheme: const IconThemeData(size: 30),
        unselectedIconTheme: const IconThemeData(size: 22),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedPageIndex,
        unselectedItemColor: Colors.grey[600],
        selectedItemColor: const Color.fromARGB(255, 40, 88, 20),
        onTap: _onItemTapped,
      ),
    );
  }
}
