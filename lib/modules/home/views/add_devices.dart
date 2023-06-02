import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shca/modules/home/blocs/addInterfacesToGroup/add_interfaces_to_group_cubit.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:utilities/utilities.dart';

import 'package:shca/modules/home/models/interface.dart';
import 'package:shca/widgets/widgets.dart';

import '../../../core/helpers/style_config.dart';
import '../blocs/fetchInterfaces/fetch_interfaces_cubit.dart';
import '../models/group.dart';

class AddDevicesScreen extends StatelessWidget {
  final Group group;

  const AddDevicesScreen({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AddInterfacesToGroupCubit(context.read())),
          BlocProvider(
              create: (context) =>
                  FetchInterfacesCubit(context.read())..fetchInterfaces()),
        ],
        child: _AddDevicesView(
          group: group,
        ));
  }
}

class _AddDevicesView extends StatefulWidget {
  const _AddDevicesView({
    Key? key,
    required this.group,
  }) : super(key: key);
  final Group group;

  @override
  State<_AddDevicesView> createState() => _AddDevicesViewState();
}

class _AddDevicesViewState extends State<_AddDevicesView> {
  final TextEditingController _controller = TextEditingController();

  final List<Interface> _selectedInterfaces = [];

  List<Interface> _filteredInterfaces = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyBackButton(),
        title: SizedBox(
          height: 50,
          child: CTextField(
            controller: _controller,
            hint: "Search Devices",
            onChanged: (value) {
              setState(() {
                _filteredInterfaces = _filteredInterfaces
                    .where((element) => element.name.contains(value))
                    .toList();
              });
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
                width: 100,
                child: CustomButton(
                    enabled: _selectedInterfaces.isNotEmpty,
                    onPressed: () => context.read<AddInterfacesToGroupCubit>()
                      ..addInterfacesToGroup(
                          groupId: widget.group.id,
                          interfacesIds:
                              _selectedInterfaces.map((e) => e.id).toList()),
                    child: const Text("Add"))),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              BlocBuilder<FetchInterfacesCubit, FetchInterfacesState>(
                builder: (context, state) {
                  if (state is FetchInterfacesFailed) {
                    return ErrorViewer(state.e!);
                  } else if (state is FetchInterfacesSucceeded) {
                    _filteredInterfaces = state.interfaces
                        .where((element) =>
                            !widget.group.interfaces.contains(element.id))
                        .toList();

                    if (_filteredInterfaces.isEmpty) {
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
                            itemCount: _filteredInterfaces.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: ((context, index) => DeviceSelectItem(
                                selected: _selectedInterfaces
                                    .contains(_filteredInterfaces[index]),
                                interface: _filteredInterfaces[index],
                                onChanged: (selected) {
                                  if (selected ?? false) {
                                    setState(() {
                                      _selectedInterfaces
                                          .add(_filteredInterfaces[index]);
                                    });
                                  } else {
                                    setState(() {
                                      _selectedInterfaces
                                          .remove(_filteredInterfaces[index]);
                                    });
                                  }
                                },
                                color: getRandomColor(
                                        seed: (_filteredInterfaces[index])
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
      ),
    );
  }
}

class DeviceSelectItem extends StatelessWidget {
  final Interface interface;
  final bool selected;
  final Function(bool?) onChanged;
  final Color color;
  const DeviceSelectItem({
    Key? key,
    required this.interface,
    required this.onChanged,
    required this.color,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundColor: CColors.background,
            radius: 30,
            child: Icon(
              FontAwesomeIcons.lightbulb,
              color: color,
            ),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Checkbox(
                value: selected,
                onChanged: onChanged,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(2))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    interface.name,
                    style: Style.appTheme.textTheme.bodyLarge!
                        .copyWith(height: 1.5, color: Colors.white),
                  ),
                  Text(
                    interface.board!.name,
                    style: Style.appTheme.textTheme.bodyMedium!
                        .copyWith(height: 1.5, color: Colors.white70),
                  ),
                ],
              ),
            )
          ]),
        ],
      ),
    );
  }
}
