import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shca/generated/assets.gen.dart';
import 'package:utilities/utilities.dart';

import 'package:shca/core/helpers/navigation.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/core/rtc/events.dart';
import 'package:shca/modules/home/blocs/fetchInterfaces/fetch_interfaces_cubit.dart';
import 'package:shca/modules/home/models/interface.dart';
import 'package:shca/modules/home/views/single_device.dart';

import '../../boards/models/board.dart';

extension InterfaceDevicesExtension on InterfaceDevices {
  toAsset({required double value, bool isBW = true}) {
    switch (this) {
      case InterfaceDevices.lamp:
        if (isBW) {
          return Assets.images.vectors.bwLamp.svg();
        } else {
          if (value == 0) {
            return Assets.images.vectors.lampOff.svg();
          } else {
            return Assets.images.vectors.lamp.svg();
          }
        }

      case InterfaceDevices.fan:
        if (isBW) {
          return Assets.images.vectors.bwFan.svg();
        } else {
          if (value == 0) {
            return Assets.images.vectors.fan.svg();
          } else {
            return Assets.images.vectors.fan.svg();
          }
        }

      case InterfaceDevices.ac:
        if (isBW) {
          return Assets.images.vectors.bwAc.svg();
        } else {
          if (value == 0) {
            return Assets.images.vectors.airConditioner.svg();
          } else {
            return Assets.images.vectors.airConditioner.svg();
          }
        }
      case InterfaceDevices.curtain:
        if (isBW) {
          return Assets.images.vectors.bwCurtains.svg();
        } else {
          if (value == 0) {
            return Assets.images.vectors.bwCurtains.svg();
          } else {
            return Assets.images.vectors.bwCurtains.svg();
          }
        }
      case InterfaceDevices.lampshade:
        if (isBW) {
          return Assets.images.vectors.bwDesklamp.svg();
        } else {
          if (value == 0) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Assets.images.vectors.deskLamp.svg(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Assets.images.vectors.deskLamp.svg(),
            );
          }
        }
      case InterfaceDevices.door:
        if (isBW) {
          return Assets.images.vectors.bwDoor.svg();
        } else {
          if (value == 0) {
            return Assets.images.vectors.bwDoor.svg();
          } else {
            return Assets.images.vectors.bwDoor.svg();
          }
        }
      case InterfaceDevices.temperature:
        if (isBW) {
          return Assets.images.vectors.bwTemperature.svg();
        } else {
          if (value > 18) {
            return Assets.images.vectors.hotTemp.svg(height: 300);
          } else {
            return Assets.images.vectors.coldTemp.svg(height: 300);
          }
        }
      case InterfaceDevices.smoke:
        if (isBW) {
          return Assets.images.vectors.bwSmoke.svg();
        } else {
          if (value == 0) {
            return Assets.images.vectors.fireAlarm.svg();
          } else {
            return Assets.images.vectors.fireAlarm.svg();
          }
        }
      case InterfaceDevices.lock:
        if (isBW) {
          return Assets.images.vectors.bwLock.svg();
        } else {
          if (value == 0) {
            return Assets.images.vectors.padlock.svg();
          } else {
            return Assets.images.vectors.padlock.svg();
          }
        }

      default:
        return Assets.images.vectors.info.svg();
    }
  }
}

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
              if (interface.type == InterfaceType.DI) const Space.v10(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                            backgroundColor: CColors.background,
                            radius: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: interface.device != null
                                  ? interface.device!
                                      .toAsset(value: interface.value!)
                                  : InterfaceDevices.lamp
                                      .toAsset(value: interface.value!),
                            )),
                      ),
                      if (interface.type == InterfaceType.DI) ...[
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: CColors.background,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: interface.value == 0
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ],
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (interface.type == InterfaceType.AO ||
                            interface.type == InterfaceType.DO) ...[
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
                        ],
                        if (interface.type == InterfaceType.AI) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              interface.value!.toInt().toString(),
                              style: Style.appTheme.textTheme.bodyLarge!
                                  .copyWith(
                                      height: 1.5,
                                      fontSize: 40,
                                      color: Colors.white),
                            ),
                          ),
                        ],
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
