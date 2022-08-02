import 'package:flutter/material.dart';
import 'package:qr_app/utils/routes/routes_name.dart';
import 'package:qr_app/view/qr_display_screen.dart';
import 'package:qr_app/view/qr_generate.dart';
import 'package:qr_app/view/qr_scan_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.qrScan:
        return MaterialPageRoute(
            builder: (BuildContext context) => const QRScan());

      case RoutesName.qrGenerate:
        return MaterialPageRoute(
            builder: (BuildContext context) => const QRGenerate());
      case RoutesName.qrDisplay:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                const QRDisplay(textController: ""));
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No route defined"),
            ),
          );
        });
    }
  }
}
