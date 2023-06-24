import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shca/core/helpers/navigation.dart';
import 'package:shca/modules/events/models/scence.dart';
import 'package:shca/modules/home/blocs/fetchGroupsCubit/fetch_groups_cubit.dart';
import 'package:shca/modules/home/blocs/fetchInterfaces/fetch_interfaces_cubit.dart';
import 'package:shca/modules/home/views/all_devices.dart';
import 'package:shca/modules/home/views/all_rooms.dart';
import 'package:shca/modules/home/views/single_room.dart';
import 'package:shca/modules/events/blocs/fetchScences/fetch_scences_cubit.dart';
import 'package:shca/modules/home/widgets/device_item.dart';
import 'package:shca/widgets/widgets.dart';
import 'package:slider_button/slider_button.dart';
import 'package:utilities/utilities.dart';

import '../../../core/helpers/style_config.dart';
import '../models/group.dart';

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
            const Space.v10(),
            BlocBuilder<FetchScencesCubit, FetchScencesState>(
              builder: (context, state) {
                if (state is FetchScencesFailed) {
                  return ErrorViewer(state.e!);
                }

                if (state is FetchScencesSucceeded) {
                  final scences = state.scences;
                  if (scences.isEmpty) {
                    return const NoDataView();
                  }
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ScenceItem(
                      scence: scences[index],
                    ),
                    separatorBuilder: ((context, index) => const Space.v10()),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
            BlocBuilder<FetchGroupsCubit, FetchGroupsState>(
              builder: (context, state) {
                if (state is FetchGroupsFailed) {
                  return ErrorViewer(state.e!);
                } else if (state is FetchGroupsSucceeded) {
                  final groups = state.groups;
                  if (groups.isEmpty) {
                    return const NoDataView();
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
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        children: List.generate(
                            groups.length > 2 ? 2 : groups.length,
                            (index) => RoomItem(
                                onTap: () => context.navigateTo(
                                      SingleRoomScreen(
                                        group: groups[index],
                                        groups: groups,
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
            const Space.v40()
          ],
        ),
      ),
    );
  }
}

class ScenceItem extends StatelessWidget {
  final Scence scence;
  const ScenceItem({super.key, required this.scence});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // gradient: CColors.blueLinearGradient,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  CupertinoIcons.moon_stars,
                  color: Colors.orange,
                  size: 40,
                ),
                const Space.h15(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        scence.name,
                        style: Style.appTheme.textTheme.bodyLarge!.copyWith(
                            color: Colors.black, height: 1.5, fontSize: 20),
                      ),
                      Text(
                        scence.description,
                        style: Style.appTheme.textTheme.bodySmall!.copyWith(
                            color: Colors.black, height: 1.5, fontSize: 13),
                      ),
                    ],
                  ),
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
                backgroundColor: Colors.grey.shade100,
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
    required this.group,
    required this.onTap,
  }) : super(key: key);

  final Color color;
  final Group group;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                "https://i.pinimg.com/564x/aa/37/d9/aa37d9a07051f6e4d6b1b890b8fa0a2f.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
                height: Style.screenSize.height * 0.2,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name,
                      style: Style.appTheme.textTheme.titleMedium!
                          .copyWith(height: 1.3, color: CColors.black70),
                    ),
                    Text(
                      "${group.interfaces.length} Devices",
                      style: Style.appTheme.textTheme.bodySmall!
                          .copyWith(height: 1.2, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
