import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:phone_authentication/modules/phone_authentication/presentation/cubits/information/information_cubit.dart';

class ProfileVerification extends StatefulWidget {
  const ProfileVerification({super.key});

  @override
  State<ProfileVerification> createState() => _ProfileVerificationState();
}

class _ProfileVerificationState extends State<ProfileVerification> {
  final fullname = TextEditingController();
  final email = TextEditingController();
  final fbLink = TextEditingController();
  @override
  void dispose() {
    fullname.dispose();
    email.dispose();
    fbLink.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Spacer(),
          CustomTextField('Fullname', controller: fullname),
          CustomTextField('Email', controller: email),
          CustomTextField('Facebook Link', controller: fbLink),
          const Spacer(),
          BlocConsumer<InformationCubit, InformationState>(
            listener: (context, state) {
              if (state is InformationError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    // duration: Duration(milliseconds: 120),
                    backgroundColor: Colors.red,
                    content: CustomText(
                      state.message,
                      color: Colors.white,
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is InformationLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ElevatedButton(
                onPressed: () {
                  context.read<InformationCubit>().updateProfile(
                        email: email.text,
                        fullname: fullname.text,
                      );
                },
                child: const Text('SUBMIT'),
              );
            },
          )
        ],
      ),
    );
  }
}
