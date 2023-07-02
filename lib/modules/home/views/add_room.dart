import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/modules/home/blocs/createGroup/create_group_cubit.dart';
import 'package:shca/modules/home/blocs/fetchGroupPics/fetch_group_pics_cubit.dart';
import 'package:shca/modules/home/blocs/fetchGroupsCubit/fetch_groups_cubit.dart';
import 'package:shca/modules/home/views/edit_room.dart';
import 'package:shca/widgets/back_button.dart';

import '../../../widgets/custom_text_field.dart';
import '../../../widgets/no_data.dart';
import '../models/group.dart';

class AddRoomScreen extends StatelessWidget {
  const AddRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateGroupCubit(context.read()),
        ),
      ],
      child: const _AddRoomView(),
    );
  }
}

class _AddRoomView extends StatefulWidget {
  const _AddRoomView();

  @override
  State<_AddRoomView> createState() => _AddRoomViewState();
}

class _AddRoomViewState extends State<_AddRoomView> {
  @override
  void dispose() {
    _roomNameController.dispose();
    super.dispose();
  }

  final TextEditingController _roomNameController = TextEditingController();
  GroupPic? _selectedPic;

  isEnabled() {
    return _roomNameController.text.isNotEmpty && _selectedPic != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CTextField(
            hint: "Ex: BedRoom",
            fontSize: 20,
            onChanged: (p0) {
              setState(() {});
            },
            controller: _roomNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "the name is required";
              }
              return null;
            },
          ),
          leading: const MyBackButton(),
        ),
        floatingActionButton: BlocConsumer<CreateGroupCubit, CreateGroupState>(
          listener: (context, state) {
            if (state is CreateGroupSucceeded) {
              context.read<FetchGroupsCubit>().fetchMyGroups();
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return FloatingActionButton.extended(
                backgroundColor: isEnabled() ? CColors.primary : Colors.grey,
                onPressed: isEnabled()
                    ? () {
                        context.read<CreateGroupCubit>().createNewGroup(
                            name: _roomNameController.text,
                            image: _selectedPic!.id);
                      }
                    : null,
                label: state is CreateGroupInProgress
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text("Save Changes"));
          },
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<FetchGroupPicsCubit, FetchGroupPicsState>(
                    builder: ((context, state) {
                  if (state is FetchGroupPicsFailed) {
                    return ErrorWidget(state.e!);
                  }
                  if (state is FetchGroupPicsSucceeded) {
                    final images = state.pics;
                    if (images.isEmpty) {
                      return const NoDataView();
                    } else {
                      return GridView.builder(
                          itemCount: images.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 10),
                          padding: const EdgeInsets.all(10),
                          itemBuilder: ((context, index) => PicSelectWidget(
                                image: images[index],
                                isSelected: _selectedPic == images[index],
                                onTap: () {
                                  setState(() {
                                    _selectedPic = images[index];
                                  });
                                },
                              )));
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                }))
              ],
            ),
          ),
        ));
  }
}
