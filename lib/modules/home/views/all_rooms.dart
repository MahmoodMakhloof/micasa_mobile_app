import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shca/core/helpers/navigation.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/modules/home/blocs/createGroup/create_group_cubit.dart';
import 'package:shca/modules/home/models/group.dart';
import 'package:shca/modules/home/views/add_room.dart';
import 'package:shca/modules/home/views/home.dart';
import 'package:shca/modules/home/views/single_room.dart';
import 'package:shca/modules/home/widgets/room_item.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:shca/widgets/widgets.dart';
import 'package:utilities/utilities.dart';

import '../blocs/fetchGroupsCubit/fetch_groups_cubit.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyBackButton(),
        title: const Text("Rooms"),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.navigateTo(const AddRoomScreen()),
          label: const Text("Add Room")),
      body: BlocBuilder<FetchGroupsCubit, FetchGroupsState>(
        builder: (context, state) {
          if (state is FetchGroupsFailed) {
            return ErrorViewer(state.e!);
          } else if (state is FetchGroupsSucceeded) {
            final groups = state.groups;
            if (groups.isEmpty) {
              return const NoDataView();
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      children: List.generate(
                          groups.length,
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
                  ),
                  const Space.v40(),
                  const Space.v40(),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
