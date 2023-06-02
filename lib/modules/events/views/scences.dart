import 'package:flutter/material.dart';
import 'package:shca/core/helpers/navigation.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/generated/assets.gen.dart';
import 'package:shca/modules/home/views/home.dart';
import 'package:shca/modules/events/views/create_scence.dart';
import 'package:shca/widgets/custom_button.dart';
import 'package:utilities/utilities.dart';

class ScencesView extends StatelessWidget {
  const ScencesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Space.v10(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Assets.images.vectors.relax.svg(height: 70),
                  title: Text(
                    "Scene is some actions executed on your devices in same time instead of control single device.",
                    style: Style.appTheme.textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 17,
                      height: 1.5,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CustomButton(
                      backgroundColor: Colors.indigoAccent,
                      child: const Text("Create New Scene"),
                      onPressed: () =>
                          context.navigateTo(const CreateScenceScreen()),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            padding: const EdgeInsets.all(10),
            shrinkWrap: true,
            itemBuilder: (context, index) => const ScenceItem(),
            separatorBuilder: ((context, index) => const Space.v10()),
          ),
        ],
      ),
    );
  }
}
