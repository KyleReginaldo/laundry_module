import 'package:general/service/print.dart';

String errorCode(String code) {
  show('Error Code $code');
  switch (code) {
    case 'invalid-verification-code':
      return 'Wrong pin code. Please double check your One Time Pin(OTP) on your messages sent by CloudOTP';
    case 'network-request-failed':
      return 'Please double check your connection. Try to reconnect your wifi on the settings';
    case 'invalid-verification-id':
      return 'Please double check your connection. Try again';
    case 'missing-client-identifier':
      return 'Please complete the security protocol to send OTP on your phone number. Try Resend Code below';
    case 'invalid-email':
      return 'Invalid email! Please try another email';
    case 'email-already-in-use':
      return 'Email already exist! Please try another email';
    case 'requires-recent-login':
      return 'This is unfortunate. Please reinstall the app to make it work';
    default:
      return 'Oops! Unexpected Error\nFor Developers: $code';
  }
}
