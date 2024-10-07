import 'package:get_it/get_it.dart';
import 'package:totp_authenticator/core/core.dart';
import 'package:totp_authenticator/view/codes/provider/codes_provider.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDI() async {
  getIt.registerLazySingleton<SecureStorageService>(() => SecureStorageService());

  getIt.registerFactory<TotpHelper>(() => TotpHelper());

  getIt.registerFactory<TotpService>(() => TotpService(totpHelper: getIt()));

  getIt.registerFactory<CodesProvider>(() => CodesProvider(secureStorageService: getIt()));
}
