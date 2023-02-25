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
      ),
    );
  }
}
