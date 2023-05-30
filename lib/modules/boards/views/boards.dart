import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shca/core/helpers/navigation.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/modules/boards/views/qr_scanner.dart';
import 'package:utilities/utilities.dart';

import '../../../generated/assets.gen.dart';
import '../../../widgets/custom_button.dart';

class BoardsScreen extends StatelessWidget {
  const BoardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Space.v10(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Assets.images.vectors.scan.svg(height: 70),
                  title: Text(
                    "Connect new boards by scanning QR code on it.",
                    style: Style.appTheme.textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 17,
                      height: 1.5,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CustomButton(
                      backgroundColor: Colors.indigoAccent,
                      child: const Text("Scan New Board"),
                      onPressed: () =>
                          context.navigateTo(const QrScannerView()),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            itemBuilder: (context, index) => const BoardItem(),
            separatorBuilder: ((context, index) => const Space.v10()),
          ),
        ],
      ),
    );
  }
}

class BoardItem extends StatelessWidget {
  const BoardItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: const Icon(CupertinoIcons.wifi),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Board1"),
                Text(
                  "SHCA4 - 4 Devices",
                  style:
                      Style.appTheme.textTheme.bodySmall!.copyWith(height: 1),
                ),
              ],
            ),
            subtitle: const Text(
              "Active",
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(CupertinoIcons.forward),
              onPressed: () {},
            ),
          ),
        ));
  }
}
