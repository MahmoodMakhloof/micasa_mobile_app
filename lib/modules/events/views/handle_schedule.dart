import 'dart:developer';

import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:shca/modules/events/blocs/deleteSchedule/delete_schedule_cubit.dart';
import 'package:shca/modules/events/blocs/updateSchedule/update_schedule_cubit.dart';
import 'package:shca/modules/events/widgets/event.dart';
import 'package:utilities/utilities.dart';
import 'package:weekday_selector/weekday_selector.dart';

import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/modules/events/blocs/createSchedule/create_schedule_cubit.dart';
import 'package:shca/modules/events/blocs/fetchEventInterfaces/fetch_event_intefaces_cubit.dart';
import 'package:shca/modules/events/blocs/fetchSchedules/fetch_schedules_cubit.dart';
import 'package:shca/modules/events/models/scence.dart';
import 'package:shca/modules/events/models/schedule.dart';
import 'package:shca/modules/events/views/handle_scence.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:shca/widgets/widgets.dart';

import '../../../widgets/cutstom_outlined_button.dart';

class HandleScheduleScreen extends StatelessWidget {
  final Schedule? schedule;
  const HandleScheduleScreen({
    Key? key,
    this.schedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateScheduleCubit(context.read()),
        ),
        BlocProvider(
          create: (context) => UpdateScheduleCubit(context.read()),
        ),
        BlocProvider(
          create: (context) => DeleteScheduleCubit(context.read()),
        ),
       
      ],
      child: _HandleScheduleView(schedule),
    );
  }
}

class _HandleScheduleView extends StatefulWidget {
  final Schedule? schedule;
  const _HandleScheduleView(this.schedule);

  @override
  State<_HandleScheduleView> createState() => _HandleScheduleViewState();
}

class _HandleScheduleViewState extends State<_HandleScheduleView> {
  _HandleScheduleViewState();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  List<Event> _events = [];

  final TextEditingController _nameController = TextEditingController();


  bool _isRepeated = true;

  DateTime _selectedDate = DateTime.now();

  Time _time = Time(hour: DateTime.now().hour, minute: DateTime.now().minute);

  //* legacy events
  late final String? _legacyEvents;

