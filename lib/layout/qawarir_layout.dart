import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qawarir/modules/home/home_screen.dart';
import 'package:qawarir/shared/style/color_manager.dart';
import 'package:qawarir/shared/style/styles_manager.dart';
import 'package:qawarir/shared/style/values_manager.dart';

class QawarirLayout extends StatelessWidget {
  const QawarirLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: ColorManager.black,
          statusBarColor: ColorManager.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search
            ),
            labelText: 'Search',
            labelStyle:getMediumStyle(color: ColorManager.grey3) ,
            fillColor: ColorManager.homeFormField,
            prefixIconColor: ColorManager.grey3,
            enabledBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s60),
              borderSide: BorderSide(
                width: 0,
                color: ColorManager.grey
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSize.s60),
                borderSide: BorderSide(
                    width: 0,
                    color: ColorManager.grey3,
                )
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppPadding.p12),
            child: FloatingActionButton(
              mini: true,
              elevation: 0,
              backgroundColor: ColorManager.grey2,
                onPressed: (){},
              child: Icon(
                Icons.notifications_none_outlined,
                color: ColorManager.black.withOpacity(0.8),
              ),
            ),
          )
        ],
      ),
      body: const HomeScreen(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: ColorManager.primary,
        child: const Icon(
            Icons.upload
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.height/12,
        color: ColorManager.grey2,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: (){},
                icon: Icon(
                  Icons.home,
                  color:ColorManager.primary,
                  size: AppSize.s34,
                )
            ),
            SizedBox(
              width:MediaQuery.of(context).size.width/13 ,
            ),
            IconButton(
                onPressed: (){
                },
                icon: Icon(
                  Icons.account_circle,
                  size: AppSize.s34,
                  color:ColorManager.grey3,
                )
            ),
          ],
        ),
      ),
    );
  }
}
