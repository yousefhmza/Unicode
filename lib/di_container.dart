import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:unicode/core/services/background_service/background_service.dart';
import 'package:unicode/core/services/local/local_database.dart';
import 'package:unicode/modules/auth/cubits/auth_cubit.dart';
import 'package:unicode/modules/auth/repositories/auth_repository.dart';
import 'package:unicode/modules/categories/cubits/categories_cubit.dart';
import 'package:unicode/modules/categories/repositories/categories_repository.dart';
import 'package:unicode/modules/layout/cubits/layout_cubit.dart';
import 'package:unicode/modules/profile/repositories/profile_repository.dart';
import 'package:unicode/modules/todos/cubits/todos_cubit.dart';
import 'package:unicode/modules/todos/repositories/todos_repository.dart';

import 'config/localization/cubit/l10n_cubit.dart';
import 'core/services/local/cache_client.dart';
import 'core/services/network/network_info.dart';
import 'modules/profile/cubits/profile_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // external
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  // core
  sl.registerLazySingleton<CacheClient>(() => CacheClient(sl<SharedPreferences>(), sl<FlutterSecureStorage>()));
  sl.registerLazySingleton<LocalDatabase>(() => LocalDatabase()..initDatabase());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfo(sl<Connectivity>()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl<CacheClient>(), sl<LocalDatabase>(), sl<NetworkInfo>()));
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepository(sl<CacheClient>(), sl<NetworkInfo>()));
  sl.registerLazySingleton<CategoriesRepository>(() => CategoriesRepository(sl<CacheClient>(), sl<LocalDatabase>(), sl<NetworkInfo>()));
  sl.registerLazySingleton<TodosRepository>(() => TodosRepository(sl<CacheClient>(), sl<LocalDatabase>(), sl<NetworkInfo>()));

  // Services
  sl.registerLazySingleton<BackgroundService>(() => BackgroundService(sl<CategoriesRepository>(), sl<TodosRepository>()));

  // View models
  sl.registerFactory<L10nCubit>(() => L10nCubit(sl<CacheClient>())..initLocale());
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl<AuthRepository>()));
  sl.registerFactory<ProfileCubit>(() => ProfileCubit(sl<ProfileRepository>(), sl<CategoriesRepository>(), sl<TodosRepository>(), sl<AuthRepository>()));
  sl.registerFactory<CategoriesCubit>(() => CategoriesCubit(sl<CategoriesRepository>()));
  sl.registerFactory<TodosCubit>(() => TodosCubit(sl<TodosRepository>()));
  sl.registerFactory<LayoutCubit>(() => LayoutCubit());
}
