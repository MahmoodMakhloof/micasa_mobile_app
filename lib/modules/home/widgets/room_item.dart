import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shca/core/helpers/style_config.dart';
import 'package:shca/modules/home/models/group.dart';
import 'package:utilities/utilities.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({
    Key? key,
    required this.color,
    required this.group,
    required this.onTap,
  }) : super(key: key);

  final Color color;
  final Group group;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: CachedNetworkImage(
                  imageUrl: group.image.url,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  height: Style.screenSize.height * 0.15,
                ),
              ),
              const Space.v10(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.name,
                    style: Style.appTheme.textTheme.titleMedium!
                        .copyWith(height: 1.3, color: CColors.black70),
                  ),
                  Text(
                    "${group.interfaces.length} Devices",
                    style: Style.appTheme.textTheme.bodySmall!
                        .copyWith(height: 1.2, color: Colors.grey),
                  ),
                ],
              ),
              const Space.v20()
            ]),
      ),
    );
  }
}
