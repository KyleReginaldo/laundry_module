import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_authentication/modules/phone_authentication/data/datasource/abstract/remote_data_source.dart';

class RemoteDataSourceImpl implements RemoteDataSource {
  final _auth = FirebaseAuth.instance;
  @override
  Future<void> login({
    required String smsCode,
    required String id,
  }) async {
    await _auth.signInWithCredential(PhoneAuthProvider.credential(
      verificationId: id,
      smsCode: smsCode,
    ));
  }

  @override
  Future<void> updateProfile({
    required String email,
    required String fullname,
  }) async {
    await _auth.currentUser!
        .updateDisplayName(fullname)
        .then((value) async => await _auth.currentUser!.updateEmail(email));
  }

  @override
  Stream<User?> userCheck() => _auth.userChanges();
}
