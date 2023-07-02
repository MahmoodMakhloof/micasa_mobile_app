import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:utilities/utilities.dart';

import 'package:shca/core/helpers/navigation.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/modules/home/blocs/fetchGroupsCubit/fetch_groups_cubit.dart';
import 'package:shca/modules/home/blocs/fetchInterfaces/fetch_interfaces_cubit.dart';
import 'package:shca/modules/home/models/group.dart';
import 'package:shca/modules/home/views/add_devices.dart';
import 'package:shca/modules/home/views/edit_room.dart';
import 'package:shca/modules/home/widgets/device_item.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:shca/widgets/cutstom_outlined_button.dart';

import '../../../widgets/error_viewer.dart';
import '../../../widgets/no_data.dart';

List<String> avatars = [
  "https://i.pinimg.com/564x/0c/aa/41/0caa41582819fb21fb51439b9b8dc893.jpg",
  "https://i.pinimg.com/564x/08/ce/1e/08ce1e3427ff8214be0e04d5b92c0741.jpg",
  "https://i.pinimg.com/564x/ec/4a/cb/ec4acb4ab0fb3ed15b0c211ab16de9ca.jpg",
];

class SingleRoomScreen extends StatefulWidget {
  final Group group;
  const SingleRoomScreen({
    super.key,
    required this.group,
  });

  @override
  State<SingleRoomScreen> createState() => _SingleRoomScreenState();
}

class _SingleRoomScreenState extends State<SingleRoomScreen> {
  late TextEditingController _controller;
  late Group _myGroup;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.group.name);
    context.read<FetchInterfacesCubit>().fetchInterfaces(
        scope: InterfacesScope.inGroup, groupId: widget.group.id);

    _myGroup = widget.group;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchGroupsCubit, FetchGroupsState>(
      builder: (context, state) {
        if (state is FetchGroupsFailed) {
          return ErrorViewer(state.e!);
        }
        if (state is FetchGroupsSucceeded) {
          final groups = state.groups;
          if (groups.isEmpty) {
            return const NoDataView();
          }
          _myGroup = groups.singleWhere((element) => element.id == _myGroup.id);
          return Scaffold(
            appBar: AppBar(
              leading: const MyBackButton(),
              title: DropdownSearch<Group>(
                dropdownBuilder: (context, selectedItem) {
                  if (selectedItem == null) {
                    return Text(
                      "Select Group",
                      style: Style.appTheme.textTheme.titleMedium!
                          .copyWith(color: Colors.grey.shade400, height: 2.3),
                    );
                  }
                  return SelectionRoomItem(
                    group: selectedItem,
                  );
                },
                filterFn: (item, filter) {
                  return item.name.toLowerCase().contains(filter.toLowerCase());
                },
                dropdownButtonProps: const DropdownButtonProps(
                  icon: Icon(
                    CupertinoIcons.chevron_down,
                    size: 15,
                  ),
                ),
                popupProps: PopupProps.bottomSheet(
                  fit: FlexFit.loose,
                  bottomSheetProps: BottomSheetProps(
                      clipBehavior: Clip.antiAlias,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  listViewProps: const ListViewProps(
                      padding:
                          EdgeInsets.only(bottom: 40, left: 25, right: 25)),
                  itemBuilder: (context, item, isSelected) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: SelectionRoomItem(
                        group: item,
                      ),
                    );
                  },
                  showSelectedItems: false,
                  showSearchBox: true,
                  scrollbarProps: const ScrollbarProps(thickness: 5),
                  searchDelay: Duration.zero,
                  searchFieldProps: const TextFieldProps(
                      decoration: InputDecoration(
                    hintText: "Ex: Bed Room",
                    // border: InputBorder.none,
                  )),
                ),
                items: groups,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      filled: false,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 2),
                      fillColor: Colors.grey.shade200,
                      border: InputBorder.none),
                ),
                onChanged: (group) {
                  if (group != null) {
                    context.read<FetchInterfacesCubit>().fetchInterfaces(
                        scope: InterfacesScope.inGroup, groupId: group.id);
                  }
                },
                selectedItem: _myGroup,
              ),
              actions: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 22),
                    child: SizedBox(
                        width: 60,
                        child: CustomOutlinedButton(
                          onPressed: () => context.navigateTo(UpdateRoomScreen(
                            group: _myGroup,
                          )),
                          child: const Text(
                            "Edit",
                          ),
                        ))),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () =>
                    context.navigateTo(AddDevicesScreen(group: _myGroup)),
                label: const Text("Add Devices")),
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
                                    backgroundImage:
                                        CachedNetworkImageProvider(avatars[0]),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 30),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 22,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              avatars[1]),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 60),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 22,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              avatars[2]),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 90),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 22,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.grey.shade200,
                                      child:
                                          const Icon(CupertinoIcons.ellipsis),
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

        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

class SelectionRoomItem extends StatelessWidget {
  final Group group;
  const SelectionRoomItem({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            height: 30,
            width: 30,
            child: CachedNetworkImage(imageUrl: group.image.url)),
        const Space.h20(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              group.name,
              style:
                  Style.appTheme.textTheme.titleMedium!.copyWith(height: 1.5),
            ),
            Text(
              "${group.interfaces.length}  Devices",
              style: Style.appTheme.textTheme.bodySmall!.copyWith(height: 1.5),
            ),
          ],
        ),
      ],
    );
  }
}
