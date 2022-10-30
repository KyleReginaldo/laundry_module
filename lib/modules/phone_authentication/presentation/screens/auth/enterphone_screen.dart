import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:general/general.dart';
import 'package:phone_authentication/modules/phone_authentication/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:phone_authentication/modules/phone_authentication/presentation/cubits/verify_phone/verify_phone_cubit.dart';
import 'package:phone_authentication/modules/phone_authentication/presentation/screens/auth/otp_screen.dart';

import '../../../../../dependency.dart';

class EnterPhoneScreen extends StatefulWidget {
  const EnterPhoneScreen({super.key});

  @override
  State<EnterPhoneScreen> createState() => _EnterPhoneScreenState();
}

class _EnterPhoneScreenState extends State<EnterPhoneScreen> {
  final phoneController = TextEditingController();
  final phoneController2 = MaskedTextController(mask: '000 000 0000');
  @override
  void dispose() {
    phoneController.dispose();
    phoneController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 4),
            const CustomText(
              'Create your Account',
              size: 26,
              weight: FontWeight.w800,
              color: Color(0xFF1B1E28),
            ),
            const CustomText(
              'Please put your phone number and create account',
              size: 14,
              weight: FontWeight.w400,
              color: Color(0xFF7D848D),
            ),
            Image.asset('assets/your_name.png'),
            CustomTextField(
              '000 000 0000',
              controller: phoneController2,
              bgColor: Colors.grey.shade200,
              radius: 16,
              keyboard: const TextInputType.numberWithOptions(),
              prefix: TextButton(
                onPressed: () {},
                child: const CustomText('+63'),
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                    text:
                        'By providing my phone number. I hereby agree and accept the ',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  TextSpan(
                    text: 'Terms ',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: 'and ',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  TextSpan(
                    text: 'Privacy ',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: 'in use on Appname.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 6),
            BtnFilled(
              onTap: () {
                if (phoneController2.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider<AuthenticationCubit>(
                            create: (context) => sl<AuthenticationCubit>(),
                          ),
                          BlocProvider<VerifyPhoneCubit>(
                            create: (context) => sl<VerifyPhoneCubit>()
                              ..verifyPhone(
                                phoneController2.text.replaceAll(' ', ''),
                              ),
                          ),
                        ],
                        child: OtpScreen(
                          number: phoneController2.text.replaceAll(' ', ''),
                        ),
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          const CustomText('Please enter your phone number'),
                      duration: const Duration(milliseconds: 400),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 16,
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  );
                }
              },
              text: 'VERIFY',
              radius: 16,
              height: 55,
            ),
          ],
        ),
      ),
    );
  }
}
