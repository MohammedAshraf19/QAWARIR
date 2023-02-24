import 'package:flutter/material.dart';
import 'package:qawarir/modules/login/login_screen.dart';
import 'package:qawarir/shared/style/color_manager.dart';
import 'package:qawarir/shared/style/fonts_manager.dart';
import 'package:qawarir/shared/style/string_manager.dart';
import 'package:qawarir/shared/style/styles_manager.dart';
import 'package:qawarir/shared/style/values_manager.dart';

import '../../layout/qawarir_layout.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BuildScreen(),
    );
  }
}

class BuildScreen extends StatefulWidget {
  const BuildScreen({super.key});

  @override
  State<BuildScreen> createState() => _BuildScreenState();
}

class _BuildScreenState extends State<BuildScreen> {
  bool validName = false;
  bool validEmail = false;
  bool validPassword = false;
  bool enableButton = false;
  final nameController = TextEditingController();
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
          fillColor: ColorManager.grey,
          enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.primary, width: AppSize.s2)),
          focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.primary, width: AppSize.s3)),
          label: Text(label),
       //   floatingLabelStyle: const TextStyle(fontSize: FontSize.s16, color: Colors.grey),
          labelStyle:getRegularStyle(color: ColorManager.primary),
        ),
        validator: (String? value) {
          if (value != null) {
            return value.length < 8 ? 'Minimum password length is 8' : null;
          }
        });
  }

  buildBigButton(String text, Function()? function) {
    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
            backgroundColor: ColorManager.primary,
            disabledBackgroundColor: Colors.grey,
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
    Widget signupPicture = const SizedBox(
      child: Image(image: AssetImage('assets/images/login.png')),
    );

    Widget signupTitle = Text(
      AppStrings.signUp,
      style: getBoldStyle(color: ColorManager.black),
    );

    Widget signupSubTitle = Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s60),
      child: Text(
        AppStrings.signupSubTitle,
        textAlign: TextAlign.center,
        style: getRegularStyle(color: Colors.grey),
      ),
    );

    Widget haveAccount = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.HaveAccount,
          style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
          child: Text(
            AppStrings.signIn,
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: FontSize.s16,
                fontWeight: FontsWeightManager.medium,
                color: ColorManager.primary
            ),
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

    nameController.addListener(() {
      setState(() {
        validName = nameController.text.isNotEmpty;
        enableButton = validName && validEmail && validPassword;
      });
    });

    emailController.addListener(() {
      setState(() {
        validEmail = emailController.text.isNotEmpty;
        enableButton = validName && validEmail && validPassword;
      });
    });

    passwordController.addListener(() {
      setState(() {
        validPassword = !(passwordController.text.length < 8);
        enableButton = validName && validEmail && validPassword;
      });
    });

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
                signupPicture,
                medEmptyBox,
                signupTitle,
                smallEmptyBox,
                signupSubTitle,
                smallEmptyBox,
                buildTextField(nameController, AppStrings.fullName, false),
                smallEmptyBox,
                buildTextField(emailController, AppStrings.email, false),
                smallEmptyBox,
                buildTextField(passwordController, AppStrings.password, true),
                smallEmptyBox,
                buildBigButton(
                    AppStrings.signIn,
                    enableButton
                        ? () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QawarirLayout()))
                        : null),
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
