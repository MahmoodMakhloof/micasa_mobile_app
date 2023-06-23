import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shca/modules/home/widgets/device_item.dart';
import 'package:shca/widgets/custom_button.dart';
import 'package:utilities/utilities.dart';

import 'package:shca/modules/boards/models/board.dart';
import 'package:shca/modules/home/models/interface.dart';
import 'package:shca/widgets/back_button.dart';

import '../../../core/helpers/style_config.dart';
import '../../../core/rtc/events.dart';
import '../blocs/fetchInterfaces/fetch_interfaces_cubit.dart';

class SingleDeviceScreen extends StatelessWidget {
  final Color color;
  final Interface interface;
  final InterfacesScope scope;
  final void Function(InterfaceValueChangeData) onTap;
  const SingleDeviceScreen({
    Key? key,
    required this.color,
    required this.interface,
    required this.onTap,
    required this.scope,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SingleDeviceView(
      color: color,
      interface: interface,
      onTap: onTap,
      scope: scope,
    );
  }
}

class _SingleDeviceView extends StatelessWidget {
  final Color color;
  final Interface interface;
  final InterfacesScope scope;

  final void Function(InterfaceValueChangeData) onTap;

  const _SingleDeviceView({
    Key? key,
    required this.color,
    required this.interface,
    required this.scope,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const MyBackButton(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SizedBox(
                width: 100,
                child: CustomButton(
                    backgroundColor: CColors.background,
                    onPressed: () {},
                    child: Text(
                      "Edit Device",
                      style: TextStyle(color: CColors.black70),
                    ))),
          ),
        ],
      ),
      body: BlocBuilder<FetchInterfacesCubit, FetchInterfacesState>(
        builder: (context, state) {
          if (state is FetchInterfacesSucceeded) {
            Interface myInterface;
            switch (scope) {
              case InterfacesScope.allBoards:
                myInterface = state.allBoardsInterfaces
                    .singleWhere((i) => i.id == interface.id);
                break;
              case InterfacesScope.singleBoard:
                myInterface = state.singleBoardInterfaces
                    .singleWhere((i) => i.id == interface.id);

                break;
              case InterfacesScope.inGroup:
                myInterface = state.inGroupInterfaces
                    .singleWhere((i) => i.id == interface.id);

                break;
              case InterfacesScope.toGroup:
                myInterface = state.toGroupInterfaces
                    .singleWhere((i) => i.id == interface.id);

                break;
            }

            return Column(
              children: [
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: InkWell(
                      enableFeedback: false,
                      splashColor: Colors.grey.shade200,
                      highlightColor: Colors.transparent,
                      onTap: myInterface.type == InterfaceType.AI ||
                              myInterface.type == InterfaceType.DI
                          ? null
                          : () {
                              if (myInterface.value == 0) {
                                onTap(InterfaceValueChangeData(
                                  interfaceId: myInterface.id,
                                  value: 1,
                                ));
                              } else {
                                onTap(InterfaceValueChangeData(
                                    interfaceId: myInterface.id, value: 0));
                              }
                            },
                      child: myInterface.device != null
                          ? myInterface.device!
                              .toAsset(value: myInterface.value!, isBW: false)
                          : InterfaceDevices.lamp
                              .toAsset(value: myInterface.value!, isBW: false)),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                myInterface.name,
                                style: Style.appTheme.textTheme.titleLarge!
                                    .copyWith(height: 1, fontSize: 50),
                              ),
                              Text(
                                myInterface.board!.name,
                                style: Style.appTheme.textTheme.titleMedium!
                                    .copyWith(
                                  height: 1,
                                ),
                              ),
                            ]),
                      ),
                      if (interface.type == InterfaceType.DI) ...[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CircleAvatar(
                            radius: 33,
                            backgroundColor: CColors.background,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: interface.value == 0
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ],
                      if (interface.type == InterfaceType.AI) ...[
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            interface.value!.toInt().toString(),
                            style: Style.appTheme.textTheme.bodyLarge!.copyWith(
                                height: 1.5,
                                fontSize: 90,
                                color: Colors.black87),
                          ),
                        ),
                      ],
                      if (myInterface.type == InterfaceType.AO) ...[
                        const Space.v20(),
                        SliderTheme(
                          data: SliderThemeData(
                              trackHeight: 60,
                              activeTrackColor: Colors.orange,
                              thumbShape: SliderComponentShape.noOverlay,
                              overlayShape: SliderComponentShape.noOverlay,
                              valueIndicatorShape:
                                  SliderComponentShape.noOverlay),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Slider(
                                        value: myInterface.value ?? 0,
                                        divisions: 5,
                                        onChanged: (newValue) {
                                          onTap(InterfaceValueChangeData(
                                              interfaceId: myInterface.id,
                                              value: newValue));
                                        }),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    ((myInterface.value ?? 0) * 100)
                                        .toInt()
                                        .toString(),
                                    style: Style.appTheme.textTheme.titleLarge!
                                        .copyWith(
                                            color: Colors.white, fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ],
                  ),
                ),
                const Space.v40()
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
