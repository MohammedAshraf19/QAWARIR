import 'dart:async';

import 'package:flutter/material.dart';
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
  _startDelay(){
    _timer = Timer(const Duration(seconds: AppConstant.splashDelay),_goNext);

  }
  _goNext(){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnBoardingScreen(),)
      );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startDelay();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(
            image: AssetImage(
              AssetManager.splashLogo
            ),
        ),
      ),
    );
  }
}
