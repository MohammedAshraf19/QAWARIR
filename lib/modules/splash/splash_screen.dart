import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qawarir/layout/qawarir_layout.dart';
import 'package:qawarir/modules/on_boarding/on_boarding_screen.dart';
import 'package:qawarir/shared/components/constants.dart';
import 'package:qawarir/shared/style/asset_manager.dart';
import 'package:qawarir/shared/style/color_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _timer;
  _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstant.splashDelay), _goNext);
  }

  _goNext() {
    if (uId == null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OnBoardingScreen(),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QawarirLayout(),
          ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.primary,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: ColorManager.primary,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: ColorManager.primary,
      ),
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(
          image: AssetImage(AssetManager.splashLogo),
        ),
      ),
    );
  }
}
