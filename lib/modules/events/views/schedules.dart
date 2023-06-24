import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shca/core/helpers/navigation.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/modules/events/blocs/fetchSchedules/fetch_schedules_cubit.dart';
import 'package:shca/modules/events/models/schedule.dart';
import 'package:shca/modules/events/views/create_schedule.dart';
import 'package:shca/widgets/custom_button.dart';
import 'package:shca/widgets/error_viewer.dart';
import 'package:shca/widgets/no_data.dart';
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
                      onPressed: () =>
                          context.navigateTo(const CreateScheuleScreen()),
                    ),
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<FetchSchedulesCubit, FetchSchedulesState>(
            builder: (context, state) {
              if (state is FetchSchedulesFailed) {
                return ErrorViewer(state.e!);
              } else if (state is FetchSchedulesSucceeded) {
                final schedules = state.schedules;
                if (schedules.isEmpty) {
                  return const NoDataView();
                }
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: schedules.length,
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ScheduleItem(
                    schedule: schedules[index],
                  ),
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

class ScheduleItem extends StatelessWidget {
  const ScheduleItem({
    Key? key,
    required this.schedule,
  }) : super(key: key);

  final Schedule schedule;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: schedule.enabled
                ? CColors.primary.withOpacity(0.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: const Icon(FontAwesomeIcons.clock),
          title: Text(schedule.name),
          subtitle: Text(cronToTime(schedule.cron)),
          trailing: Switch(value: schedule.enabled, onChanged: (value) {}),
        ));
  }

  String cronToTime(String cron) {
    final elements = cron.split(" ");
    final m = elements[1];
    final h = elements[2];
    var trueH = (int.parse(h) < 12 ? h : int.parse(h) - 12).toString();

    var postfix = h == trueH ? "AM" : "PM";

    return "$trueH:$m $postfix";
  }
}
