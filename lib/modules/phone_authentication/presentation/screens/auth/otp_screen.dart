// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:general/general.dart';
import 'package:phone_authentication/modules/phone_authentication/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:phone_authentication/modules/phone_authentication/presentation/cubits/verify_phone/verify_phone_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  final String number;
  const OtpScreen({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  //*variables
  StreamController<ErrorAnimationType>? errorController;
  final codeController = TextEditingController();
  String verificationId = '';
  String errormsg = '';
  late Timer timer;
  int start = 60;
  bool isWaiting = false;
  bool isResend = false;
  bool isDone = false;
  bool hasError = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    errorController?.close();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start == 0) {
        if (mounted) {
          setState(() {
            timer.cancel();
            start = 60;
            verificationId = '';
            isWaiting = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            start--;
            isWaiting = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF1B1E28),
              size: 16,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            const CustomText(
              'OTP Verification',
              color: Color(0xFF1B1E28),
              size: 26,
              weight: FontWeight.w800,
            ),
            CustomText(
              'An 4 digit code has been sent to\n+63 ${widget.number}',
              size: 16,
              weight: FontWeight.w400,
              color: const Color(0xFF7D848D),
              textAlign: TextAlign.center,
            ),
            const Spacer(flex: 3),
            const Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                'OTP Code',
                color: Color(0xFF1B1E28),
                size: 20,
                weight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 24),
            BlocListener<VerifyPhoneCubit, VerifyPhoneState>(
              listener: (context, state) {
                if (state is VerifyingNow) {
                  print('Verifying now');
                  errormsg = '';
                  verificationId = state.id;
                  codeController.text = '';
                  startTimer();
                  isResend = false;
                  setState(() {});
                } else if (state is VerifyFailed) {
                  print('Verify failed');

                  errorController?.add(ErrorAnimationType.shake);

                  setState(() {
                    hasError = true;
                    errormsg = state.message;
                  });
                } else if (state is VerifySuccess) {
                  print('Verify success');
                  codeController.text = state.smsCode;
                  setState(() {});
                } else if (state is CodeAutoRetrievalTimeout) {
                  print('CodeAutoRetrievalTimeout');
                  errormsg = 'OTP was expired';
                  hasError = true;
                  setState(() {});
                }
              },
              child: Form(
                key: formKey,
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  autoFocus: false,
                  enableActiveFill: true,
                  onChanged: (value) {
                    print(value);
                  },
                  animationType: AnimationType.fade,
                  controller: codeController,
                  keyboardType: TextInputType.number,
                  errorAnimationController: errorController,
                  validator: (v) {
                    if (v!.length < 6) {
                      return "OTP must be 6 digits";
                    } else {
                      return null;
                    }
                  },
                  onCompleted: (smsCodeComplete) {
                    setState(() {
                      codeController.text = smsCodeComplete;
                    });
                    context.read<AuthenticationCubit>().logIn(
                          smsCode: smsCodeComplete,
                          verificationId: verificationId,
                          context: context,
                        );
                  },
                  pinTheme: PinTheme(
                    inactiveColor: Colors.grey.shade200,
                    selectedFillColor: Colors.grey.shade200,
                    inactiveFillColor: Colors.grey.shade200,
                    selectedColor: Colors.grey.shade200,
                    activeColor: Colors.grey.shade200,
                    activeFillColor:
                        hasError ? Colors.red : Colors.grey.shade200,
                    errorBorderColor: Colors.red,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(12),
                    fieldHeight: 60,
                    fieldWidth: 50,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                ),
              ),
            ),
            CustomText(
              hasError ? errormsg : "",
              color: Colors.red,
            ),
            const SizedBox(height: 42),
            BtnFilled(
              onTap: () {
                if (codeController.text.isNotEmpty &&
                    verificationId.isNotEmpty) {
                  context.read<AuthenticationCubit>().logIn(
                        smsCode: codeController.text,
                        verificationId: verificationId,
                        context: context,
                      );
                }
              },
              text: 'VERIFY',
              radius: 16,
              height: 55,
            ),
            isWaiting
                ? TextButton(
                    onPressed: () {},
                    child: Text('Send otp again in $start'),
                  )
                : const SizedBox(),
            const Spacer(flex: 6),
            BlocListener<AuthenticationCubit, AuthenticationState>(
              child: const SizedBox(),
              listener: (context, state) {
                if (state is Authenticated) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (Navigator.canPop(context)) Navigator.pop(context);
                  });
                } else if (state is AuthenticationError) {
                  errorController!.add(ErrorAnimationType
                      .shake); // Triggering error shake animation
                  setState(() {
                    errormsg = state.errormsg;
                    hasError = true;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
