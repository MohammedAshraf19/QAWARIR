import 'package:flutter/material.dart';
import 'package:qawarir/shared/style/asset_manager.dart';
import 'package:qawarir/shared/style/string_manager.dart';
import 'package:qawarir/shared/style/styles_manager.dart';
import 'package:qawarir/modules/login/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/style/color_manager.dart';
import '../../shared/style/values_manager.dart';

class BorderShow {
  String image;
  String title;
  String body;
  BorderShow({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();
  bool isLast = false;
  List<BorderShow> border = [
    BorderShow(
        image: AssetManager.onBoarding1,
        title: AppStrings.onBoardingTitle1,
        body: AppStrings.onBoardingSubTitle1),
    BorderShow(
        image: AssetManager.onBoarding2,
        title: AppStrings.onBoardingTitle2,
        body: AppStrings.onBoardingSubTitle2),
    BorderShow(
        image: AssetManager.onBoarding3,
        title: AppStrings.onBoardingTitle3,
        body: AppStrings.onBoardingSubTitle3),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      ClipPath(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.32,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: AppPadding.p18, top: AppPadding.p16),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Image(
                                image: AssetImage(border[index].image),
                                //  height: 500,
                              ),
                            ),
                          ),
                        ),
                        clipper: CustomClipPath(),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 100,
                        child: Image(
                          image: const AssetImage(AssetManager.onBoarding),
                          height: MediaQuery.of(context).size.height / 2.5,
                          width: MediaQuery.of(context).size.width,
                          // to make image take full width
                          fit: BoxFit.fill,
                          //  height: 500,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 2.3,
                        left: MediaQuery.of(context).size.width / 3.4,
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          border[index].title,
                          style: getBoldStyle(color: ColorManager.white),
                        ),
                      ),
                      const SizedBox(
                        height: AppSize.s12,
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 2,
                        left: MediaQuery.of(context).size.width / 6,
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: Text(
                          border[index].body,
                          style: getRegularStyle(color: ColorManager.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
                itemCount: border.length,
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == border.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: border.length,
              effect: ExpandingDotsEffect(
                dotColor: ColorManager.white.withOpacity(.2),
                activeDotColor: ColorManager.white,
                dotHeight: 8,
                expansionFactor: 4,
                dotWidth: 12,
                spacing: 4,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            if (isLast != true)
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastOutSlowIn);
                    },
                    child: Text(
                      'Next',
                      style: getMediumStyle(color: ColorManager.primary),
                    )),
              ),
            if (isLast == true)
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      'Create an Account',
                      style: getMediumStyle(color: ColorManager.primary),
                    )),
              ),
            if (isLast != true)
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  'skip',
                  style: getMediumStyle(color: ColorManager.white),
                ),
              ),
            const SizedBox(
              height: AppSize.s20,
            ),
            if (isLast == true)
              const SizedBox(
                height: AppSize.s50,
              ),
          ],
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 5.0;
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.75);

    path.quadraticBezierTo(size.width * 0.35, size.height * 1.2,
        size.width * 0.8, size.height * 0.65);

    path.lineTo(size.width, size.height * 0.9);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
