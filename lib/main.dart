import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_authentication/dependency.dart';
import 'package:phone_authentication/firebase_options.dart';
import 'package:phone_authentication/modules/phone_authentication/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:phone_authentication/modules/phone_authentication/presentation/screens/auth/auth_manager.dart';

import 'modules/phone_authentication/presentation/cubits/information/information_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationCubit>(
            create: (context) => sl<AuthenticationCubit>()..userCheck(),
          ),
          BlocProvider<InformationCubit>(
            create: (context) => sl<InformationCubit>(),
          ),
        ],
        child: const AuthManager(),
      ),
    );
  }
}
