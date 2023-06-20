import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shca/generated/assets.gen.dart';
import 'package:shca/modules/boards/models/board.dart';

import 'package:shca/modules/home/models/interface.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:utilities/utilities.dart';

import '../../../core/helpers/style_config.dart';
import '../../../core/rtc/events.dart';
import '../../../core/rtc/socket_io._helper.dart';

class SingleDevice extends StatefulWidget {
  final Color color;
  Interface interface;
  SingleDevice({
    Key? key,
    required this.color,
    required this.interface,
  }) : super(key: key);

  @override
  State<SingleDevice> createState() => _SingleDeviceState();
}

class _SingleDeviceState extends State<SingleDevice> {
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
      log("value: ${widget.interface.value}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: MyBackButton(
                    color: Colors.black87,
                  ),
                )
              ],
            ),
            InkWell(
              splashColor: Colors.grey.shade200,
              highlightColor: Colors.transparent,
              onTap: () {
                setState(() {
                  if (widget.interface.value == 0) {
                    widget.interface = widget.interface.copyWith(value: 1);
                  } else {
                    widget.interface = widget.interface.copyWith(value: 0);
                  }
                });

                //* socket emitting new value
                var data = InterfaceValueChangeData(
                        interfaceId: widget.interface.id,
                        value: widget.interface.value ?? 0)
                    .toMap();
                SocketIOHelper.sendMessage(
                    Events.interfaceValueChanged.name, data);
              },
              child: (widget.interface.value ?? 0) == 0
                  ? Assets.images.vectors.lampOff.svg()
                  : Assets.images.vectors.lamp.svg(),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.interface.name,
                          style: Style.appTheme.textTheme.titleLarge!
                              .copyWith(height: 1, fontSize: 50),
                        ),
                        Text(
                          widget.interface.board!.name,
                          style: Style.appTheme.textTheme.titleMedium!.copyWith(
                            height: 1,
                          ),
                        )
                      ]),
                  if (widget.interface.type == InterfaceType.AO) ...[
                    const Space.v20(),
                    SliderTheme(
                      data: SliderThemeData(
                          trackHeight: 60,
                          activeTrackColor: Colors.orange,
                          thumbShape: SliderComponentShape.noOverlay,
                          overlayShape: SliderComponentShape.noOverlay,
                          valueIndicatorShape: SliderComponentShape.noOverlay),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(40),
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
                                        Events.interfaceValueChanged.name,
                                        data);
                                  }),
                            ),
                            Center(
                              child: Text(
                                ((widget.interface.value ?? 0) * 100)
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
            const Spacer()
          ],
        ),
      ),
    );
  }
}
