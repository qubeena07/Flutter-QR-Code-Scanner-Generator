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
          buildQRView(context),
          Positioned(
              bottom: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:

                    // Visibility(
                    //   visible: date.isEmpty,
                    //   child: buildResult(),
                    // ),
                    (date == todayDate) ? messageBox() : buildResult(),

                // (usedQR == false)?
                //buildResult()
                // : const Text(
                //   "No scan",
                //  style: TextStyle(fontSize: 20, color: Colors.white),
                //)
              ))
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
    });
    controller.scannedDataStream.listen(
      (barcode) => setState(() {
        this.barcode = barcode;
        //usedQR = true;
      }),
    );
  }

  Widget buildResult() {
    setState(() {
      todayDate = DateFormat('yyyy-mm-dd').format(DateTime.now());
    });

    saveTodaysDate(todayDate.toString());
    log("dateTime----$todayDate");
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white70,
      ),
      child: Text(
        barcode != null ? "${barcode!.code}" : "Scan Here!",
        maxLines: 3,
      ),
    );
  }

  void saveTodaysDate(String date) async {
    prefs = await SharedPreferences.getInstance();

    prefs.setString("todaysDate", date);
  }

  void getTodaysDate() async {
    prefs = await SharedPreferences.getInstance();

    date = prefs.getString("todaysDate") ?? "";
    log("date-----$date");
    setState(() {});
  }

  Widget messageBox() => Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white70,
        ),
        child: const Text('You already scanned.Cannot scan anymore',
            style: TextStyle(fontSize: 15, color: Colors.white)),
      );
}
