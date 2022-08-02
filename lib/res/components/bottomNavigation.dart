import 'package:flutter/material.dart';
import 'package:qr_app/view/qr_generate.dart';
import 'package:qr_app/view/qr_scan_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  final navigationScreens = [
    const QRScan(),
    const QRGenerate(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationScreens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        elevation: 0,
        iconSize: 30,
        backgroundColor: const Color.fromARGB(255, 136, 243, 243),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_camera), label: "Scan QR"),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code), label: "Generate QR")
        ],
      ),
    );
  }
}
