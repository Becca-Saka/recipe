import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:recipe/data/providers/dashboard_provider.dart';
import 'package:recipe/data/providers/recipe_provider.dart';
import 'package:recipe/data/providers/user_provider.dart';
import 'package:recipe/firebase_options.dart';
import 'package:recipe/shared/app_snackbar.dart';
import 'package:recipe/ui/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.library == 'image resource service') {
      return;
    }
  };
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (context) => RecipeProvider()),
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldKey,
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: 'SF Pro',
        ),
        home: const SplashView(),
      ),
    );
  }
}
