import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_app/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScan extends StatefulWidget {
  const QRScan({Key? key}) : super(key: key);

  @override
  State<QRScan> createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  String todayDate = DateFormat('yyyy-dd-MM').format(DateTime.now());

  String? firstText;
  String secondText = "";

  String savedDate = "";
  int? count = 0;
  bool checkQr = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    getTodaysDate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        //color: Colors.black,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 13, 13, 13),
          // borderRadius: BorderRadius.circular(10),
          //border: Border.all(color: Colors.black
        ),

        child: Padding(
          padding: const EdgeInsets.all(60),
          child: MobileScanner(
              fit: BoxFit.fitWidth,
              allowDuplicates: false,
              onDetect: (barcode, args) {
                if (barcode.rawValue == null) {
                  debugPrint('Failed to scan Barcode');
                } else {
                  final String code = barcode.rawValue!;
                  debugPrint('Barcode found! $code');
                  checkIfAlreadyScanned(code);
                }
              }),
        ),
      ),
    ));
  }

  checkIfAlreadyScanned(data) {
    if (savedDate.toString() == todayDate) {
      Utils.flushBarErrorMessage("You have already scanned", context);
      //messageBox();
      log("You have already scanned");
    } else {
      log(data);
      saveTodaysDate();
      Utils.flushBarErrorMessage("Thank you", context);
      //thankyoumessageBox();
    }
  }

  void saveTodaysDate() async {
    prefs = await SharedPreferences.getInstance();

    prefs.setString("todaysDate", todayDate);
    savedDate = todayDate;
  }

  void getTodaysDate() async {
    prefs = await SharedPreferences.getInstance();

    savedDate = prefs.getString("todaysDate") ?? "";

    log("date-----$savedDate");
  }

  Widget messageBox() => Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white70,
        ),
        child: const Center(
          child: Text('You already scanned.Cannot scan anymore',
              style:
                  TextStyle(fontSize: 15, color: Color.fromARGB(255, 1, 1, 1))),
        ),
      );

  Widget thankyoumessageBox() => Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white70,
        ),
        child: const Center(
          child: Text('Thank you for scanning',
              style:
                  TextStyle(fontSize: 15, color: Color.fromARGB(255, 1, 1, 1))),
        ),
      );
}
