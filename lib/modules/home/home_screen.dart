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
    return ListView.builder(
        itemBuilder: (context,index)=>buildNot(context),
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
    );
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

  Widget buildNot(context){
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
                    'Mohammed Ahmed',
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
                        'malignant',
                        style: getRegularStyle(color: ColorManager.yellow,fontSize: FontSize.s16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s8,
                  ),
                  Text(
                    'Feb 15, 2023',
                    style: getItalicStyle(color: ColorManager.grey3),
                  ),
                ],
              ),
              Spacer(),
                if(AppCubit.get(context).testImage == null)
                Image(
                  image:AssetImage(
                      AssetManager.homeResult
                  )
              ),
              if(AppCubit.get(context).testImage != null)
                Container(
                    height: MediaQuery.of(context).size.height/9,
                    width: MediaQuery.of(context).size.width/3.5,
                    child: Image.file(File(cubit.testImage!.path)
                    )
                ),
            ],
          ),
        ),
      ),
    );
  }
}

