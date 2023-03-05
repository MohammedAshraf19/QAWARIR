import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:qawarir/layout/cubit/app_cubit.dart';
import 'package:qawarir/modules/home/home_screen.dart';
import 'package:qawarir/shared/components/components.dart';
import 'package:qawarir/shared/components/constants.dart';
import 'package:qawarir/shared/style/asset_manager.dart';
import 'package:qawarir/shared/style/color_manager.dart';
import 'package:qawarir/shared/style/fonts_manager.dart';
import 'package:qawarir/shared/style/styles_manager.dart';
import 'package:qawarir/shared/style/values_manager.dart';

class QawarirLayout extends StatelessWidget {
  var patientNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
    if(state is AppTestImagePickedLoadingState){
      showDialog(
        context: context,
        builder: (context)=>Lottie.asset(AssetManager.testImageAnimation),
      );
    }
    if(state is AppTestImagePickedSuccessState){
      showDialog(
          context: context,
          builder: (context)=>AlertDialog(
            title: Column(
              children: [
                Lottie.asset(AssetManager.done_button),
                const SizedBox(
                  height: AppSize.s4,
                ),
                Text(
                  'Bengin',
                  style: getBoldStyle(color: ColorManager.begin_color,fontSize: FontSize.s32),
                ),
              ],
            ),
           content: RichText(
               text: TextSpan(
                 children: [
                   TextSpan(
                     text: 'Congratulations..',
                     style: getMediumStyle(color: ColorManager.black)
                   ),
                   TextSpan(
                       text: 'The Result of your histopathological Image is',
                       style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14)
                   ),
                   TextSpan(
                       text: 'Bengin.',
                       style: getMediumStyle(color: ColorManager.black)
                   ),
                   TextSpan(
                       text: 'Now, you can save the patient data.',
                       style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14)
                   ),
                 ]
               ),
           ),
            actions: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height/20,
                  width: MediaQuery.of(context).size.width/1.5,
                  child: buildBigButton(
                      'Save', () {
                        Navigator.pop(context);
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  topRight: Radius.circular(32),
                                )
                            ),
                          isScrollControlled: true,
                            context: context,
                            builder: (context)=> Padding(
                              padding: const EdgeInsets.all(AppPadding.p12),
                              child: FractionallySizedBox(
                                heightFactor: 0.4,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                            'Save patient data',
                                          style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s20),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(AppPadding.p12),
                                          child: InkWell(
                                            onTap: (){
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              height: 32,
                                              width: 32,
                                              color: ColorManager.grey,
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Just enter the patient\'s name. The image and date are saved automatically to avoid errors.',
                                      style: getRegularStyle(color: ColorManager.black.withOpacity(0.5)),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height/25,
                                    ),
                                    buildTextField(
                                      patientNameController,
                                        'Patient Name',
                                        false,
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height/40,
                                    ),
                                    buildBigButton(
                                        'Save',
                                            () {
                                          AppCubit.get(context).uploadTestImage(
                                            name: patientNameController.text,
                                            date: 'Feb 26,23',
                                            status: 'Begin'
                                          );
                                          Navigator.pop(context);
                                            },
                                    ),
                                  ],
                                ),
                              ),
                            )
                        );
                  }
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                 Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    'Cancel',
                    style: getMediumStyle(color: ColorManager.black.withOpacity(0.5),fontSize: FontSize.s16),
                  ),
                ),
              ),
            ],
          ),
      );
    }
    if(state is AppUpdateImageSuccessState) {
      AppCubit.get(context).getTest();
      AppCubit.get(context).tests = [];
    }
  },
  builder: (context, state) {
    var cubit = AppCubit.get(context);
    Widget closeIcon = Padding(
      padding: const EdgeInsets.only(right: 12, top: 12),
      child: Row(
        children: [
          Expanded(
              child: Container()
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: InkWell(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: Container(
                height: 32,
                width: 32,
                color: ColorManager.grey,
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
    Widget account = SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CircleAvatar(
              minRadius: 45,
              backgroundColor: ColorManager.grey,
              backgroundImage:  NetworkImage(
                  cubit.userModel!.image!,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cubit.userModel!.name!,
                style: getBoldMediumStyle(color: ColorManager.black),
              ),
              Container(
                height: AppSize.s8,
              ),
              Text(
                cubit.userModel!.email!,
                style: getRegularStyle(color: ColorManager.black.withOpacity(0.8),fontSize: FontSize.s12),
              ),
            ],
          )
        ],
      ),
    );
    Widget drawLine = const Divider(
      indent: AppMargin.m20,
      endIndent: 20,
      height: 40,
    );
    Widget lightMode = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: AppSize.s40,
        color: ColorManager.grey,
        child: Row(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Light Mode',
                    style: getRegularStyle(color: Colors.black),
                  ),
                )),
            Switch(
                value: cubit.light,
                activeColor: ColorManager.primary,
                onChanged: (value) {
                  cubit.changeSwitch(value);
                }
            ),
          ],
        ),
      ),
    );
    Widget logOut = Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: ColorManager.primary.withOpacity(0.1),
            fixedSize: Size(200, 40),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s16)),
          ),
          onPressed: () {
            signOut(context);
          },
          child: Text(
            'Logout',
            style: getBoldStyle(color: ColorManager.primaryBold,fontSize: FontSize.s16),
          )),
    );
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
        cubit.inProfile
            ? SystemUiOverlayStyle(
            statusBarColor: ColorManager.primary,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark
        )
            : SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark
        ),
        title: TextFormField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            labelText: 'Search',
            labelStyle: getMediumStyle(color: ColorManager.grey3),
            fillColor: ColorManager.homeFormField,
            prefixIconColor: ColorManager.grey3,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s60),
              borderSide: BorderSide(width: 0, color: ColorManager.grey),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSize.s60),
                borderSide: BorderSide(
                  width: 0,
                  color: ColorManager.grey3,
                )),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppPadding.p12),
            child: FloatingActionButton(
                mini: true,
                elevation: 0,
                backgroundColor: ColorManager.grey2,
                onPressed: () {},
                child:const Image(
                  image: AssetImage(
                    AssetManager.homeNotificationIcon,
                  ),
                )
            ),
          )
        ],
      ),
      body:state is! AppGetImageLoadingState && state is! AppUpdateImageLoadingState && state is! AppUpdateImageSuccessState?
      HomeScreen(cubit: cubit):
      Center(child: circularIndicator(color: ColorManager.primary)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: 'home',
        onPressed: () {
          cubit.getTestImage(context);
        },
        backgroundColor: ColorManager.primary,
        child: const Icon(Icons.upload),
      ),
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.height / 12,
        color: ColorManager.grey2,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.home,
                  color: ColorManager.primary,
                  size: AppSize.s34,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width / 13,
            ),
            IconButton(
                onPressed: () {
                  cubit.profileTrue();
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          )
                      ),
                      isScrollControlled: true,
                      useSafeArea: true,
                      barrierColor: ColorManager.primary,
                      context: context,
                      builder: (context) {
                        return  FractionallySizedBox(
                          heightFactor: 1,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                closeIcon,
                                account,
                                drawLine,
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      buildSettingRow('Account', () => null),
                                      buildSettingRow('Language', () => null),
                                      drawLine,
                                      buildDocRow('What\'s new', () => null),
                                      buildDocRow('FAQ', () => null),
                                      buildDocRow('Terms of Service', () => null),
                                      buildDocRow('Privacy Policy', () => null),
                                      Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    child: Container(
                                      height: AppSize.s40,
                                      color: ColorManager.grey,
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Text(
                                                  'Light Mode',
                                                  style: getRegularStyle(color: Colors.black),
                                                ),
                                              )),
                                          Switch(
                                              value: cubit.light,
                                              activeColor: ColorManager.primary,
                                              onChanged: (value) {
                                                cubit.changeSwitch(value);
                                              }
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                      logOut,
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }).then((value) {
                    cubit.showProfile();
                  });
                },
                icon: Icon(
                  Icons.account_circle,
                  size: AppSize.s34,
                  color: ColorManager.grey3,
                )),
          ],
        ),
      ),
    );
  },
);
  }
}



