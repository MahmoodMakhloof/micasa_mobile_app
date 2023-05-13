import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/auth/blocs/get_user_data_cubit/get_user_data_cubit.dart';
import '../../modules/auth/repositories/authentication_repository_impl.dart';

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
        BlocProvider(create: (context)=> GetUserDataCubit(context.read<AuthenticationRepository>(),),)
      ],
      child: child,
    );
  }
}
