import 'package:chat_application/screens/auth_screen/auth.dart';
import 'package:chat_application/screens/auth_screen/cubit/cubit.dart';
import 'package:chat_application/screens/chat_screen/chat.dart';
import 'package:chat_application/shared/bloc_observer.dart';
import 'package:chat_application/widgets/cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (BuildContext context) => AppWidgetsCubit(),
          lazy: false,
        ),
        BlocProvider(
        create: (BuildContext context) => AppAuthCubit(),
        ),
      ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot)
        {
          if(snapshot.connectionState == ConnectionState.waiting)
          {
            return const CircularProgressIndicator();
          }
          if(snapshot.hasData)
          {
            return const Chat();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}


