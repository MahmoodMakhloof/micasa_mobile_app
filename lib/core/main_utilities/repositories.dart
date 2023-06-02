import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:shca/modules/boards/repositories/boards_repository.dart';
import 'package:shca/modules/events/repositories/events_repository.dart';
import 'package:shca/modules/home/repositories/home_repository.dart';
import '../../modules/auth/repositories/authentication_repository_impl.dart';
import '../helpers/networking.dart';

class RepositoryProviders extends StatefulWidget {
  final Widget child;
  const RepositoryProviders({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<RepositoryProviders> createState() => _RepositoryProvidersState();
}

class _RepositoryProvidersState extends State<RepositoryProviders> {
  final dio = Dio();
  late final AuthenticationRepository authRepository;
  late final HomeRepository homeRepository;
  late final BoardsRepository boardsRepository;
  late final EventsRepository eventsRepository;

  @override
  void initState() {
    dio.interceptors.add(filterDataObject());

    authRepository = AuthenticationRepository(client: dio);
    homeRepository = HomeRepository(client: dio);
    boardsRepository = BoardsRepository(client: dio);
    eventsRepository = EventsRepository(client: dio);
    super.initState();
  }

  @override
  void dispose() {
    dio.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _RepositoryProviders(
      providers: [
        RepositoryProvider.value(value: dio),
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: homeRepository),
        RepositoryProvider.value(value: boardsRepository),
        RepositoryProvider.value(value: eventsRepository),
      ],
      child: widget.child,
    );
  }
}

class _RepositoryProviders extends Nested {
  _RepositoryProviders({
    Key? key,
    required List<SingleChildWidget> providers,
    required Widget child,
    TransitionBuilder? builder,
  }) : super(
          key: key,
          children: providers,
          child: builder != null
              ? Builder(builder: (context) => builder(context, child))
              : child,
        );
}
