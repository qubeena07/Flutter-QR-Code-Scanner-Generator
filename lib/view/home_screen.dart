import 'package:flutter/material.dart';
import 'package:qr_app/res/components/bottomNavigation.dart';
import 'package:qr_app/view/qr_generate.dart';
import 'package:qr_app/view/qr_scan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final navigationScreens = [
    const QRScan(),
    const QRGenerate(),
  ];
  @override
  Widget build(BuildContext context) {
    return const BottomNav();
  }
}
