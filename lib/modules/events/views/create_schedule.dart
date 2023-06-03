import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/modules/events/blocs/createSchedule/create_schedule_cubit.dart';
import 'package:shca/modules/events/blocs/fetchEventInterfaces/fetch_event_intefaces_cubit.dart';
import 'package:shca/modules/events/blocs/fetchSchedules/fetch_schedules_cubit.dart';
import 'package:shca/modules/events/models/scence.dart';
import 'package:shca/modules/events/views/create_scence.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:shca/widgets/widgets.dart';
import 'package:utilities/utilities.dart';
import 'package:weekday_selector/weekday_selector.dart';

class CreateScheuleScreen extends StatelessWidget {
  const CreateScheuleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateScheduleCubit(context.read()),
        ),
        BlocProvider(
          lazy: false,
          create: (context) =>
              FetchEventIntefacesCubit(context.read())..fetchEventInterfaces(),
        ),
      ],
      child: const _CreateScheuleView(),
    );
  }
}

class _CreateScheuleView extends StatefulWidget {
  const _CreateScheuleView();

  @override
  State<_CreateScheuleView> createState() => _CreateScheuleViewState();
}

class _CreateScheuleViewState extends State<_CreateScheuleView> {
  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  List<Event> events = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final GlobalKey _formKey = GlobalKey<FormState>();

  final _days = List.filled(7, true);

  bool _isRepeated = true;

  Time _time = Time(hour: DateTime.now().hour, minute: DateTime.now().minute);

  bool _isEventsValid() {
    if (events.isEmpty) return false;
    for (var element in events) {
      if (element.interfaceId == null) {
        return false;
      }
    }
    return true;
  }

  bool _isEnabled() {
    return _nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _isEventsValid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Schedule"),
        leading: const MyBackButton(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SizedBox(
                width: 70,
                child: BlocConsumer<CreateScheduleCubit, CreateScheduleState>(
                  listener: (context, state) {
                    if (state is CreateScheduleSucceeded) {
                      context.read<FetchSchedulesCubit>().fetchMySchedules();
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                        isLoading: state is CreateScheduleInProgress,
                        enabled: _isEnabled(),
                        onPressed: () {
                          context.read<CreateScheduleCubit>().createNewSchedule(
                              name: _nameController.text,
                              isRepeated: _isRepeated,
                              days: _days,
                              time: _time.format(context),
                              description: _descriptionController.text,
                              events: events);
                        },
                        child: const Text("Save"));
                  },
                )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Schedule Name",
                        style: Style.appTheme.textTheme.titleLarge,
                      ),
                    ),
                    CTextField(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Descripiton",
                        style: Style.appTheme.textTheme.titleLarge,
                      ),
                    ),
                    CTextField(
                      onChanged: (p0) {
                        setState(() {});
                      },
                      hint: "Ex: Turn on lights after 7 clock.",
                      fontSize: 20,
                      keyboardType: TextInputType.text,
                      maxLines: 2,
                      controller: _descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "the description is required";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Time",
                  style: Style.appTheme.textTheme.titleLarge,
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
                    const Text("Repeated"),
                    Switch(
                        value: _isRepeated,
                        onChanged: ((value) => setState(() {
                              _isRepeated = value;
                            })))
                  ],
                ),
              ),
              if (_isRepeated) ...[
                const Space.v20(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Days",
                    style: Style.appTheme.textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: WeekdaySelector(
                    selectedFillColor: CColors.gr1,
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
                        _days[index] = !_days[index];
                      });
                    },
                    values: _days,
                  ),
                ),
              ],
              const Space.v20(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Events",
                  style: Style.appTheme.textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: List.generate(
                      events.length,
                      (index) => Dismissible(
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              setState(() {
                                events.removeAt(index);
                              });
                            },
                            key: ObjectKey(events[index]),
                            child: EventWidget(
                              event: events[index],
                              onSwitched: (isOn) {
                                setState(() {
                                  events[index].value = isOn ? 1 : 0;
                                });
                              },
                              index: index,
                              onChanged: (selected) {
                                setState(() {
                                  events[index].interfaceId =
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
                      events.add(Event(value: 1));
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
}
