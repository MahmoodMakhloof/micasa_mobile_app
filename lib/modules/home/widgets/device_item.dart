import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shca/core/helpers/navigation.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/core/rtc/events.dart';
import 'package:shca/core/rtc/socket_io._helper.dart';
import 'package:shca/modules/home/models/interface.dart';
import 'package:shca/modules/home/views/single_device.dart';
import 'package:utilities/utilities.dart';

import '../../boards/models/board.dart';

class DeviceItem extends StatefulWidget {
  Interface interface;
  final Color color;
  DeviceItem({
    Key? key,
    required this.color,
    required this.interface,
  }) : super(key: key);

  @override
  State<DeviceItem> createState() => _DeviceItemState();
}

class _DeviceItemState extends State<DeviceItem> {
  @override
  void initState() {
    SocketIOHelper.socket.on("interfaceValueChanged", (data) {
      updateValue(InterfaceValueChangeData.fromMap(data));
    });

    super.initState();
  }

  void updateValue(InterfaceValueChangeData data) {
    if (data.interfaceId == widget.interface.id) {
      setState(() {
        widget.interface = widget.interface.copyWith(value: data.value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => context.navigateTo(
          SingleDevice(color: widget.color, interface: widget.interface)),
      child: Container(
        decoration: BoxDecoration(
            color: widget.color, borderRadius: BorderRadius.circular(10)),
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
                      color: widget.color,
                    ),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Switch(
                            value: (widget.interface.value ?? 0) > 0.0,
                            onChanged: (isOn) {
                              setState(() {
                                if (isOn) {
                                  widget.interface =
                                      widget.interface.copyWith(value: 1);
                                } else {
                                  widget.interface =
                                      widget.interface.copyWith(value: 0);
                                }
                              });

                              //* socket emitting new value
                              var data = InterfaceValueChangeData(
                                      interfaceId: widget.interface.id,
                                      value: widget.interface.value ?? 0)
                                  .toMap();
                              SocketIOHelper.sendMessage(
                                  Events.interfaceValueChanged.name, data);
                            }),
                        Text(
                          widget.interface.name,
                          style: Style.appTheme.textTheme.bodyLarge!
                              .copyWith(height: 1.5, color: Colors.white),
                        ),
                        Text(
                          widget.interface.board!.name,
                          style: Style.appTheme.textTheme.bodyMedium!
                              .copyWith(height: 1.5, color: Colors.white70),
                        )
                      ]),
                ],
              ),
              if (widget.interface.type == InterfaceType.AO) ...[
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
                              value: widget.interface.value ?? 0,
                              divisions: 5,
                              onChanged: (newValue) {
                                setState(() {
                                  widget.interface = widget.interface
                                      .copyWith(value: newValue);
                                });
                                //* socket emitting new value
                                var data = InterfaceValueChangeData(
                                        interfaceId: widget.interface.id,
                                        value: widget.interface.value ?? 0)
                                    .toMap();
                                SocketIOHelper.sendMessage(
                                    Events.interfaceValueChanged.name, data);
                              }),
                        ),
                        Center(
                          child: Text(
                            ((widget.interface.value ?? 0) * 100)
                                .toInt()
                                .toString(),
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
