import 'package:get_it/get_it.dart';
import 'package:totp_authenticator/core/core.dart';
import 'package:totp_authenticator/view/view.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDI() async {
  getIt.registerLazySingleton<SecureStorageService>(() => SecureStorageService());

  getIt.registerFactory<TotpService>(() => const TotpService());

  getIt.registerFactory<CodesProvider>(() => CodesProvider(secureStorageService: getIt()));

  getIt.registerFactory<SingleCodeProvider>(
    () => SingleCodeProvider(totpService: getIt()),
  );
}
