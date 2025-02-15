import 'package:floating_logger_boilerplate/packages/packages.dart';

final getIt = GetIt.instance;

Future<void> initInjection(EnvServer envServer) async {
  getIt.registerSingleton<EnvServer>(envServer);
  getIt.registerLazySingleton<CustomLocalPref>(
    () => CustomLocalPref(),
  );
}