  @override
  void initState() {
    super.initState();
    handleUpdateMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CTextField(
          hint: "Ex: Dark mode",
          fontSize: 20,
          onChanged: (p0) {
            setState(() {});
          },
          controller: _nameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "the name is required";
            }
            return null;
          },
        ),
        leading: const MyBackButton(),
        actions: [
          if (widget.schedule != null)
            BlocConsumer<DeleteScheduleCubit, DeleteScheduleState>(
              listener: (context, state) {
                if (state is DeleteScheduleSucceeded) {
                  context.read<FetchSchedulesCubit>().fetchMySchedules();
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 22),
                    child: SizedBox(
                        width: 60,
                        child: CustomOutlinedButton(
                          isLoading: state is DeleteScheduleInProgress,
                          borderColor: Colors.red,
                          onPressed: () => context
                              .read<DeleteScheduleCubit>()
                              .deleteSchedule(schedule: widget.schedule!),
                          child: const Text(
                            "Delete",
                          ),
                        )));
              },
            ),
          const Space.h10(),
        ],
      ),
      floatingActionButton: widget.schedule == null
          ? BlocConsumer<CreateScheduleCubit, CreateScheduleState>(
              listener: (context, state) {
                if (state is CreateScheduleSucceeded) {
                  context.read<FetchSchedulesCubit>().fetchMySchedules();
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return FloatingActionButton.extended(
                    backgroundColor:
                        _isEnabled() ? CColors.primary : Colors.grey,
                    onPressed: !_isEnabled()
                        ? null
                        : () {
                            String? datetime;
                            String? cron;
                            var days = _days
                                .where((element) => element.isSelected)
                                .toList();
                            if (_isRepeated && days.isNotEmpty) {
                              datetime = null;
                              cron = _convertScheduleDataToCron(
                                  days: days, time: _time);
                            } else {
                              cron = null;
                              datetime = _selectedDate
                                  .copyWith(
                                      hour: _time.hour, minute: _time.minute)
                                  .toIso8601String();
                              log("datetime ==> $datetime");
                            }
                            context
                                .read<CreateScheduleCubit>()
                                .createNewSchedule(
                                    name: _nameController.text,
                                    cron: cron,
                                    datetime: datetime,
                                    events: _events);
                          },
                    label: state is CreateScheduleInProgress
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text("Save Changes"));
              },
            )
          : BlocConsumer<UpdateScheduleCubit, UpdateScheduleState>(
              listener: (context, state) {
                if (state is UpdateScheduleSucceeded) {
                  context.read<FetchSchedulesCubit>().fetchMySchedules();
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return FloatingActionButton.extended(
                    backgroundColor:
                        _isEnabled() ? CColors.primary : Colors.grey,
                    onPressed: !_isEnabled()
                        ? null
                        : () {
                            String? datetime;
                            String? cron;
                            var days = _days
                                .where((element) => element.isSelected)
                                .toList();
                            if (_isRepeated && days.isNotEmpty) {
                              datetime = null;
                              cron = _convertScheduleDataToCron(
                                  days: days, time: _time);
                            } else {
                              cron = null;
                              datetime = _selectedDate
                                  .copyWith(
                                      hour: _time.hour, minute: _time.minute)
                                  .toIso8601String();
                              log("datetime ==> $datetime");
                            }
                            context.read<UpdateScheduleCubit>().updateSchedule(
                                newSchedule: widget.schedule!.copyWith(
                                    events: _events,
                                    cron: cron,
                                    datetime: datetime,
                                    name: _nameController.text));
                          },
                    label: state is CreateScheduleInProgress
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text("Save Changes"));
              },
            ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Time",
                  style: Style.appTheme.textTheme.titleMedium,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          showPicker(
                            context: context,
                            value: _time,
                            height: 450,
                            wheelHeight: 300,
                            onChange: (time) {
                              setState(() {
                                _time = time;
                              });
                            },
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          child: Text(
                            _time.format(context),
                            style: Style.appTheme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      _isRepeated ? "Repeated" : "Not Repeated",
                      style: Style.appTheme.textTheme.bodySmall,
                    ),
                    Switch(
                        value: _isRepeated,
                        onChanged: ((value) => setState(() {
                              _isRepeated = value;
                            })))
                  ],
                ),
              ),
              if (_isRepeated) ...[
                const Space.v10(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Days",
                    style: Style.appTheme.textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: WeekdaySelector(
                    selectedFillColor: Colors.orange,
                    firstDayOfWeek: 0,
                    elevation: 3,
                    onChanged: (int day) {
                      setState(() {
                        // Use module % 7 as Sunday's index in the array is 0 and
                        // DateTime.sunday constant integer value is 7.
                        final index = day % 7;
                        // We "flip" the value in this example, but you may also
                        // perform validation, a DB write, an HTTP call or anything
                        // else before you actually flip the value,
                        // it's up to your app's needs.
                        _days[index].isSelected = !_days[index].isSelected;
                      });
                    },
                    values: _days.map((e) => e.isSelected).toList(),
                  ),
                ),
              ],
              if (!_isRepeated) ...[
                // Space.v15(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Date",
                        style: Style.appTheme.textTheme.titleMedium,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedDate = DateTime.now();
                        });
                      },
                      child: const Text(
                        "Set Today",
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    height: 100,
                    child: ScrollDatePicker(
                      options: DatePickerOptions(
                        backgroundColor: CColors.background,
                      ),
                      selectedDate: _selectedDate,
                      minimumDate: DateTime.now(),
                      maximumDate: DateTime.now()
                          .copyWith(year: DateTime.now().year + 1),
                      locale: const Locale('ar'),
                      onDateTimeChanged: (DateTime value) {
                        setState(() {
                          _selectedDate = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
              const Space.v20(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Events",
                  style: Style.appTheme.textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: List.generate(
                      _events.length,
                      (index) => Dismissible(
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              setState(() {
                                _events.removeAt(index);
                              });
                            },
                            key: ObjectKey(_events[index]),
                            child: EventWidget(
                              myEvents: _events,
                              event: _events[index],
                              onSwitched: (isOn) {
                                setState(() {
                                  _events[index].value = isOn ? 1 : 0;
                                });
                              },
                              index: index,
                              onChanged: (selected) {
                                setState(() {
                                  _events[index].interfaceId =
                                      selected!.interfaceId;
                                });
                              },
                            ),
                          )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _events.add(Event(value: 1));
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    radius: 15,
                    child: const Icon(
                      CupertinoIcons.add,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
              const Space.v30(),
              const Space.v30(),
            ],
          ),
        ),
      ),
    );
  }

  final _days = [
    MyDay(name: "SUN", id: 0),
    MyDay(name: "MON", id: 1),
    MyDay(name: "TUE", id: 2),
    MyDay(name: "WED", id: 3),
    MyDay(name: "THU", id: 4),
    MyDay(name: "FRI", id: 5),
    MyDay(name: "SAT", id: 6),
  ];

  bool _isEventsValid() {
    if (_events.isEmpty) return false;
    for (var e in _events) {
      if (e.interfaceId == null) {
        return false;
      }
    }
    return true;
  }

  bool _isEnabled() {
    return _nameController.text.isNotEmpty && _isEventsValid() && _isChanged();
  }

  String _convertScheduleDataToCron(
      {required Time time, required List<MyDay> days}) {
    //* Time (hours and minutes)
    var h = time.hour;
    var m = time.minute;

    //* Date and Weak days

    String daysStr;

    if (days.isNotEmpty) {
      if (days.length == 7) {
        daysStr = "*";
      } else {
        daysStr = days.map((e) => e.id).toList().join(",");
      }
    } else {
      daysStr = "*";
    }
    var cron = "$m $h * * $daysStr";
    log("Cron => $cron");
    return cron;
  }

  void handleUpdateMode() {
    if (widget.schedule != null) {
      //* update mode
      final mySchedule = widget.schedule as Schedule;

      //! strange problem ==> widget.schedule update its events automatically
      _events = mySchedule.events;

      //* to solve it i did this final String to check if changed
      _legacyEvents = mySchedule.events.toString();

      _nameController.text = mySchedule.name;
      _isRepeated = mySchedule.cron != null;
      if (_isRepeated) {
        // handle weak days and time
        var cron = mySchedule.cron as String;
        var splittedCron = cron.split(" ");
        var m = int.parse(splittedCron[0]);
        var h = int.parse(splittedCron[1]);
        _time = Time(hour: h, minute: m);

        var ds = splittedCron[4];
        if (ds == "*") {
          for (var d in _days) {
            d.isSelected = true;
          }
        } else {
          var sds = ds.split(",");
          var nsds = sds.map((e) => int.parse(e)).toList();

          for (var nd in nsds) {
            _days[nd].isSelected = true;
          }
        }
      } else {
        _selectedDate = DateTime.parse(mySchedule.datetime as String);
        _time = Time(hour: _selectedDate.hour, minute: _selectedDate.minute);
      }
    }
  }

  bool _isChanged() {
    if (widget.schedule == null) {
      return true;
    }
    var mySchedule = widget.schedule as Schedule;

    log("legacy events ==> $_legacyEvents");
    log("n e w  events ==> $_events");

    var cron = _convertScheduleDataToCron(
        time: _time,
        days: _days.where((element) => element.isSelected).toList());
    String? datetime;
    if (_isRepeated && _days.any((element) => element.isSelected)) {
      datetime = null;
    } else {
      datetime = _selectedDate
          .copyWith(hour: _time.hour, minute: _time.minute)
          .toIso8601String();
    }
    if (_nameController.text != mySchedule.name ||
        _events.toString() != _legacyEvents ||
        cron != mySchedule.cron ||
        datetime != mySchedule.datetime) return true;

    return false;
  }
}

class MyDay {
  final String name;
  final int id;
  bool isSelected;

  MyDay({
    required this.name,
    required this.id,
    this.isSelected = false,
  });
}
