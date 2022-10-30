// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:phone_authentication/modules/phone_authentication/domain/repository/phone_repository.dart';

class UserCheck {
  final PhoneRepository repo;
  UserCheck({
    required this.repo,
  });

  Stream<User?> call() {
    return repo.userCheck();
  }
}
