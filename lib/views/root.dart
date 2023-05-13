import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shca/core/helpers/navigation.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/generated/assets.gen.dart';
import 'package:shca/generated/locale_keys.g.dart';
import 'package:shca/modules/boards/views/boards.dart';
import 'package:shca/modules/home/views/home.dart';
import 'package:shca/modules/profile/views/profile.dart';
import 'package:shca/modules/scences/views/scences.dart';
import 'package:shca/modules/schedules/views/schedules.dart';

import '../modules/auth/blocs/get_user_data_cubit/get_user_data_cubit.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => RootState();
}

class RootState extends State<Root> {
  late int currentIndex;
  List<Widget> views = const [
    HomeScreen(),
    BoardsScreen(),
    SizedBox.shrink(),
    SchedulesView(),
    ScencesView(),
  ];

  @override
  void initState() {
    currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Assets.images.vectors.cloudy.svg(height: 20),
                  const Text(
                    "30 C˚",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Text("Micasa", style: GoogleFonts.caveat(fontSize: 30)),
              CircleAvatar(
                radius: 20,
                backgroundColor: CColors.primary,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: BlocBuilder<GetUserDataCubit, GetUserDataState>(
                    builder: (context, state) {
                      if (state is GetUserDataSucceeded) {
                        return InkWell(
                            onTap: () {
                              context.navigateTo(const ProfileScreen());
                            },
                            child: Center(
                              child: CircleAvatar(
                                radius: 16,
                                backgroundImage: CachedNetworkImageProvider(
                                  state.user.avatar!,
                                ),
                              ),
                            ));
                      }
                      return CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Assets.images.vectors.user.svg(height: 16),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        body: views[currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(CupertinoIcons.mic),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: CColors.primary,
            backgroundColor: Colors.white,
            elevation: 0,
            unselectedItemColor: Colors.black45,
            selectedLabelStyle: const TextStyle(
              fontSize: 10,
            ),
            unselectedLabelStyle: const TextStyle(fontSize: 10),
            type: BottomNavigationBarType.fixed,
            onTap: (index) => setState(() {
                  currentIndex = index;
                }),
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Assets.images.vectors.home.svg(
                      height: 20,
                      width: 20,
                      color: currentIndex == 0 ? CColors.primary : null),
                  label: LocaleKeys.pages_home.tr()),
              BottomNavigationBarItem(
                  icon: Assets.images.vectors.apps.svg(
                      height: 20,
                      width: 20,
                      color: currentIndex == 1 ? CColors.primary : null),
                  label: LocaleKeys.pages_boards.tr()),
              const BottomNavigationBarItem(icon: SizedBox.shrink(), label: ""),
              BottomNavigationBarItem(
                  icon: Assets.images.vectors.calendar.svg(
                      height: 20,
                      width: 20,
                      color: currentIndex == 3 ? CColors.primary : null),
                  label: LocaleKeys.pages_schedule.tr()),
              BottomNavigationBarItem(
                  icon: Assets.images.vectors.chartNetwork.svg(
                      height: 20,
                      width: 20,
                      color: currentIndex == 4 ? CColors.primary : null),
                  label: LocaleKeys.pages_scences.tr()),
            ]));
  }
}
