import 'package:flutter/material.dart';
import 'package:qr_app/view/qr_display_screen.dart';

class QRGenerate extends StatefulWidget {
  const QRGenerate({Key? key}) : super(key: key);

  @override
  State<QRGenerate> createState() => _QRGenerateState();
}

class _QRGenerateState extends State<QRGenerate> {
  final textControllerValue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 215, 215, 215),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // QrImage(
            //   data: textControllerValue.text,
            //   size: 250,
            //   backgroundColor: Colors.white,
            // ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: textControllerValue,
                      decoration: InputDecoration(
                        hintText: "Enter here",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.done_all),
                    onPressed: () {
                      //Navigator.pushNamed(context, RoutesName.qrDisplay);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => QRDisplay(
                                textController: textControllerValue.text,
                              )));
                    },
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
