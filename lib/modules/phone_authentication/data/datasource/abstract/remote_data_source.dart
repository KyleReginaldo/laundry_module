import 'package:firebase_auth/firebase_auth.dart';

abstract class RemoteDataSource {
  Future<void> login({
    required String smsCode,
    required String id,
  });
  Future<void> updateProfile({
    required String email,
    required String fullname,
  });
  Stream<User?> userCheck();
}
