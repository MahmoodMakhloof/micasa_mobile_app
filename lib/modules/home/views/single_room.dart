import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/modules/home/views/home.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:shca/widgets/custom_button.dart';
import 'package:utilities/utilities.dart';

List<String> avatars = [
  "https://i.pinimg.com/564x/0c/aa/41/0caa41582819fb21fb51439b9b8dc893.jpg",
  "https://i.pinimg.com/564x/08/ce/1e/08ce1e3427ff8214be0e04d5b92c0741.jpg",
  "https://i.pinimg.com/564x/ec/4a/cb/ec4acb4ab0fb3ed15b0c211ab16de9ca.jpg",
];

class SingleRoomScreen extends StatelessWidget {
  const SingleRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyBackButton(),
        title: CustomDropdown.search(
          hintText: 'Select Room',
          items: const ['Bed Room', 'Kitchen', 'Bath Room', 'Salon'],
          controller: TextEditingController(text: "Bed Room"),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
                width: 100,
                child: CustomButton(
                    onPressed: () {}, child: const Text("Add Device"))),
          ),
          // IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 22,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(avatars[0]),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 30),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 22,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(avatars[1]),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 60),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 22,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(avatars[2]),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 90),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 22,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey.shade200,
                                child: const Icon(CupertinoIcons.ellipsis),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Space.h15(),
                      Expanded(
                          child: Text(
                        "Mona, Mahmoud and 3 others connected this room.",
                        style: Style.appTheme.textTheme.titleMedium!
                            .copyWith(height: 1.2),
                      )),
                      const Space.h15(),
                      Icon(CupertinoIcons.forward)
                    ],
                  ),
                ),
              ),
              const Space.v10(),
              GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) => DeviceItem(
                      color: getRandomColor(seed: (index + 80967).toString())
                          .color))),
            ],
          ),
        ),
      ),
    );
  }
}
