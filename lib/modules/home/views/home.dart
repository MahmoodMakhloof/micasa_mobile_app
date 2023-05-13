import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shca/core/helpers/navigation.dart';
import 'package:shca/modules/home/views/all_rooms.dart';
import 'package:shca/modules/home/views/single_room.dart';
import 'package:slider_button/slider_button.dart';
import 'package:utilities/utilities.dart';

import '../../../core/helpers/style_config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomeView();
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const Space.v10(),
            
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 1,
              shrinkWrap: true,
              itemBuilder: (context, index) => const ScenceItem(),
              separatorBuilder: ((context, index) => const Space.v10()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rooms",
                  style: Style.appTheme.textTheme.bodyLarge,
                ),
                TextButton(
                    onPressed: () => context.navigateTo(const AllRoomsScreen()),
                    child: const Text("See All Rooms"))
              ],
            ),
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                itemCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) => RoomItem(
                    color:
                        getRandomColor(seed: (index + 4).toString()).color))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Devices",
                  style: Style.appTheme.textTheme.bodyLarge,
                ),
                TextButton(
                    onPressed: () {}, child: const Text("See All Devices"))
              ],
            ),
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) => DeviceItem(
                    color: getRandomColor(seed: (index + 80967).toString())
                        .color))),
            const Space.v40()
          ],
        ),
      ),
    );
  }
}

class ScenceItem extends StatelessWidget {
  const ScenceItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: CColors.blueLinearGradient,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  CupertinoIcons.moon_stars,
                  color: Colors.white,
                  size: 40,
                ),
                const Space.h15(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Comming Home",
                      style: Style.appTheme.textTheme.bodyLarge!.copyWith(
                          color: Colors.white, height: 1.5, fontSize: 20),
                    ),
                    Text(
                      "Turn on the light and air conditioner",
                      style: Style.appTheme.textTheme.bodySmall!.copyWith(
                          color: Colors.white, height: 1.5, fontSize: 13),
                    ),
                  ],
                )
              ],
            ),
            const Space.v15(),
            SliderButton(
                width: double.infinity,
                action: () {
                  ///Do something here
                },
                alignLabel: Alignment.center,
                label: Text(
                  "Slide to run scence",
                  style: TextStyle(
                      color: CColors.background,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
                ),
                buttonColor: Colors.black,
                backgroundColor: Colors.white,
                buttonSize: 40,
                height: 50,
                icon: const Icon(
                  CupertinoIcons.power,
                  color: Colors.white,
                ))
          ],
        ),
      ),
    );
  }
}

class RoomItem extends StatelessWidget {
  const RoomItem({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => context.navigateTo(const SingleRoomScreen()),
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Icon(
                FontAwesomeIcons.bed,
                color: color,
              ),
            ),
          ),
          Text(
            "Bed Room",
            style: Style.appTheme.textTheme.bodyLarge!
                .copyWith(height: 1.5, color: Colors.white),
          ),
          Text(
            "5 Devices",
            style: Style.appTheme.textTheme.bodySmall!
                .copyWith(height: 1.5, color: Colors.white70),
          )
        ]),
      ),
    );
  }
}

class DeviceItem extends StatelessWidget {
  const DeviceItem({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundColor: CColors.background,
                  radius: 30,
                  child: Icon(
                    FontAwesomeIcons.lightbulb,
                    color: color,
                  ),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Switch(value: true, onChanged: (value) {}),
                      Text(
                        "Lamp1",
                        style: Style.appTheme.textTheme.bodyLarge!
                            .copyWith(height: 1.5, color: Colors.white),
                      ),
                      Text(
                        "BedRoom",
                        style: Style.appTheme.textTheme.bodyMedium!
                            .copyWith(height: 1.5, color: Colors.white70),
                      )
                    ]),
              ],
            ),
            const Space.v20(),
            SliderTheme(
              data: SliderThemeData(
                  trackHeight: 40,
                  activeTrackColor: Colors.orangeAccent,
                  thumbShape: SliderComponentShape.noOverlay,
                  overlayShape: SliderComponentShape.noOverlay,
                  valueIndicatorShape: SliderComponentShape.noOverlay),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Stack(
                  children: [
                    Slider(label: "50", value: .50, onChanged: (value) {}),
                    Center(
                      child: Text(
                        "50",
                        style: Style.appTheme.textTheme.bodyLarge!
                            .copyWith(color: Colors.white, fontSize: 20),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
