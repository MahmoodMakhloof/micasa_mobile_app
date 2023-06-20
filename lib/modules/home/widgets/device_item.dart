import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:utilities/utilities.dart';

import 'package:shca/core/helpers/navigation.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/core/rtc/events.dart';
import 'package:shca/modules/home/blocs/fetchInterfaces/fetch_interfaces_cubit.dart';
import 'package:shca/modules/home/models/interface.dart';
import 'package:shca/modules/home/views/single_device.dart';

import '../../boards/models/board.dart';

class DeviceItem extends StatelessWidget {
  final Interface interface;
  final InterfacesScope scope;
  final Color color;
  final void Function(InterfaceValueChangeData) onTap;
  const DeviceItem({
    Key? key,
    required this.interface,
    required this.scope,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        context.navigateTo(BlocProvider<FetchInterfacesCubit>.value(
            value: context.read(),
            child: SingleDeviceScreen(
                scope: scope,
                onTap: onTap,
                color: color,
                interface: interface)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Column(
            children: [
              Row(
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
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Switch(
                            value: (interface.value ?? 0) > 0.0,
                            onChanged: (isOn) {
                              if (isOn) {
                                onTap(InterfaceValueChangeData(
                                    interfaceId: interface.id, value: 1));
                              } else {
                                onTap(InterfaceValueChangeData(
                                    interfaceId: interface.id, value: 0));
                              }
                            }),
                        Text(
                          interface.name,
                          style: Style.appTheme.textTheme.bodyLarge!
                              .copyWith(height: 1.5, color: Colors.white),
                        ),
                        Text(
                          interface.board!.name,
                          style: Style.appTheme.textTheme.bodyMedium!
                              .copyWith(height: 1.5, color: Colors.white70),
                        )
                      ]),
                ],
              ),
              if (interface.type == InterfaceType.AO) ...[
                const Space.v20(),
                SliderTheme(
                  data: SliderThemeData(
                      trackHeight: 40,
                      activeTrackColor: Colors.orange,
                      thumbShape: SliderComponentShape.noOverlay,
                      overlayShape: SliderComponentShape.noOverlay,
                      valueIndicatorShape: SliderComponentShape.noOverlay),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Slider(
                              value: interface.value ?? 0,
                              divisions: 5,
                              onChanged: (newValue) {
                                onTap(InterfaceValueChangeData(
                                    interfaceId: interface.id,
                                    value: newValue));
                              }),
                        ),
                        Center(
                          child: Text(
                            ((interface.value ?? 0) * 100).toInt().toString(),
                            style: Style.appTheme.textTheme.titleLarge!
                                .copyWith(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
              const Space.v15()
            ],
          ),
        ),
      ),
    );
  }
}
