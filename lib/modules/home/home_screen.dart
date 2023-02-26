import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:qawarir/layout/cubit/app_cubit.dart';
import 'package:qawarir/shared/style/asset_manager.dart';
import 'package:qawarir/shared/style/color_manager.dart';
import 'package:qawarir/shared/style/fonts_manager.dart';
import 'package:qawarir/shared/style/string_manager.dart';
import 'package:qawarir/shared/style/styles_manager.dart';
import 'package:qawarir/shared/style/values_manager.dart';

class HomeScreen extends StatelessWidget {
  AppCubit cubit;

  HomeScreen(
  {
    required this.cubit
}
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {

        },
  builder: (context, state) {
    return cubit.tests.isNotEmpty? ListView.builder(
        itemBuilder: (context,index)=>buildNot(context,index),
        physics: const BouncingScrollPhysics(),
        itemCount: cubit.tests.length,
    ):buildZeroNot(context);
  },
);
  }
  Widget buildZeroNot(context){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage(
              AssetManager.homeAsset,
            ),
          ),
          const SizedBox(
            height: AppSize.s12,
          ),
          Text(
            AppStrings.homeTitle,
            style: getMediumStyle(color: ColorManager.black,fontSize: FontSize.s22),
          ),
          const SizedBox(
            height: AppSize.s8,
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/10),
            child: Text(
              AppStrings.homeSubTitle,
              style: getRegularStyle(color: ColorManager.homeSubTitleColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNot(context,index){
    return  Padding(
      padding: const EdgeInsets.only(left: AppPadding.p12,right: AppPadding.p12,top: AppPadding.p8),
      child: Card(
        color: ColorManager.grey2,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Row(
            children: [
              Padding(
                padding:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height/20
                ),
                child: IconButton(
                  onPressed: (){},
                  icon: Image(image: AssetImage(AssetManager.homeMenueIcon)),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                cubit.tests[index].name!,
                    style: getBoldStyle(color: ColorManager.black,fontSize: FontSize.s16),
                  ),
                  SizedBox(
                    height: AppSize.s8,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.list_alt,
                        size: AppSize.s12,
                      ),
                      SizedBox(
                        width: AppSize.s3,
                      ),
                      Text(
                        cubit.tests[index].status!,
                        style: getRegularStyle(color: ColorManager.yellow,fontSize: FontSize.s16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s8,
                  ),
                  Text(
                    cubit.tests[index].date!,
                    style: getItalicStyle(color: ColorManager.grey3),
                  ),
                ],
              ),
              Spacer(),
                Image(
                  image:NetworkImage(
                      '${cubit.tests[index].image}'
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

