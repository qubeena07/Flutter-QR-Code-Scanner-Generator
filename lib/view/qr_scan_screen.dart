import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRScan extends StatefulWidget {
  const QRScan({Key? key}) : super(key: key);

  @override
  State<QRScan> createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;
  QRViewController? controller;

  String? todayDate;
  String? firstText;
  String secondText = "";

  String date = "";

  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodaysDate();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  //bool usedQR = false;

  @override
  Widget build(BuildContext context) {
    reassemble();

    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          // (date == todayDate)
          //     ? const Text("You have already scan")
          //     : buildQRView(context),
          // Visibility(
          //   visible: date.isEmpty,
          //   child: buildQRView(context),
          // ),
          (date == todayDate) ? messageBox() : buildQRView(context),
          // buildQRView(context),
          // Positioned(
          //     bottom: 10,
          //     child: Padding(
          //         padding: const EdgeInsets.all(8.0), child: buildResult()))
        ],
      ),
    ));
  }

  Widget buildQRView(context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderWidth: 10,
          borderRadius: 15,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      );
  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      // todayDate = DateFormat('yyyy-dd-MM').format(DateTime.now());
    });
    controller.scannedDataStream.listen(
      (barcode) => setState(() {
        this.barcode = barcode;
      }),
    );
  }

  Widget buildResult() {
    setState(() {
      //todayDate = true;
      todayDate = DateFormat('yyyy-dd-MM').format(DateTime.now());

      //firstText = "${barcode}"
      //log("firstText----${barcode!.code}");
    });
    //saveTodaysDate(todayDate!);

    saveTodaysDate(todayDate.toString());
    log("dateTime----$todayDate");
    //log("firstText------$firstText");
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white70,
      ),
      child: Text(
        barcode != null ? "${barcode!.code}" : "",
        maxLines: 3,
      ),
    );
  }

  void saveTodaysDate(
    String date,
  ) async {
    prefs = await SharedPreferences.getInstance();

    prefs.setString("todaysDate", date);
    // prefs.setString("firstText", text);

    //prefs.setString("todaysDate", date);
  }

  void getTodaysDate() async {
    prefs = await SharedPreferences.getInstance();

    date = prefs.getString("todaysDate") ?? "";
    //secondText = prefs.getString("firstText") ?? "";
    log("date-----$date");
    //log("secondText-----$secondText");
    setState(() {});
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
}
