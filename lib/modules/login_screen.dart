import 'package:flutter/material.dart';
import 'package:qawarir/shared/style/color_manager.dart';
import 'package:qawarir/shared/style/fonts_manager.dart';
import 'package:qawarir/shared/style/string_manager.dart';
import 'package:qawarir/shared/style/styles_manager.dart';
import 'package:qawarir/shared/style/values_manager.dart';

import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BuildScreen(),
    );
  }
}

class BuildScreen extends StatefulWidget {
  BuildScreen({super.key});

  @override
  State<BuildScreen> createState() => BuildScreenState();
}

class BuildScreenState extends State<BuildScreen> {
  bool? isChecked = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  buildTextField(
      TextEditingController controller, String label, bool isPassword) {
    return TextFormField(
        controller: controller,
        obscureText: isPassword,
        obscuringCharacter: '*',
        autovalidateMode: isPassword
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        decoration: InputDecoration(
          fillColor: ColorManager.lightPink,
          enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.darkPink, width: AppSize.s2)),
          focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.darkPink, width: AppSize.s3)),
          label: Text(label),
          floatingLabelStyle:
              const TextStyle(fontSize: FontSize.s16, color: Colors.grey),
          labelStyle:
              const TextStyle(fontSize: FontSize.s16, color: Colors.grey),
        ),
        validator: (String? value) {
          if (value != null) {
            return value.length < 8 ? 'Minimum password length is 8' : null;
          }
        });
  }

  buildBigButton(String text, Function() function) {
    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            backgroundColor: ColorManager.darkPink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(fontSize: FontSize.s16, color: ColorManager.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget loginPicture = const SizedBox(
      child: Image(image: AssetImage('assets/images/login.png')),
    );

    Widget loginTitle = Text(
      AppStrings.signIn,
      style: getBoldStyle(color: ColorManager.black),
    );

    Widget loginSubTitle = Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s60),
      child: Text(
        AppStrings.loginSubTitle,
        textAlign: TextAlign.center,
        style: getRegularStyle(color: Colors.grey),
      ),
    );

    Widget haveAccount = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.dontHaveAccount,
          style: TextStyle(fontSize: FontSize.s14, color: ColorManager.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignupScreen()));
          },
          child: Text(
            AppStrings.createOne,
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: FontSize.s14,
                color: ColorManager.darkPink),
          ),
        )
      ],
    );

    Widget rememberMe = Row(
      children: [
        Checkbox(
          value: isChecked,
          activeColor: ColorManager.darkPink,
          onChanged: (newBool) {
            setState(() {
              isChecked = newBool;
            });
          },
        ),
        Text(AppStrings.rememberMe)
      ],
    );
    Widget optionsRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        rememberMe,
        GestureDetector(
          onTap: () => null,
          child: Text(
            AppStrings.forgetPassword,
            style: TextStyle(
                color: ColorManager.darkPink,
                decoration: TextDecoration.underline),
          ),
        )
      ],
    );

    Widget smallEmptyBox = Container(
      height: AppSize.s18,
    );

    Widget medEmptyBox = Container(
      height: AppSize.s34,
    );

    Widget bigEmptyBox = Container(
      height: AppSize.s40,
    );

    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                medEmptyBox,
                loginPicture,
                bigEmptyBox,
                loginTitle,
                smallEmptyBox,
                loginSubTitle,
                smallEmptyBox,
                buildTextField(emailController, AppStrings.email, false),
                smallEmptyBox,
                buildTextField(passwordController, AppStrings.password, true),
                optionsRow,
                smallEmptyBox,
                buildBigButton(AppStrings.signIn, () => null),
                smallEmptyBox,
                haveAccount,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
