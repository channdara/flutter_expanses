import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'src/common/color_constant.dart';
import 'src/ui/screen/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      theme: ThemeData(
        fontFamily: 'ProductSan',
        primarySwatch: ColorConstant.materialColor,
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          foregroundColor: Colors.black,
        ),
      ),
    );
  }
}
