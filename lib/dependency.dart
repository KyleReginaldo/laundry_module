import 'package:get_it/get_it.dart';
import 'package:phone_authentication/modules/phone_authentication/data/datasource/abstract/remote_data_source.dart';
import 'package:phone_authentication/modules/phone_authentication/domain/usecase/login.dart';
import 'package:phone_authentication/modules/phone_authentication/domain/usecase/update_profile.dart';
import 'package:phone_authentication/modules/phone_authentication/presentation/cubits/authentication/authentication_cubit.dart';
import 'package:phone_authentication/modules/phone_authentication/presentation/cubits/information/information_cubit.dart';
import 'package:phone_authentication/modules/phone_authentication/presentation/cubits/verify_phone/verify_phone_cubit.dart';
import 'modules/phone_authentication/data/datasource/implementation/remote_data_source_impl.dart';
import 'modules/phone_authentication/data/repository_impl/phone_repository_impl.dart';
import 'modules/phone_authentication/domain/repository/phone_repository.dart';
import 'modules/phone_authentication/domain/usecase/usercheck.dart';

final sl = GetIt.instance;

Future init() async {
  sl.registerFactory(() => AuthenticationCubit(sl(), sl(), sl()));
  sl.registerFactory(() => VerifyPhoneCubit());
  sl.registerFactory(() => InformationCubit(sl()));

  sl.registerLazySingleton(() => LogIn(repo: sl()));
  sl.registerLazySingleton(() => UpdateProfile(repo: sl()));
  sl.registerLazySingleton(() => UserCheck(repo: sl()));

  sl.registerFactory<PhoneRepository>(() => PhoneRepositoryImpl(remote: sl()));

  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());
}
