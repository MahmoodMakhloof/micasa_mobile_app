import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shca/modules/home/blocs/fetchGroupPics/fetch_group_pics_cubit.dart';
import 'package:shca/modules/home/blocs/fetchGroupsCubit/fetch_groups_cubit.dart';

import 'package:shca/modules/home/blocs/updateGroup/update_group_cubit.dart';
import 'package:shca/widgets/back_button.dart';
import 'package:shca/widgets/custom_text_field.dart';
import 'package:shca/widgets/no_data.dart';

import '../../../core/helpers/style_config.dart';
import '../models/group.dart';

class UpdateRoomScreen extends StatelessWidget {
  final Group group;
  const UpdateRoomScreen({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateGroupCubit(context.read()),
      child: _UpdateRoomView(group: group),
    );
  }
}

class _UpdateRoomView extends StatefulWidget {
  final Group group;
  const _UpdateRoomView({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  State<_UpdateRoomView> createState() => __UpdateRoomViewState();
}

class __UpdateRoomViewState extends State<_UpdateRoomView> {
  final TextEditingController _roomNameController = TextEditingController();
  late GroupPic _selectedPic;

  @override
  void initState() {
    super.initState();
    _roomNameController.text = widget.group.name;
    _selectedPic = widget.group.image;
  }

  @override
  void dispose() {
    _roomNameController.dispose();
    super.dispose();
  }

  _isChanged() {
    return _roomNameController.text != widget.group.name ||
        _selectedPic != widget.group.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MyBackButton(),
        title: CTextField(
          hint: "Ex: BedRoom",
          fontSize: 20,
          initialValue: widget.group.name,
          onChanged: (p0) {
            setState(() {});
          },
          controller: _roomNameController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "the name is required";
            }
            return null;
          },
        ),
      ),
      floatingActionButton: BlocConsumer<UpdateGroupCubit, UpdateGroupState>(
        listener: (context, state) {
          if(state is UpdateGroupSucceeded){
            context.read<FetchGroupsCubit>().fetchMyGroups();
          Navigator.pop(
              context,
              widget.group.copyWith(
                  name: _roomNameController.text, image: _selectedPic));
          }
        },
        builder: (context, state) {
          return FloatingActionButton.extended(
              onPressed: _isChanged()
                  ? () {
                      context.read<UpdateGroupCubit>().updateGroup(
                          name: _roomNameController.text,
                          groupId: widget.group.id,
                          image: _selectedPic.id);
                    }
                  : null,
              label: const Text("Save Changes"));
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<FetchGroupPicsCubit, FetchGroupPicsState>(
                builder: ((context, state) {
              if (state is FetchGroupPicsFailed) {
                return ErrorWidget(state.e!);
              }
              if (state is FetchGroupPicsSucceeded) {
                final images = state.pics;
                if (images.isEmpty) {
                  return const NoDataView();
                } else {
                  return GridView.builder(
                      itemCount: images.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              childAspectRatio: 1,
                              mainAxisSpacing: 10),
                      padding: const EdgeInsets.all(10),
                      itemBuilder: ((context, index) => PicSelectWidget(
                            image: images[index],
                            isSelected: _selectedPic == images[index],
                            onTap: () {
                              setState(() {
                                _selectedPic = images[index];
                              });
                            },
                          )));
                }
              }
              return const Center(child: CircularProgressIndicator());
            }))
          ],
        ),
      ),
    );
  }
}

class PicSelectWidget extends StatelessWidget {
  const PicSelectWidget({
    Key? key,
    required this.image,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final GroupPic image;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onTap,
            child: Container(
                decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.indigo.shade100
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CachedNetworkImage(imageUrl: image.url),
                )),
          ),
        ),
        if (isSelected)
          CircleAvatar(
              radius: 15,
              backgroundColor: CColors.background,
              child: const CircleAvatar(
                  radius: 10,
                  child: Icon(
                    FontAwesomeIcons.check,
                    size: 15,
                  )))
      ],
    );
  }
}
