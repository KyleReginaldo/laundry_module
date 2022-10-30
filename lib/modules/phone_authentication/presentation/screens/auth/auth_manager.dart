import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:phone_authentication/modules/phone_authentication/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:phone_authentication/modules/phone_authentication/presentation/screens/auth/enterphone_screen.dart';
import 'package:phone_authentication/modules/phone_authentication/presentation/screens/auth/profile_verification.dart';
import 'package:phone_authentication/modules/phone_authentication/presentation/screens/mains/home_screen.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          String email = state.user?.email ?? '';
          show('email: $email');
          //!your home screen
          return const HomeScreen();
        } else if (state is NewUser) {
          return const ProfileVerification();
        }
        return const EnterPhoneScreen();
      },
    );
  }
}
