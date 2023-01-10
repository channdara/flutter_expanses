import 'package:flutter/material.dart';

import '../../../common/base/base_state.dart';
import '../../../common/color_constant.dart';
import '../../../common/extension/context_extension.dart';
import '../main_screen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    expansesService.checkCurrentDate().whenComplete(() {
      savingService.checkCurrentDate().whenComplete(() {
        context.pushClearTop(const MainScreen());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: ColorConstant.colorPrimary);
  }
}
