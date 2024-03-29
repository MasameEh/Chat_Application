

import 'dart:io';

import 'package:chat_application/widgets/cubit.dart';
import 'package:chat_application/widgets/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserImage extends StatelessWidget {
  const UserImage({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  Widget build(BuildContext context) {
    AppWidgetsCubit cubit = AppWidgetsCubit.get(context);
    return BlocConsumer<AppWidgetsCubit, AppWidgetsStates>(
          listener: (context, state){},
          builder: (context, state)
          {
            return Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  foregroundImage: cubit.pickedImageFile == null ? null: FileImage(cubit.pickedImageFile!),
                  radius: 40,
                ),
                TextButton.icon(
                  onPressed: () async{
                      await cubit.pickImage();
                      if (cubit.pickedImageFile != null) {
                        onPickImage(cubit.pickedImageFile!);
                      }
                  },
                  icon: const Icon(Icons.image),
                  label: Text('Add Image',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      )
                  ),
                ),
              ],
            );
          },
    );
  }
}
