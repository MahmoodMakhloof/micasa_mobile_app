import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/modules/events/blocs/createScence/create_scence_cubit.dart';
import 'package:shca/modules/events/blocs/deleteScence/delete_scence_cubit.dart';
import 'package:shca/modules/events/blocs/fetchScences/fetch_scences_cubit.dart';
import 'package:shca/modules/events/blocs/updateScence/update_scence_cubit.dart';
import 'package:shca/modules/events/models/scence.dart';
import 'package:shca/modules/events/widgets/event.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:shca/widgets/widgets.dart';
import 'package:utilities/utilities.dart';

import '../../../widgets/cutstom_outlined_button.dart';

class HandlScenceScreen extends StatelessWidget {
  final Scence? scence;
  const HandlScenceScreen({super.key, this.scence});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateScenceCubit(context.read()),
        ),
        BlocProvider(
          create: (context) => UpdateScenceCubit(context.read()),
        ),
        BlocProvider(
          create: (context) => DeleteScenceCubit(context.read()),
        ),
      ],
      child: _HandlScenceView(scence),
    );
  }
}

class _HandlScenceView extends StatefulWidget {
  final Scence? scence;
  const _HandlScenceView(this.scence);

  @override
  State<_HandlScenceView> createState() => _HandlScenceViewState();
}

class _HandlScenceViewState extends State<_HandlScenceView> {
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  List<Event> _events = [];
  //* legacy events
  late final String? _legacyEvents;

  @override
  void initState() {
    super.initState();
    handleForUpdate();
  }

  final TextEditingController _nameController = TextEditingController();

  bool _isEventsValid() {
    if (_events.isEmpty) return false;
    for (var element in _events) {
      if (element.interfaceId == null) {
        return false;
      }
    }
    return true;
  }

  bool _isChanged() {
    if (widget.scence == null) {
      return true;
    }

    var myScence = widget.scence as Scence;
    if (_nameController.text != myScence.name ||
        _events.toString() != _legacyEvents) return true;

    return false;
  }

  bool _isEnabled() {
    return _nameController.text.isNotEmpty && _isEventsValid() && _isChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CTextField(
          hint: "Ex: Comming Home",
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
          if (widget.scence != null)
            BlocConsumer<DeleteScenceCubit, DeleteScenceState>(
              listener: (context, state) {
                if (state is DeleteScenceSucceeded) {
                  context.read<FetchScencesCubit>().fetchMyScences();
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
                          isLoading: state is DeleteScenceInProgress,
                          borderColor: Colors.red,
                          onPressed: () => context
                              .read<DeleteScenceCubit>()
                              .deleteScence(scence: widget.scence!),
                          child: const Text(
                            "Delete",
                          ),
                        )));
              },
            ),
          const Space.h10(),
        ],
      ),
      floatingActionButton: widget.scence == null
          ? BlocConsumer<CreateScenceCubit, CreateScenceState>(
              listener: (context, state) {
                if (state is CreateScenceSucceeded) {
                  context.read<FetchScencesCubit>().fetchMyScences();
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
                            context.read<CreateScenceCubit>().createNewScence(
                                name: _nameController.text, events: _events);
                          },
                    label: state is CreateScenceInProgress
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text("Save Changes"));
              },
            )
          : BlocConsumer<UpdateScenceCubit, UpdateScenceState>(
              listener: (context, state) {
                if (state is UpdateScenceSucceeded) {
                  context.read<FetchScencesCubit>().fetchMyScences();
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
                            context.read<UpdateScenceCubit>().updateScence(
                                newScence: widget.scence!.copyWith(
                                    events: _events,
                                    name: _nameController.text));
                          },
                    label: state is CreateScenceInProgress
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
              const Space.v10(),
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
                              _events.removeAt(index);
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
                    backgroundColor: Colors.grey.shade200,
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

  void handleForUpdate() {
    if (widget.scence != null) {
      var myScence = widget.scence as Scence;
      _nameController.text = myScence.name;

      //! strange problem ==> widget.schedule update its events automatically
      _events = myScence.events;

      //* to solve it i did this final String to check if changed
      _legacyEvents = myScence.events.toString();
    }
  }
}
