import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shca/modules/home/views/home.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:shca/widgets/widgets.dart';
import 'package:utilities/utilities.dart';

class AllRoomsScreen extends StatelessWidget {
  const AllRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyBackButton(),
        title: const Text("All Rooms"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: 100,
                child: TextButton(
                    onPressed: () {}, child: const Text("Add Room"))),
          ),
          // IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.add))
        ],
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3 / 4,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          padding: EdgeInsets.all(10),
          itemCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: ((context, index) => RoomItem(
              color: getRandomColor(seed: (index + 4).toString()).color))),
    );
  }
}
