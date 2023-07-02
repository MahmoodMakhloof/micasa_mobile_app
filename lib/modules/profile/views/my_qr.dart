import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:shca/modules/auth/models/user.dart';
import 'package:shca/widgets/back_button.dart';

import '../../../core/helpers/style_config.dart';

class MyQrCodeScreen extends StatelessWidget {
  final UserModel me;
  const MyQrCodeScreen({
    Key? key,
    required this.me,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const MyBackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "My QR Code",
              style: TextStyle(height: 1.2),
            ),
            Text(
              "Make your friends scan your QR code to join their rooms",
              style: Style.appTheme.textTheme.bodySmall!
                  .copyWith(height: 1, fontSize: 10),
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0).copyWith(bottom: 80),
          child: QrImageView(
            data: me.toJson().toString(),
            version: QrVersions.auto,
            gapless: false,
            backgroundColor: Colors.greenAccent.shade100,
            padding: const EdgeInsets.all(20),
            eyeStyle:
                QrEyeStyle(color: CColors.primary, eyeShape: QrEyeShape.square),
            embeddedImage: CachedNetworkImageProvider(
              me.avatar!,
            ),
            embeddedImageStyle: const QrEmbeddedImageStyle(
              size: Size(70, 70),
            ),
          ),
        ),
      ),
    );
  }
}
