import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shca/modules/home/views/home.dart';
import 'package:shca/modules/home/widgets/device_item.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:shca/widgets/no_data.dart';
import 'package:utilities/utilities.dart';

import '../../../widgets/error_viewer.dart';
import '../../home/blocs/fetchInterfaces/fetch_interfaces_cubit.dart';

class AllDevicesScreen extends StatelessWidget {
  const AllDevicesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const _AllDevicesView();
  }
}

class _AllDevicesView extends StatelessWidget {
  const _AllDevicesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Devices"),
        leading: const MyBackButton(),
      ),
      body: BlocBuilder<FetchInterfacesCubit, FetchInterfacesState>(
        builder: (context, state) {
          if (state is FetchInterfacesFailed) {
            return ErrorViewer(state.e!);
          } else if (state is FetchInterfacesSucceeded) {
            final interfaces = state.allBoardsInterfaces;
            if (interfaces.isEmpty) {
              return const NoDataView();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: List.generate(
                            interfaces.length,
                            (index) => DeviceItem(
                              scope: InterfacesScope.allBoards,
                                onTap: (data) => context
                                    .read<FetchInterfacesCubit>()
                                    .updateInterfaceValue(data),
                                interface: interfaces[index],
                                color: getRandomColor(
                                        seed: (index + 80967).toString())
                                    .color))),
                    const Space.v30()
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
