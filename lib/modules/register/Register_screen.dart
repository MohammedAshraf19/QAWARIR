import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawarir/layout/cubit/app_cubit.dart';
import 'package:qawarir/modules/login/login_screen.dart';
import 'package:qawarir/modules/register/cubit/register_cubit.dart';
import 'package:qawarir/shared/components/constants.dart';
import 'package:qawarir/shared/style/color_manager.dart';
import 'package:qawarir/shared/style/fonts_manager.dart';
import 'package:qawarir/shared/style/string_manager.dart';
import 'package:qawarir/shared/style/styles_manager.dart';
import 'package:qawarir/shared/style/values_manager.dart';
import '../../layout/qawarir_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    Widget signupPicture = const SizedBox(
      child: Image(image: AssetImage('assets/images/login.png')),
    );
    Widget haveAccount = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.HaveAccount,
          style: getRegularStyle(
              color: ColorManager.black, fontSize: FontSize.s14),
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

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if(state is AppCreateUserSuccess) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              showToast(txt: 'Access Login', state: ToastState.SUCCESS);
              uId = CacheHelper.getData(key: 'uId');
              AppCubit.get(context).getUserData();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=>QawarirLayout())
              );
            });
          }
          else if(state is AppCreateUserError){
            showToast(txt: state.error, state: ToastState.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            body: Form(
              key: formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          medEmptyBox(),
                          signupPicture,
                          medEmptyBox(),
                          authTitle(AppStrings.signUp),
                          smallEmptyBox(),
                          authSubTitle(AppStrings.signupSubTitle),
                          smallEmptyBox(),
                          buildTextField(
                            nameController, AppStrings.fullName, false,),
                          smallEmptyBox(),
                          buildTextField(
                            emailController, AppStrings.email, false,),
                          smallEmptyBox(),
                          buildTextField(
                            passwordController, AppStrings.password, true,),
                          smallEmptyBox(),
                          BuildCondition(
                            condition: state is! AppRegisterLoading,
                            builder: (context)=> buildBigButton(
                                AppStrings.signIn,
                                    () {
                                      if(formKey.currentState!.validate()){
                                        cubit.userRegister(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                        );
                                      }
                                }
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

// class BuildScreen extends StatefulWidget {
//   const BuildScreen({super.key});
//
//   @override
//   State<BuildScreen> createState() => _BuildScreenState();
// }
//
// class _BuildScreenState extends State<BuildScreen> {
//   bool validName = false;
//   bool validEmail = false;
//   bool validPassword = false;
//   bool enableButton = false;
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//
//   buildBigButton(String text, Function()? function) {
//     return SizedBox(
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//             minimumSize: const Size.fromHeight(50),
//             backgroundColor: ColorManager.primary,
//             disabledBackgroundColor: Colors.grey,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30))),
//         onPressed: function,
//         child: Text(
//           text,
//           style: TextStyle(fontSize: FontSize.s16, color: ColorManager.white),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Widget signupPicture = const SizedBox(
//       child: Image(image: AssetImage('assets/images/login.png')),
//     );
//
//     Widget signupTitle = Text(
//       AppStrings.signUp,
//       style: getBoldStyle(color: ColorManager.black),
//     );
//
//     Widget signupSubTitle = Padding(
//       padding: const EdgeInsets.symmetric(horizontal: AppSize.s60),
//       child: Text(
//         AppStrings.signupSubTitle,
//         textAlign: TextAlign.center,
//         style: getRegularStyle(color: Colors.grey),
//       ),
//     );
//
//     Widget haveAccount = Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           AppStrings.HaveAccount,
//           style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14),
//         ),
//         GestureDetector(
//           onTap: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => const LoginScreen()));
//           },
//           child: Text(
//             AppStrings.signIn,
//             style: TextStyle(
//                 decoration: TextDecoration.underline,
//                 fontSize: FontSize.s16,
//                 fontWeight: FontsWeightManager.medium,
//                 color: ColorManager.primary
//             ),
//           ),
//         )
//       ],
//     );
//
//     Widget smallEmptyBox = Container(
//       height: AppSize.s18,
//     );
//
//     Widget medEmptyBox = Container(
//       height: AppSize.s34,
//     );
//
//     Widget bigEmptyBox = Container(
//       height: AppSize.s40,
//     );
//
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 medEmptyBox,
//                 signupPicture,
//                 medEmptyBox,
//                 signupTitle,
//                 smallEmptyBox,
//                 signupSubTitle,
//                 smallEmptyBox,
//                 buildTextField(nameController, AppStrings.fullName, false),
//                 smallEmptyBox,
//                 buildTextField(emailController, AppStrings.email, false),
//                 smallEmptyBox,
//                 buildTextField(passwordController, AppStrings.password, true),
//                 smallEmptyBox,
//                 buildBigButton(
//                     AppStrings.signIn,
//                     enableButton
//                         ? () => Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => QawarirLayout()))
//                         : null),
//                 smallEmptyBox,
//                 haveAccount,
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
