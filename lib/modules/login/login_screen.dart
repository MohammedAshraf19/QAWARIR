import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawarir/layout/qawarir_layout.dart';
import 'package:qawarir/modules/login/cubit/login_cubit.dart';
import 'package:qawarir/shared/components/constants.dart';
import 'package:qawarir/shared/style/color_manager.dart';
import 'package:qawarir/shared/style/fonts_manager.dart';
import 'package:qawarir/shared/style/string_manager.dart';
import 'package:qawarir/shared/style/styles_manager.dart';
import 'package:qawarir/shared/style/values_manager.dart';
import 'package:qawarir/modules/register/Register_screen.dart';

import '../../layout/cubit/app_cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    var formKey = GlobalKey<FormState>();
    final passwordController = TextEditingController();
    final emailController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if(state is AppLoginError){
            showToast(txt: state.error.toString(), state: ToastState.ERROR);
          }
          if(state is AppLoginSuccess) {
            if(LoginCubit.get(context).isRemember) {
              CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              showToast(txt: 'Access Login', state: ToastState.SUCCESS);
              uId = CacheHelper.getData(key: 'uId');
              AppCubit.get(context).getUserData();
              Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=>QawarirLayout())
              );
            });
            }
            else{
              showToast(txt: 'Access Login', state: ToastState.SUCCESS);
              AppCubit.get(context).getUserData();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=>QawarirLayout())
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          Widget haveAccount = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.dontHaveAccount,
                style: getRegularStyle(
                    color: ColorManager.black, fontSize: FontSize.s14),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: Text(
                  AppStrings.createOne,
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
          Widget rememberMe = Row(
            children: [
              Checkbox(
                value: cubit.isRemember,
                activeColor: ColorManager.primary,
                onChanged: (newBool) {
                  cubit.changeRemember(newBool!);
                },
              ),
              const Text(AppStrings.rememberMe)
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
                      color: ColorManager.primary,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          );
          Widget loginPicture = const SizedBox(
            child: Image(image: AssetImage('assets/images/login.png')),
          );
          return Scaffold(
            appBar: AppBar(
            ),
            body: Form(
              key: formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          loginPicture,
                          bigEmptyBox(),
                          authTitle(AppStrings.signIn),
                          smallEmptyBox(),
                          authSubTitle(AppStrings.loginSubTitle),
                          smallEmptyBox(),
                          buildTextField(
                              emailController, AppStrings.email, false),
                          smallEmptyBox(),
                          buildTextField(
                              passwordController, AppStrings.password, true),
                          optionsRow,
                          smallEmptyBox(),
                          BuildCondition(
                            condition: state is! AppLoginLoading,
                            builder: (context)=>buildBigButton(
                              AppStrings.signIn,
                                  () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                            ),
                            fallback: (context)=>circularIndicator(color: ColorManager.primary),
                          ),
                          smallEmptyBox(),
                          haveAccount,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
=======
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => QawarirLayout()));
            },
            child: Text(
              'skip',
              style: getMediumStyle(color: ColorManager.black),
            ),
          ),
        ],
      ),
      body: BuildScreen(),
    );
  }
}

class BuildScreen extends StatefulWidget {
  const BuildScreen({super.key});

  @override
  State<BuildScreen> createState() => BuildScreenState();
}

class BuildScreenState extends State<BuildScreen> {
  bool? isChecked = false;
  bool validEmail = false;
  bool validPassword = false;
  bool enableButton = false;
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
          // floatingLabelStyle: TextStyle(fontSize: FontSize.s16, color: ColorManager.primary),
          labelStyle: getRegularStyle(color: ColorManager.primary),
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
            backgroundColor: ColorManager.primary,
            disabledBackgroundColor: Colors.grey,
            minimumSize: const Size.fromHeight(50),
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
          style: getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s14),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterScreen()));
          },
          child: Text(
            AppStrings.createOne,
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: FontSize.s16,
                fontWeight: FontsWeightManager.medium,
                color: ColorManager.primary),
          ),
        )
      ],
    );

    Widget rememberMe = Row(
      children: [
        Checkbox(
          value: isChecked,
          activeColor: ColorManager.primary,
          onChanged: (newBool) {
            setState(() {
              isChecked = newBool;
            });
          },
        ),
        const Text(AppStrings.rememberMe)
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
                color: ColorManager.primary,
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

    emailController.addListener(() {
      setState(() {
        validEmail = emailController.text.isNotEmpty;
        enableButton = validEmail && validPassword;
      });
    });

    passwordController.addListener(() {
      setState(() {
        validPassword = !(passwordController.text.length < 8);
        enableButton = validEmail && validPassword;
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
          buildBigButton(
              AppStrings.signIn,
              enableButton
                  ? () => Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => QawarirLayout()))
                  : null),
          smallEmptyBox,
          haveAccount,
        ],
>>>>>>> f11c734b97c4164ae1d8a841f83f1d97cbc5258a
      ),
    ))));
  }
}
