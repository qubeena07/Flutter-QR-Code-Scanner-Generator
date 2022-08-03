import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRDisplay extends StatefulWidget {
  final String data;
  const QRDisplay({Key? key, required this.data
      //required this.textController
      })
      : super(key: key);
  //final String textController;

  @override
  State<QRDisplay> createState() => _QRDisplayState(
      //textController
      );
}

class _QRDisplayState extends State<QRDisplay> {
  // final dynamic textController;
  // _QRDisplayState(this.textController);

  @override
  Widget build(BuildContext context) {
    log("textvalue---${widget.data}");
    return Container(
      child: Center(
        child: QrImage(
          data: widget.data,
          backgroundColor: Colors.white,
          size: 300,
        ),
      ),

      //  QrImage(data: textController.toString()),
    );
  }
}
