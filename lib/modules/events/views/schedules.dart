import 'package:cron_form_field/cron_expression.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shca/modules/events/views/handle_schedule.dart';
import 'package:utilities/utilities.dart';

import 'package:shca/core/helpers/navigation.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/modules/events/blocs/fetchSchedules/fetch_schedules_cubit.dart';
import 'package:shca/modules/events/blocs/updateSchedule/update_schedule_cubit.dart';
import 'package:shca/modules/events/models/schedule.dart';
import 'package:shca/widgets/custom_button.dart';
import 'package:shca/widgets/error_viewer.dart';
import 'package:shca/widgets/no_data.dart';

import '../../../generated/assets.gen.dart';

class SchedulesView extends StatelessWidget {
  const SchedulesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateScheduleCubit(context.read()),
      child: const _ScheduleView(),
    );
  }
}

class _ScheduleView extends StatelessWidget {
  const _ScheduleView();

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
                          context.navigateTo(const HandleScheduleScreen()),
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
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: List.generate(
                      schedules.length,
                      (index) => ScheduleItem(
                        onTap: () => context.navigateTo(HandleScheduleScreen(
                          schedule: schedules[index],
                        )),
                        schedule: schedules[index],
                        onEnabledChange: (isEnabled) => context
                            .read<UpdateScheduleCubit>()
                            .updateSchedule(
                                newSchedule: schedules[index]
                                    .copyWith(enabled: isEnabled)),
                      ),
                    ),
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          const Space.v40()
        ],
      ),
    );
  }
}

class ScheduleItem extends StatefulWidget {
  const ScheduleItem({
    Key? key,
    required this.schedule,
    required this.onEnabledChange,
    required this.onTap,
  }) : super(key: key);

  final Schedule schedule;
  final Function(bool enabled) onEnabledChange;
  final VoidCallback onTap;

  @override
  State<ScheduleItem> createState() => _ScheduleItemState();
}

class _ScheduleItemState extends State<ScheduleItem> {
  late bool isEnabled;

  @override
  void initState() {
    super.initState();
    isEnabled = widget.schedule.enabled;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ).copyWith(top: 10),
                      child: Text(
                        widget.schedule.name,
                        style: Style.appTheme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: CColors.background,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15))),
                      child: SizedBox(
                        width: 60,
                        height: 30,
                        child: Switch(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: isEnabled,
                            onChanged: (value) {
                              setState(() {
                                isEnabled = value;
                                widget.onEnabledChange(value);
                              });
                            }),
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15)
                    .copyWith(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.schedule.cron != null
                          ? cronToReadable(widget.schedule.cron!)
                          : datetimeToFormatted(widget.schedule.datetime!),
                      style: Style.appTheme.textTheme.bodySmall,
                    ),
                    Text(
                      isEnabled ? "Enabled" : "Not Enabled",
                      style: Style.appTheme.textTheme.bodySmall!.copyWith(
                          color: isEnabled ? CColors.primary : Colors.orange),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  String cronToReadable(String cron) {
    return CronExpression.fromString(cron).toReadableString();
  }

  String datetimeToFormatted(String datetime) {
    return DateTime.parse(datetime).toLocalizedDateTimeStr();
  }
}
