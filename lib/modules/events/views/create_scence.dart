import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/modules/events/blocs/createScence/create_scence_cubit.dart';
import 'package:shca/modules/events/models/scence.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:shca/widgets/widgets.dart';
import 'package:utilities/utilities.dart';

class CreateScenceScreen extends StatelessWidget {
  const CreateScenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateScenceCubit(context.read()),
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
  List<Event> events = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Scence"),
        leading: const MyBackButton(),
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
                  "Scence Name",
                  style: Style.appTheme.textTheme.titleLarge,
                ),
              ),
              const CTextField(
                hint: "Ex: Comming Home",
                fontSize: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Descripiton (optional)",
                  style: Style.appTheme.textTheme.titleLarge,
                ),
              ),
              const CTextField(
                hint: "Ex: Turn on office setup and air conditioner.",
                fontSize: 20,
                keyboardType: TextInputType.text,
                maxLines: 2,
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
                      (index) =>
                          EventWidget(event: events[index], index: index)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      events.add(const Event(interfaceId: "2", value: 8));
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

class EventWidget extends StatelessWidget {
  final Event event;
  final int index;
  const EventWidget({super.key, required this.event, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: CColors.primary,
            radius: 15,
            child: Text(
              (index + 1).toString(),
              style: Style.appTheme.textTheme.titleMedium!
                  .copyWith(color: Colors.white),
            ),
          ),
          Space.h30(),
          Expanded(
            child: SizedBox(
              // height: 50,
              // width: Style.screenSize.width * 0.5,
              child: DropdownSearch<String>(
                dropdownButtonProps: DropdownButtonProps(
                  icon: Icon(
                    CupertinoIcons.chevron_down,
                    size: 15,
                  ),
                ),
                popupProps: PopupProps.menu(
                  showSelectedItems: false,
                  showSearchBox: true,
                  scrollbarProps: ScrollbarProps(thickness: 5),
                  searchDelay: Duration.zero,
                  searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                    hintText: "Ex: Lamp1",
                    // border: InputBorder.none,
                  )),
                  disabledItemFn: (String s) => s.startsWith('I'),
                ),
                items: [
                  "Brazil",
                  "Italia (Disabled)",
                  "Tunisia",
                  'Canada',
                  "Brazil",
                  "Italia (Disabled)",
                  "Tunisia",
                  'Canada',
                  "Brazil",
                  "Italia (Disabled)",
                  "Tunisia",
                  'Canada',
                ],
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    hintText: "country in menu mode",
                  ),
                ),
                onChanged: print,
                selectedItem: "Brazil",
              ),
            ),
          ),
          Space.h30(),
          Switch(value: true, onChanged: (value) {})
        ],
      ),
    );
  }
}
