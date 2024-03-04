import 'dart:io';

import 'package:chat_application/screens/auth_screen/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppAuthCubit extends Cubit<AppAuthStates> {
  AppAuthCubit() : super(AppLoginInitialState());

  static AppAuthCubit get(context) => BlocProvider.of(context);

  final FirebaseAuth firebase = FirebaseAuth.instance;
  bool isPass = true;
  bool isLogin = true;
  IconData suffix = Icons.visibility_outlined;
  File? selectedImage;
  late String imageURL;

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(AppLoginLoadingState());

    try {
      await firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AppLoginSuccessState());
    } on FirebaseAuthException catch (e) {
      String error = '';
      print(e.message);
      if (e.code == 'wrong-password') {
        error = 'Incorrect password. Please try again.';
      } else if (e.code == 'network-request-failed') {
        error = 'No Internet Connection';
      } else if (e.code == 'user-not-found') {
        error =
        'User not found. Please check your email or sign up for a new account.';
      } else if (e.code == 'too-many-requests') {
        error = 'Too many attempts please try later';
      } else if (e.code == 'unknown') {
        error = 'Email and Password Fields are required';
      } else if (e.code == 'invalid-email') {
        error = 'Invalid email address. Please enter a valid email.';
      } else {
        error = e.code.toString();
      }
      print(error);
      emit(AppLoginErrorState(error));
    }
  }

  void userRegister({
    required String email,
    required String password,
    required String username,
  }) async {
    emit(AppRegisterLoadingState());

    try {
      final UserCredential userCredential = await firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final Reference storageRef = FirebaseStorage.instance.ref().child('user_images').child('${userCredential.user!.uid}.jpg');
      await storageRef.putFile(selectedImage!);
      imageURL = await storageRef.getDownloadURL();
      print(imageURL);

      FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
          'username' : username,
          'email' : email,
          'image_url' : imageURL,
          }
        ).then((_) => emit(AppRegisterSuccessState()));

    } on FirebaseAuthException catch (e) {

      emit(AppRegisterErrorState(e.message.toString()));
    }
  }
  void changeBetweenLoginSignUp()
  {
    isLogin = !isLogin;
    emit(AppChangeBetweenLoginSignUpState());
  }

  void navigateSelectedImage(File pickedImage)
  {
    selectedImage = pickedImage;

    emit(AppNavigateSelectedImageState());
  }
}

