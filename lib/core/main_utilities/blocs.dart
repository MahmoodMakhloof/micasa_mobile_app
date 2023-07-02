import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shca/modules/boards/blocs/fetchBoards/fetch_boards_cubit.dart';
import 'package:shca/modules/boards/repositories/boards_repository.dart';
import 'package:shca/modules/events/blocs/fetchScences/fetch_scences_cubit.dart';
import 'package:shca/modules/events/blocs/fetchSchedules/fetch_schedules_cubit.dart';
import 'package:shca/modules/events/repositories/events_repository.dart';
import 'package:shca/modules/home/blocs/fetchGroupPics/fetch_group_pics_cubit.dart';
import 'package:shca/modules/home/blocs/fetchGroupsCubit/fetch_groups_cubit.dart';
import 'package:shca/modules/home/blocs/fetchInterfaces/fetch_interfaces_cubit.dart';
import 'package:shca/modules/home/repositories/home_repository.dart';
import '../../modules/auth/blocs/get_user_data_cubit/get_user_data_cubit.dart';
import '../../modules/auth/repositories/authentication_repository_impl.dart';
import '../../modules/events/blocs/fetchEventInterfaces/fetch_event_intefaces_cubit.dart';

class BlocProviders extends StatelessWidget {
  final Widget child;
  const BlocProviders({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetUserDataCubit(
            context.read<AuthenticationRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              FetchEventIntefacesCubit(context.read())..fetchEventInterfaces(),
        ),BlocProvider(
          create: (context) =>
              FetchGroupPicsCubit(context.read())..fetchMyGroupPics(),
        ),
        BlocProvider(
          create: (context) => FetchInterfacesCubit(
            context.read<HomeRepository>(),
          )..fetchInterfaces(scope: InterfacesScope.allBoards),
        ),
        BlocProvider(
          create: (context) => FetchScencesCubit(
            context.read<EventsRepository>(),
          )..fetchMyScences(),
        ),
        BlocProvider(
          create: (context) => FetchBoardsCubit(
            context.read<BoardsRepository>(),
          )..fetchBoards(),
        ),
        BlocProvider(
          create: (context) => FetchSchedulesCubit(
            context.read<EventsRepository>(),
          )..fetchMySchedules(),
        ),
        BlocProvider(
          create: (context) => FetchGroupsCubit(
            context.read<HomeRepository>(),
          )..fetchMyGroups(),
        ),
      ],
      child: child,
    );
  }
}
