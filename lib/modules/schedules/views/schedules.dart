import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/widgets/custom_button.dart';
import 'package:utilities/utilities.dart';

import '../../../generated/assets.gen.dart';

class SchedulesView extends StatelessWidget {
  const SchedulesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Space.v10(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Assets.images.vectors.schedule.svg(height: 70),
                  title: Text(
                    "Schedule is some actions executed on specific time you choose.",
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
                      child: const Text("Create New Schedule"),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            itemBuilder: (context, index) => const ScheduleItem(),
            separatorBuilder: ((context, index) => const Space.v10()),
          ),
        ],
      ),
    );
  }
}

class ScheduleItem extends StatelessWidget {
  const ScheduleItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: Icon(FontAwesomeIcons.clock),
          title: Text("Turn off all fans after midnight"),
          subtitle: Text("Everyday at 08:00 PM"),
          trailing: Switch(value: false, onChanged: (value) {}),
        ));
  }
}
