abstract class AppLoginStates {}

class AppLoginInitialState extends AppLoginStates {}

class AppLoginLoadingState extends AppLoginStates {}

class AppLoginSuccessState extends AppLoginStates {}

class AppLoginErrorState extends AppLoginStates {
  final String error;
  AppLoginErrorState(this.error);
}

class AppRegisterLoadingState extends AppLoginStates {}

class AppRegisterSuccessState extends AppLoginStates {}

class AppRegisterErrorState extends AppLoginStates {
  late String error;
  AppRegisterErrorState(this.error);
}

class AppChangePasswordVisibilityState extends AppLoginStates {}

class AppChangeBetweenLoginSignUpState extends AppLoginStates {}