import 'package:chat_application/screens/auth_screen/cubit/cubit.dart';
import 'package:chat_application/screens/auth_screen/cubit/states.dart';
import 'package:chat_application/widgets/user_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailAddressController.dispose();
    _passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {


    void submit(AppAuthCubit cubit) async
    {
      var valid = _formKey.currentState!.validate();

      if(!valid || (cubit.selectedImage == null && !cubit.isLogin))
      {
        return;
      }
      if(cubit.isLogin)
      {
        cubit.userLogin(email: _emailAddressController.text, password: _passwordController.text);
      }else
      {
        cubit.userRegister(email: _emailAddressController.text, password: _passwordController.text, username: _userNameController.text);
      }
    }
    return BlocConsumer<AppAuthCubit, AppAuthStates>(
             listener: (context, state)
             {
               if (state is AppLoginErrorState )
               {
                 print(state.error);
                 ScaffoldMessenger.of(context).clearSnackBars();
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(state.error),),
                 );
               }
               if (state is AppRegisterErrorState)
               {
                 ScaffoldMessenger.of(context).clearSnackBars();
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(state.error),),
                 );
               }
             },
             builder: (context, state)
             {
               AppAuthCubit cubit = AppAuthCubit.get(context);
               return Scaffold(
                 backgroundColor: Theme.of(context).colorScheme.primary,
                 body: Center(
                   child: SingleChildScrollView(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Container(
                           margin: const EdgeInsets.only(
                             top: 30,
                             right: 20,
                             left: 20,
                             bottom: 30,
                           ),
                           child: Image.asset('assets/images/chat.PNG',height: 180, ),
                         ),
                         Card(
                           margin: const EdgeInsets.all(20),
                           child: SingleChildScrollView(
                             child: Padding(
                               padding: const EdgeInsets.all(16.0),
                               child: Form(
                                 key: _formKey,
                                 child: Column(
                                   children: [
                                     if(!cubit.isLogin) UserImage(
                                         onPickImage: cubit.navigateSelectedImage,
                                     ),
                                     if(!cubit.isLogin) TextFormField(
                                       controller: _userNameController,
                                       keyboardType: TextInputType.name,
                                       decoration: const InputDecoration(
                                         labelText: 'Username',
                                         prefixIcon: Icon(Icons.person,),
                                       ),
                                       onFieldSubmitted: (_)
                                       {
                                         submit(cubit);
                                       },
                                       validator: (value)
                                       {
                                         if (value == null || value.isEmpty || value.trim().isEmpty || value.length < 5) {
                                           return 'Please enter an valid username';
                                         }
                                         return null;
                                       },
                                       autocorrect: false,
                                       textCapitalization: TextCapitalization.none,
                                     ),
                                     TextFormField(
                                       controller: _emailAddressController,
                                       keyboardType: TextInputType.emailAddress,
                                       decoration: const InputDecoration(
                                         labelText: 'Email Address',
                                         prefixIcon: Icon(Icons.email_rounded,),
                                       ),
                                       onFieldSubmitted: (_)
                                       {
                                         submit(cubit);
                                       },
                                       validator: (value)
                                       {
                                         if (value == null || value.isEmpty || value.trim().isEmpty || !value.contains('@')) {
                                           return 'Please enter an valid email address';
                                         }
                                         return null;
                                       },
                                       autocorrect: false,
                                       textCapitalization: TextCapitalization.none,
                                     ),
                                     TextFormField(
                                       controller: _passwordController,
                                       keyboardType: TextInputType.visiblePassword,
                                       decoration: const InputDecoration(
                                         labelText: 'Password',
                                         prefixIcon: Icon(Icons.lock_rounded,),
                                       ),
                                       onFieldSubmitted: (_)
                                       {
                                         submit(cubit);
                                       },
                                       validator: (value)
                                       {
                                         if (value == null || value.trim().isEmpty)
                                         {
                                           return 'Please enter your password';
                                         }
                                         else if (value.length < 6)
                                         {
                                           return 'Password must be at least 6 characters';
                                         }
                                         return null;
                                       },
                                       obscureText: true,
                                     ),
                                     const SizedBox(height: 12.0),
                                     ConditionalBuilder(
                                       condition: state is! AppRegisterLoadingState && state is! AppLoginLoadingState,
                                       builder: (context) =>  ElevatedButton(
                                         onPressed: (){submit(cubit);},
                                         style: ElevatedButton.styleFrom(
                                           backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                         ),
                                         child: Text(cubit.isLogin ? 'Login' : 'Sign up'),
                                       ),
                                       fallback: (context) => const Center(
                                           child: CircularProgressIndicator()),
                                     ),

                                     TextButton(
                                       onPressed: () {
                                         cubit.changeBetweenLoginSignUp();
                                       },
                                       child: Text(cubit.isLogin
                                           ? 'Create an account'
                                           : 'I already have an account'),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                           ) ,
                         ),
                       ],
                     ),
                   ),
                 ),
               );
             },
    );
  }
}
