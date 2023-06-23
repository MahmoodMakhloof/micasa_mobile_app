import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shca/core/helpers/navigation.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/modules/boards/blocs/fetchBoards/fetch_boards_cubit.dart';
import 'package:shca/modules/boards/views/board_details.dart';
import 'package:shca/modules/boards/views/qr_scanner.dart';
import 'package:shca/widgets/widgets.dart';
import 'package:utilities/utilities.dart';

import '../../../generated/assets.gen.dart';
import '../models/board.dart';

class BoardsScreen extends StatelessWidget {
  const BoardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _BoardsView();
  }
}

class _BoardsView extends StatelessWidget {
  const _BoardsView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Space.v10(),
          const ScanWidget(),
          const Space.v10(),
          const NetworksWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  "Boards",
                  style: Style.appTheme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          BlocBuilder<FetchBoardsCubit, FetchBoardsState>(
            builder: (context, state) {
              if (state is FetchBoardsFailed) {
                return ErrorViewer(state.e!);
              } else if (state is FetchBoardsSucceeded) {
                final boards = state.boards;
                if (boards.isEmpty) {
                  return const NoDataView();
                }
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: boards.length,
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      BoardItem(board: boards[index]),
                  separatorBuilder: ((context, index) => const Space.v10()),
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}

class NetworksWidget extends StatelessWidget {
  const NetworksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: NetworkInfo().getWifiName(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var wifiName = snapshot.data;

            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Network",
                        style: Style.appTheme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  const Space.v10(),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Assets.images.vectors.router.svg(height: 50),
                              const Space.h30(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    wifiName!.replaceAll('"', ""),
                                    style: Style.appTheme.textTheme.bodyLarge!
                                        .copyWith(height: 1),
                                  ),
                                  const Text(
                                    "Connected",
                                    style: TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(
                                  CupertinoIcons.forward,
                                  size: 18,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        });
  }
}

class ScanWidget extends StatelessWidget {
  const ScanWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Assets.images.vectors.scan.svg(height: 70),
            title: Text(
              "Connect new boards by scanning QR code on it.",
              style: Style.appTheme.textTheme.titleMedium!.copyWith(
                color: Colors.white,
                fontSize: 17,
                height: 1.5,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CustomButton(
                backgroundColor: Colors.indigoAccent,
                child: const Text("Scan New Board"),
                onPressed: () => context.navigateTo(const QrScannerView()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BoardItem extends StatelessWidget {
  final Board board;
  const BoardItem({
    Key? key,
    required this.board,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.navigateTo(BoardDetailsScreen(board: board)),
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Assets.images.vectors.board.svg(height: 50),
                const Space.h30(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(board.name),
                    Text(
                      "${board.model!.map!.length} Devices",
                      style: Style.appTheme.textTheme.bodySmall!
                          .copyWith(height: 1),
                    ),
                    const Text(
                      "Active",
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.forward,
                    size: 18,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          )),
    );
  }
}
