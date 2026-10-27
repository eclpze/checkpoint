import 'package:checkpoint/domain/prefs.dart';
import 'package:checkpoint/domain/userWallet.dart';
import 'package:checkpoint/presentation/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vize/vize.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Prefs.init();
  await UserWallet().loadBalance();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Vize.init(context, figmaWidth: 375, figmaHeight: 812);

    return MaterialApp(home: SplashScreen(), debugShowCheckedModeBanner: false);
  }
}


