import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shca/core/helpers/navigation.dart';
import 'package:shca/modules/events/models/scence.dart';
import 'package:shca/modules/home/blocs/fetchGroupsCubit/fetch_groups_cubit.dart';
import 'package:shca/modules/home/blocs/fetchInterfaces/fetch_interfaces_cubit.dart';
import 'package:shca/modules/home/views/add_room.dart';
import 'package:shca/modules/home/views/all_devices.dart';
import 'package:shca/modules/home/views/all_rooms.dart';
import 'package:shca/modules/home/views/single_room.dart';
import 'package:shca/modules/home/widgets/device_item.dart';
import 'package:shca/widgets/widgets.dart';
import 'package:slider_button/slider_button.dart';
import 'package:utilities/utilities.dart';

import '../../../core/helpers/style_config.dart';
import '../models/group.dart';
import '../widgets/room_item.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            // const Space.v10(),

            BlocBuilder<FetchGroupsCubit, FetchGroupsState>(
              builder: (context, state) {
                if (state is FetchGroupsFailed) {
                  return ErrorViewer(state.e!);
                } else if (state is FetchGroupsSucceeded) {
                  final groups = state.groups;
                  if (groups.isEmpty) {
                    return const NoDataView();
                  }

                  var myCossAxisCount = 3;
                  if (groups.length < 3) {
                    myCossAxisCount = groups.length;
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rooms",
                            style: Style.appTheme.textTheme.bodyLarge,
                          ),
                          TextButton(
                              onPressed: () =>
                                  context.navigateTo(AllRoomsScreen(
                                    groups: groups,
                                  )),
                              child: const Text("See All Rooms"))
                        ],
                      ),
                      StaggeredGrid.count(
                        crossAxisCount: myCossAxisCount,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        children: List.generate(
                            myCossAxisCount,
                            (index) => RoomItem(
                                onTap: () => context.navigateTo(
                                      SingleRoomScreen(
                                        group: groups[index],
                                      ),
                                    ),
                                group: groups[index],
                                color: getRandomColor(
                                        seed: (groups[index].id).toString())
                                    .color)),
                      ),
                    ],
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
            BlocBuilder<FetchInterfacesCubit, FetchInterfacesState>(
              builder: (context, state) {
                if (state is FetchInterfacesFailed) {
                  return ErrorViewer(state.e!);
                } else if (state is FetchInterfacesSucceeded) {
                  final interfaces = state.allBoardsInterfaces;
                  if (interfaces.isEmpty) {
                    return const NoDataView();
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Devices",
                            style: Style.appTheme.textTheme.bodyLarge,
                          ),
                          TextButton(
                              onPressed: () =>
                                  context.navigateTo(const AllDevicesScreen()),
                              child: const Text("See All Devices"))
                        ],
                      ),
                      StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          children: List.generate(
                              4,
                              (index) => DeviceItem(
                                  scope: InterfacesScope.allBoards,
                                  onTap: (data) => context
                                      .read<FetchInterfacesCubit>()
                                      .updateInterfaceValue(data),
                                  interface: interfaces[index],
                                  color: getRandomColor(
                                          seed: (index + 80967).toString())
                                      .color))),
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            const Space.v40(),
          ],
        ),
      ),
    );
  }
}
