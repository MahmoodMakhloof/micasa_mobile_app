import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shca/modules/boards/models/board.dart';
import 'package:shca/modules/home/views/home.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:shca/widgets/no_data.dart';
import 'package:utilities/utilities.dart';

import '../../../widgets/error_viewer.dart';
import '../../home/blocs/fetchInterfaces/fetch_interfaces_cubit.dart';

class BoardDetailsScreen extends StatelessWidget {
  final Board board;
  const BoardDetailsScreen({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FetchInterfacesCubit(context.read())
          ..fetchInterfaces(
              scope: InterfacesScope.singleBoards, boardId: board.id),
        child: _BoardDetailsView(board));
  }
}

class _BoardDetailsView extends StatelessWidget {
  const _BoardDetailsView(this.board);

  final Board board;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyBackButton(),
        title: Text(board.name),
      ),
      body: BlocBuilder<FetchInterfacesCubit, FetchInterfacesState>(
        builder: (context, state) {
          if (state is FetchInterfacesFailed) {
            return ErrorViewer(state.e!);
          } else if (state is FetchInterfacesSucceeded) {
            final interfaces = state.interfaces;
            if (interfaces.isEmpty) {
              return const NoDataView();
            }
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemCount: interfaces.length,
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                itemBuilder: ((context, index) => DeviceItem(
                    interface: interfaces[index],
                    color: getRandomColor(seed: (interfaces[index]).toString())
                        .color)));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
