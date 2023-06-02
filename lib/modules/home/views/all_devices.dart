import 'package:flutter/material.dart';
import 'package:shca/modules/home/views/home.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:utilities/utilities.dart';

import '../models/interface.dart';

class AllDevicesScreen extends StatelessWidget {
  final List<Interface> interfaces;
  const AllDevicesScreen({super.key, required this.interfaces});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyBackButton(),
        title: const Text("All Devices"),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
          padding: const EdgeInsets.all(10),
          itemCount: interfaces.length,
          itemBuilder: ((context, index) => DeviceItem(
              interface: interfaces[index],
              color: getRandomColor(seed: (index + 4).toString()).color))),
    );
  }
}
