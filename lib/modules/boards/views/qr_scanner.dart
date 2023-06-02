import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shca/modules/boards/blocs/connectBoard/connect_board_cubit.dart';
import 'package:utilities/utilities.dart';

import '../../../core/helpers/style_config.dart';

class QrScannerView extends StatelessWidget {
  const QrScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectBoardCubit(context.read()),
      child: const _QrScannerView(),
    );
  }
}

class _QrScannerView extends StatefulWidget {
  const _QrScannerView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => __QrScannerViewState();
}

class __QrScannerViewState extends State<_QrScannerView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connect New Board"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () async {
                  await controller?.toggleFlash();
                  setState(() {});
                },
                icon: FutureBuilder(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    return snapshot.data ?? false
                        ? const Icon(
                            Icons.flash_on,
                            size: 25,
                          )
                        : const Icon(
                            Icons.flash_off,
                            size: 25,
                          );
                  },
                )),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 5, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (result != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const CircularProgressIndicator(),
                        const Space.v10(),
                        Text(
                          'Token: ${result!.code}',
                        ),
                      ],
                    ),
                  )
                else
                  const Text(
                      'Scan QR code on the board to connect and control it'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 400.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: CColors.primary,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });

      var token = scanData.code;
      if (token != null && token.isNotEmpty) {
        controller.pauseCamera();
        context.read<ConnectBoardCubit>().connectBoard(token);
        log("Connecting to board....");
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
