import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shca/core/helpers/navigation.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/modules/home/blocs/createGroup/create_group_cubit.dart';
import 'package:shca/modules/home/models/group.dart';
import 'package:shca/modules/home/views/home.dart';
import 'package:shca/modules/home/views/single_room.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:shca/widgets/widgets.dart';
import 'package:utilities/utilities.dart';

class AllRoomsScreen extends StatelessWidget {
  final List<Group> groups;
  const AllRoomsScreen({super.key, required this.groups});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateGroupCubit(context.read()),
      child: _AllRoomsView(groups),
    );
  }
}

class _AllRoomsView extends StatefulWidget {
  final List<Group> groups;
  const _AllRoomsView(this.groups);

  @override
  State<_AllRoomsView> createState() => _AllRoomsViewState();
}

class _AllRoomsViewState extends State<_AllRoomsView> {
  final TextEditingController _roomNameController = TextEditingController();

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
                    onPressed: () => showDialog(
                        context: context,
                        builder: (_) => Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Colors.grey.shade300)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey.shade200),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 5),
                                            child: Text(
                                              'Adding Room',
                                              style: Style.appTheme.textTheme
                                                  .titleMedium,
                                            ),
                                          ),
                                        ),
                                        const Space.v10(),
                                        CTextField(
                                            autoFocus: true,
                                            fontSize: 25,
                                            hint: "Ex: BedRoom",
                                            controller: _roomNameController),
                                        const Space.v10(),
                                        CustomButton(
                                            onPressed: () {
                                              if (_roomNameController
                                                  .text.isNotEmpty) {
                                                context
                                                    .read<CreateGroupCubit>()
                                                    .createNewGroup(
                                                        _roomNameController
                                                            .text);
                                                _roomNameController.clear();
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text("Confirm"))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                    child: const Text("Add Room"))),
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
          padding: const EdgeInsets.all(10),
          itemCount: widget.groups.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: ((context, index) => RoomItem(
              group: widget.groups[index],
              onTap: () => context.navigateTo(SingleRoomScreen(
                  group: widget.groups[index], groups: widget.groups)),
              color: getRandomColor(seed: (index + 4).toString()).color))),
    );
  }
}
