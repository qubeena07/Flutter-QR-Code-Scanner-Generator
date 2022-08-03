import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScan extends StatefulWidget {
  const QRScan({Key? key}) : super(key: key);

  @override
  State<QRScan> createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? barcode;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    // TODO: implement reassemble
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          buildQRView(context),
          Positioned(
              bottom: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildResult(),
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
      (barcode) => setState(() => this.barcode = barcode),
    );
  }

  Widget buildResult() => Container(
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
