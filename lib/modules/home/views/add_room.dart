import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shca/modules/home/blocs/createGroup/create_group_cubit.dart';
import 'package:shca/modules/home/blocs/fetchGroupsCubit/fetch_groups_cubit.dart';
import 'package:shca/modules/home/views/add_devices.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:shca/widgets/custom_button.dart';
import 'package:utilities/utilities.dart';

import '../../../core/helpers/style_config.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/error_viewer.dart';
import '../../../widgets/no_data.dart';
import '../blocs/fetchInterfaces/fetch_interfaces_cubit.dart';
import '../models/interface.dart';

class AddRoomScreen extends StatelessWidget {
  const AddRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateGroupCubit(context.read()),
        ),
        BlocProvider(
          create: (context) => FetchInterfacesCubit(context.read())
            ..fetchInterfaces(scope: InterfacesScope.allBoards),
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
  final List<Interface> _selectedInterfaces = [];

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
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: SizedBox(
                width: 70,
                child: BlocConsumer<CreateGroupCubit, CreateGroupState>(
                  listener: (context, state) {
                    if (state is CreateGroupSucceeded) {
                      context.read<FetchGroupsCubit>().fetchMyGroups();
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                        enabled: _roomNameController.text.isNotEmpty,
                        isLoading: state is CreateGroupInProgress,
                        onPressed: () {
                          if (_roomNameController.text.isNotEmpty) {
                            context.read<CreateGroupCubit>().createNewGroup(
                                name: _roomNameController.text,
                                interfaces: _selectedInterfaces
                                    .map((e) => e.id)
                                    .toList());
                          }
                        },
                        child: const Text("Save"));
                  },
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<FetchInterfacesCubit, FetchInterfacesState>(
                  builder: (context, state) {
                    if (state is FetchInterfacesFailed) {
                      return ErrorViewer(state.e!);
                    } else if (state is FetchInterfacesSucceeded) {
                      final interfaces = state.interfaces;

                      if (interfaces.isEmpty) {
                        return const NoDataView();
                      }
                      return Column(
                        children: [
                          GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5,
                                      childAspectRatio: 100 / 60,
                                      mainAxisSpacing: 5),
                              itemCount: interfaces.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: ((context, index) =>
                                  DeviceSelectItem(
                                      selected: _selectedInterfaces
                                          .contains(interfaces[index]),
                                      interface: interfaces[index],
                                      onChanged: (selected) {
                                        if (selected ?? false) {
                                          setState(() {
                                            _selectedInterfaces
                                                .add(interfaces[index]);
                                          });
                                        } else {
                                          setState(() {
                                            _selectedInterfaces
                                                .remove(interfaces[index]);
                                          });
                                        }
                                      },
                                      color: getRandomColor(
                                              seed: (interfaces[index])
                                                  .toString())
                                          .color))),
                        ],
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
