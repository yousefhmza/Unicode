import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicode/core/services/background_service/background_service.dart';
import 'package:unicode/modules/auth/cubits/auth_cubit.dart';
import 'package:unicode/modules/categories/cubits/categories_cubit.dart';
import 'package:unicode/modules/layout/cubits/layout_cubit.dart';
import 'package:unicode/modules/profile/cubits/profile_cubit.dart';
import 'package:unicode/modules/todos/cubits/todos_cubit.dart';
import 'config/localization/cubit/l10n_cubit.dart';
import 'config/localization/l10n/l10n.dart';
import 'config/navigation/navigation.dart';
import 'config/theme/light_theme.dart';
import 'core/services/bloc_observer.dart';
import 'core/services/responsive/responsive_service.dart';
import 'core/utils/constants.dart';
import 'di_container.dart' as di;
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  Bloc.observer = MyBlocObserver();
  di.sl<BackgroundService>().configure();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<L10nCubit>()),
        BlocProvider(create: (_) => di.sl<AuthCubit>()),
        BlocProvider(create: (_) => di.sl<ProfileCubit>()),
        BlocProvider(create: (_) => di.sl<LayoutCubit>()),
        BlocProvider(create: (_) => di.sl<CategoriesCubit>()),
        BlocProvider(create: (_) => di.sl<TodosCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.instance.setDeviceDimensionsType(context);
    return MaterialApp(
      title: Constants.appName,
      theme: lightTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashScreen,
      navigatorKey: NavigationService.navigationKey,
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      localizationsDelegates: L10n.localizationDelegates,
      supportedLocales: L10n.supportedLocales,
      locale: BlocProvider.of<L10nCubit>(context, listen: true).appLocale,
    );
  }
}
