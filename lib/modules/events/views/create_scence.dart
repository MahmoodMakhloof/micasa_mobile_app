import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/modules/events/blocs/createScence/create_scence_cubit.dart';
import 'package:shca/modules/events/blocs/fetchEventInterfaces/fetch_event_intefaces_cubit.dart';
import 'package:shca/modules/events/blocs/fetchScences/fetch_scences_cubit.dart';
import 'package:shca/modules/events/models/event_interface.dart';
import 'package:shca/modules/events/models/scence.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:shca/widgets/widgets.dart';
import 'package:utilities/utilities.dart';

class CreateScenceScreen extends StatelessWidget {
  const CreateScenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateScenceCubit(context.read()),
        ),
        BlocProvider(
          lazy: false,
          create: (context) =>
              FetchEventIntefacesCubit(context.read())..fetchEventInterfaces(),
        ),
      ],
      child: const _CreateScenceView(),
    );
  }
}

class _CreateScenceView extends StatefulWidget {
  const _CreateScenceView();

  @override
  State<_CreateScenceView> createState() => _CreateScenceViewState();
}

class _CreateScenceViewState extends State<_CreateScenceView> {
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

  bool _isEventsValid() {
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
        title: const Text("Create Scence"),
        leading: const MyBackButton(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: SizedBox(
                width: 70,
                child: BlocConsumer<CreateScenceCubit, CreateScenceState>(
                  listener: (context, state) {
                    if (state is CreateScenceSucceeded) {
                      context.read<FetchScencesCubit>().fetchMyScences();
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                        isLoading: state is CreateScenceInProgress,
                        enabled: _isEnabled(),
                        onPressed: () {
                          // final state = _formKey.currentState as FormState?;
                          // if (!state!.validate()) {}

                          context.read<CreateScenceCubit>().createNewScence(
                              name: _nameController.text,
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
                        "Scence Name",
                        style: Style.appTheme.textTheme.titleLarge,
                      ),
                    ),
                    CTextField(
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
                      hint: "Ex: Turn on office setup and air conditioners.",
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
                              events.removeAt(index);
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

class EventWidget extends StatefulWidget {
  final Event event;
  final int index;
  final Function(EventInterface?) onChanged;
  final Function(bool) onSwitched;
  const EventWidget({
    super.key,
    required this.event,
    required this.index,
    required this.onChanged,
    required this.onSwitched,
  });

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  bool isON = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchEventIntefacesCubit, FetchEventIntefacesState>(
      builder: (context, state) {
        if (state is FetchEventIntefacesFailed) {
          return ErrorViewer(state.e!);
        } else if (state is FetchEventIntefacesSucceeded) {
          final interfaces = state.interfaces;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: CColors.primary,
                  radius: 15,
                  child: Text(
                    (widget.index + 1).toString(),
                    style: Style.appTheme.textTheme.titleMedium!
                        .copyWith(color: Colors.white),
                  ),
                ),
                const Space.h20(),
                Expanded(
                  child: SizedBox(
                    // height: 50,
                    // width: Style.screenSize.width * 0.5,
                    child: DropdownSearch<EventInterface>(
                      dropdownBuilder: (context, selectedItem) {
                        if (selectedItem == null) {
                          return Center(
                            child: Text(
                              "Choose Device",
                              style: Style.appTheme.textTheme.titleLarge!
                                  .copyWith(color: Colors.grey.shade400),
                            ),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedItem.interfaceName,
                              style: Style.appTheme.textTheme.titleMedium!
                                  .copyWith(height: 1.8),
                            ),
                            Text(
                              selectedItem.interfaceBoard,
                              style: Style.appTheme.textTheme.bodySmall,
                            ),
                          ],
                        );
                      },
                      filterFn: (item, filter) {
                        return item.interfaceName.contains(filter) ||
                            item.interfaceBoard.contains(filter);
                      },
                      dropdownButtonProps: const DropdownButtonProps(
                        icon: Icon(
                          CupertinoIcons.chevron_down,
                          size: 15,
                        ),
                      ),
                      popupProps: PopupProps.menu(
                        itemBuilder: (context, item, isSelected) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.interfaceName,
                                  style: Style.appTheme.textTheme.titleMedium!
                                      .copyWith(height: 1),
                                ),
                                Text(
                                  item.interfaceBoard,
                                  style: Style.appTheme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          );
                        },
                        showSelectedItems: false,
                        showSearchBox: true,
                        scrollbarProps: const ScrollbarProps(thickness: 5),
                        searchDelay: Duration.zero,
                        searchFieldProps: const TextFieldProps(
                            decoration: InputDecoration(
                          hintText: "Ex: Lamp1",
                          // border: InputBorder.none,
                        )),
                      ),
                      items: interfaces,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 2),
                            fillColor: Colors.grey.shade200,
                            border: InputBorder.none),
                      ),
                      onChanged: widget.onChanged,
                      selectedItem: null,
                    ),
                  ),
                ),
                const Space.h30(),
                Switch(
                    value: isON,
                    onChanged: (value) {
                      widget.onSwitched.call(value);
                      setState(() {
                        isON = value;
                      });
                    })
              ],
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
