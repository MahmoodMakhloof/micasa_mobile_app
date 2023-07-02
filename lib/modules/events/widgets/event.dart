import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shca/modules/events/models/scence.dart';
import 'package:shca/widgets/error_viewer.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:utilities/utilities.dart';

import '../../../core/helpers/style_config.dart';
import '../blocs/fetchEventInterfaces/fetch_event_intefaces_cubit.dart';
import '../models/event_interface.dart';

class EventWidget extends StatefulWidget {
  final Event? event;
  final List<Event> myEvents;
  final int index;
  final Function(EventInterface?) onChanged;
  final Function(bool) onSwitched;
  const EventWidget({
    super.key,
    required this.index,
    required this.onChanged,
    required this.onSwitched,
    required this.event,
    required this.myEvents,
  });

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  bool isON = false;
  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      var myEventData = widget.event as Event;
      isON = myEventData.value! > 0;
    }
  }

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
                  backgroundColor: Colors.grey.shade200,
                  radius: 15,
                  child: const Icon(
                    CupertinoIcons.right_chevron,
                    color: Colors.black54,
                  ),
                ),
                const Space.h20(),
                Expanded(
                  child: DropdownSearch<EventInterface>(
                    dropdownBuilder: (context, selectedItem) {
                      if (selectedItem == null) {
                        return Text(
                          "Select Device",
                          style: Style.appTheme.textTheme.titleMedium!.copyWith(
                              color: Colors.grey.shade400, height: 2.3),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedItem.interfaceName,
                            style: Style.appTheme.textTheme.titleMedium!
                                .copyWith(height: 1.5),
                          ),
                          Text(
                            selectedItem.interfaceBoard,
                            style: Style.appTheme.textTheme.bodySmall!
                                .copyWith(height: 1.5),
                          ),
                        ],
                      );
                    },
                    dropdownButtonProps: const DropdownButtonProps(
                      icon: Icon(
                        CupertinoIcons.chevron_down,
                        size: 15,
                      ),
                    ),
                    popupProps: PopupProps.bottomSheet(
                      fit: FlexFit.loose,
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
                    items: interfaces.where((interface) {
                      return !(widget.myEvents.any((myEvent) =>
                          myEvent.interfaceId == interface.interfaceId));
                    }).toList(),
                    filterFn: (item, filter) => item.interfaceName
                        .toLowerCase()
                        .contains(filter.toLowerCase()),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 2),
                          fillColor: Colors.grey.shade200,
                          border: InputBorder.none),
                    ),
                    onChanged: widget.onChanged,
                    selectedItem: widget.event != null &&
                            widget.event!.interfaceId != null
                        ? interfaces.singleWhere((element) =>
                            element.interfaceId == widget.event!.interfaceId!)
                        : null,
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
