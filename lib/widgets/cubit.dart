import 'package:chat_application/widgets/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class AppWidgetsCubit extends Cubit<AppWidgetsStates> {
  AppWidgetsCubit() : super(AppWidgetsInitialState());

  static AppWidgetsCubit get(context) => BlocProvider.of(context);

  File? pickedImageFile;

  Future pickImage() async
  {
    final XFile? pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxWidth: 150
    );
    if(pickedImage == null)
    {
      return;
    }
    pickedImageFile = File(pickedImage.path);

    emit(AppChangeImageState());
  }

}