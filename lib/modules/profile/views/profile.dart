import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:utilities/utilities.dart';

import '../../auth/blocs/get_user_data_cubit/get_user_data_cubit.dart';
import '../../auth/repositories/authentication_repository_impl.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const MyBackButton(),
          title: BlocBuilder<GetUserDataCubit, GetUserDataState>(
            builder: (context, state) {
              if (state is GetUserDataSucceeded) {
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: CachedNetworkImageProvider(
                        state.user.avatar!,
                      ),
                    ),
                    const Space.h15(),
                    Expanded(child: Text(state.user.fullname ?? ''))
                  ],
                );
              }
              return const Text("Profile");
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    FontAwesomeIcons.userPen,
                    size: 20,
                  )),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(FontAwesomeIcons.arrowRightFromBracket),
            onPressed: () => context.read<AuthenticationRepository>().logout()),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Space.v10(),
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => const ConnectRequest(),
                    separatorBuilder: (context, index) => const Space.v5(),
                    itemCount: 2)
              ],
            ),
          ),
        ));
  }
}

class ConnectRequest extends StatelessWidget {
  const ConnectRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    "https://i.pinimg.com/564x/3e/77/8a/3e778a1cd7385301da9691224f354d1d.jpg"),
              ),
              title: RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: "Sherin Ahmed",
                  style: Style.appTheme.textTheme.titleLarge!.copyWith(
                      height: 1.5, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: " added you to connect and control ",
                  style: Style.appTheme.textTheme.bodyMedium!.copyWith(
                      height: 1.5, fontSize: 16, fontWeight: FontWeight.w400),
                ),
                TextSpan(
                  text: "Bed Room",
                  style: Style.appTheme.textTheme.bodyMedium!.copyWith(
                      height: 1.5,
                      fontSize: 14,
                      color: CColors.primary,
                      fontWeight: FontWeight.w600),
                ),
              ])),
            ),
            //
          ],
        ),
      ),
    );
  }
}
