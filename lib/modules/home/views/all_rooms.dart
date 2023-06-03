import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shca/core/helpers/navigation.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/modules/home/blocs/createGroup/create_group_cubit.dart';
import 'package:shca/modules/home/models/group.dart';
import 'package:shca/modules/home/views/add_room.dart';
import 'package:shca/modules/home/views/home.dart';
import 'package:shca/modules/home/views/single_room.dart';
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
        title: const Text("All Rooms"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SizedBox(
                width: 100,
                child: CustomButton(
                    onPressed: () => context.navigateTo(const AddRoomScreen()),
                    child: const Text("Create New"))),
          ),
          // IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.add))
        ],
      ),
      body: BlocBuilder<FetchGroupsCubit, FetchGroupsState>(
        builder: (context, state) {
          if (state is FetchGroupsFailed) {
            return ErrorViewer(state.e!);
          } else if (state is FetchGroupsSucceeded) {
            final groups = state.groups;
            if (groups.isEmpty) {
              return const NoDataView();
            }
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                itemCount: groups.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: ((context, index) => RoomItem(
                    onTap: () => context.navigateTo(
                          SingleRoomScreen(
                            group: groups[index],
                            groups: groups,
                          ),
                        ),
                    group: groups[index],
                    color: getRandomColor(seed: (groups[index].id).toString())
                        .color)));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
