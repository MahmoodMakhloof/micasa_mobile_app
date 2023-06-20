import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/modules/home/blocs/fetchInterfaces/fetch_interfaces_cubit.dart';
import 'package:shca/modules/home/models/group.dart';
import 'package:shca/modules/home/views/add_devices.dart';
import 'package:shca/modules/home/widgets/device_item.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:shca/widgets/custom_button.dart';
import 'package:utilities/utilities.dart';
import '../../../widgets/error_viewer.dart';
import '../../../widgets/no_data.dart';

List<String> avatars = [
  "https://i.pinimg.com/564x/0c/aa/41/0caa41582819fb21fb51439b9b8dc893.jpg",
  "https://i.pinimg.com/564x/08/ce/1e/08ce1e3427ff8214be0e04d5b92c0741.jpg",
  "https://i.pinimg.com/564x/ec/4a/cb/ec4acb4ab0fb3ed15b0c211ab16de9ca.jpg",
];

class SingleRoomScreen extends StatefulWidget {
  final Group group;
  final List<Group> groups;
  const SingleRoomScreen(
      {super.key, required this.group, required this.groups});

  @override
  State<SingleRoomScreen> createState() => _SingleRoomScreenState();
}

class _SingleRoomScreenState extends State<SingleRoomScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FetchInterfacesCubit>().fetchInterfaces(
        scope: InterfacesScope.inGroup, groupId: widget.group.id);
  }

  @override
  Widget build(BuildContext context) {
    return _SingleRoomView(group: widget.group, groups: widget.groups);
  }
}

class _SingleRoomView extends StatefulWidget {
  final Group group;
  final List<Group> groups;
  const _SingleRoomView({required this.group, required this.groups});

  @override
  State<_SingleRoomView> createState() => __SingleRoomViewState();
}

class __SingleRoomViewState extends State<_SingleRoomView> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.group.name);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyBackButton(),
        title: CustomDropdown.search(
          hintText: 'Select Room',
          items: widget.groups.map((e) => e.name).toList(),
          controller: _controller,
          onChanged: (groupName) => context
              .read<FetchInterfacesCubit>()
              .fetchInterfaces(
                  scope: InterfacesScope.inGroup,
                  groupId: widget.groups
                      .firstWhere((element) => element.name == groupName)
                      .id),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SizedBox(
                width: 100,
                child: CustomButton(
                    onPressed: () async {
                      final reLoadPage = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddDevicesScreen(
                                group: widget.groups.firstWhere((element) =>
                                    element.name == _controller.text))),
                      );

                      if (reLoadPage) {
                        context.read<FetchInterfacesCubit>().fetchInterfaces(
                            scope: InterfacesScope.inGroup,
                            groupId: widget.group.id);
                      }
                    },
                    child: const Text("Add Devices"))),
          ),
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
                      const Icon(CupertinoIcons.forward)
                    ],
                  ),
                ),
              ),
              const Space.v10(),
              BlocBuilder<FetchInterfacesCubit, FetchInterfacesState>(
                builder: (context, state) {
                  if (state is FetchInterfacesFailed) {
                    return ErrorViewer(state.e!);
                  } else if (state is FetchInterfacesSucceeded) {
                    final interfaces = state.inGroupInterfaces;
                    if (interfaces.isEmpty) {
                      return const NoDataView();
                    }
                    return StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: List.generate(
                            interfaces.length,
                            (index) => DeviceItem(
                              scope: InterfacesScope.inGroup,
                                onTap: (data) => context
                                    .read<FetchInterfacesCubit>()
                                    .updateInterfaceValue(data),
                                interface: interfaces[index],
                                color: getRandomColor(
                                        seed: (index + 80967).toString())
                                    .color)));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              const Space.v30()
            ],
          ),
        ),
      ),
    );
  }
}
