import 'package:flutter/material.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({super.key});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  String? __scanResult;
  Future<void> scanQrCode() async {
    // String qrCodeScanRes = await FlutterBarcodeScanner.scanBarcode(
    //   "#ff6666",
    //   'Cancel',
    //   true,
    //   ScanMode.QR,
    // );
    //
    // debugPrint(qrCodeScanRes);
    // if (!mounted) return;
    // setState(() {
    //   __scanResult = qrCodeScanRes;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Qr Code"),
      ),
      body: Builder(
        builder: (context) => Container(
          alignment: Alignment.center,
          child: Flex(
            direction: Axis.vertical,
            children: [
              ElevatedButton(
                  onPressed: scanQrCode, child: const Text("Scan Qr"))
            ],
          ),
        ),
      ),
    );
  }
}
