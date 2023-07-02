import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shca/core/rtc/events.dart';
import 'package:shca/modules/home/blocs/fetchInterfaces/fetch_interfaces_cubit.dart';
import 'package:slider_button/slider_button.dart';
import 'package:utilities/utilities.dart';

import '../../../core/helpers/style_config.dart';
import '../models/scence.dart';

class ScenceItem extends StatelessWidget {
  final Scence scence;
  final VoidCallback onTap;
  const ScenceItem({super.key, required this.scence, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            scence.name,
                            style: Style.appTheme.textTheme.bodyLarge!.copyWith(
                                color: Colors.black87,
                                height: 1.5,
                                fontSize: 18),
                          ),
                          Text(
                            eventsToDesc(scence.events),
                            style: Style.appTheme.textTheme.bodySmall!.copyWith(
                                color: Colors.black45,
                                height: 1.5,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const Space.h10(),
                    Icon(
                      CupertinoIcons.sun_dust,
                      color: CColors.primary,
                      size: 40,
                    ),
                  ],
                ),
              ),
              const Space.v15(),
              Padding(
                padding: const EdgeInsets.all(0),
                child: SliderButton(
                    action: () {
                      for (var e in scence.events) {
                        context
                            .read<FetchInterfacesCubit>()
                            .updateInterfaceValue(InterfaceValueChangeData(
                                interfaceId: e.interfaceId!, value: e.value!));
                      }
                    },
                    alignLabel: Alignment.center,
                    label: Text(
                      "Slide to run",
                      style: TextStyle(
                          color: CColors.background,
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                    buttonColor: Colors.orange,
                    backgroundColor: Colors.white,
                    buttonSize: 30,
                    height: 45,
                    width: (Style.screenSize.width - 40) / 2,
                    radius: 10,
                    icon: const Icon(
                      CupertinoIcons.power,
                      color: Colors.white,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  String eventsToDesc(List<Event> events) {
    List<Event> onEvents =
        events.where((element) => element.value! > 0).toList();
    List<Event> offEvents =
        events.where((element) => element.value! == 0).toList();

    var onStr = '';

    var offStr = '';

    if (onEvents.isNotEmpty) {
      onStr = "${onEvents.length} Devices will be turned on ";
    }

    if (offEvents.isNotEmpty) {
      offStr =
          "${offEvents.length} ${onStr.isNotEmpty ? "others" : "Devices"} will be turned off ";
    }

    var space = (onStr.isNotEmpty && offStr.isNotEmpty) ? "and " : "";

    var str = onStr + space + offStr;

    return str;
  }
}
