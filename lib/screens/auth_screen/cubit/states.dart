abstract class AppAuthStates {}

class AppLoginInitialState extends AppAuthStates {}

class AppLoginLoadingState extends AppAuthStates {}

class AppLoginSuccessState extends AppAuthStates {}

class AppLoginErrorState extends AppAuthStates {
  late String error;
  AppLoginErrorState(this.error);
}

class AppRegisterLoadingState extends AppAuthStates {}

class AppRegisterSuccessState extends AppAuthStates {}

class AppRegisterErrorState extends AppAuthStates {
  late String error;
  AppRegisterErrorState(this.error);
}

class AppChangePasswordVisibilityState extends AppAuthStates {}

class AppChangeBetweenLoginSignUpState extends AppAuthStates {}