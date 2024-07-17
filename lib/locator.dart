import 'package:C4CARE/Navigation/nav.dart';
import 'package:C4CARE/Provider/login.provider.dart';
import 'package:C4CARE/Provider/profile.provider.dart';
import 'package:C4CARE/repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dio/dio_client.dart';
import 'Dio/log_interceptor.dart';
import 'Provider/attendance_provider.dart';

final loc = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  loc.registerLazySingleton(() => sharedPreferences);
  loc.registerLazySingleton(() => Dio());
  loc.registerLazySingleton(() => LoggingInterceptor());
  loc.registerLazySingleton(() => NavigationService());

  // loc.registerLazySingleton(() => UserPreferences());
  loc.registerLazySingleton(() => DioClient(
        // StringConst.BASE_URL,
        "",
        loc(),
        loggingInterceptor: loc(),
        sharedPreferences: loc(),
        navigationService: loc(),
      ));

  // Repository
  loc.registerLazySingleton(
      () => Repo(sharedPreferences: loc(), dioClient: loc()));

  // provider
  loc.registerFactory(() => LoginUser(
        sharedPreferences: loc(),
        dioClient: loc(),
        repo: loc(),
        ns: loc(),
      ));
  loc.registerFactory(() => ProfileProvider(
        sharedPreferences: loc(),
        dioClient: loc(),
        repo: loc(),
        ns: loc(),
      ));

  loc.registerFactory(() => AttendanceProvider(
        repo: loc(),
        ns: loc(),
        sharedPreferences: loc(),
      ));
}
