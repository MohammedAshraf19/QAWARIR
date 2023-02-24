import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qawarir/modules/home/home_screen.dart';
import 'package:qawarir/shared/style/asset_manager.dart';
import 'package:qawarir/shared/style/color_manager.dart';
import 'package:qawarir/shared/style/styles_manager.dart';
import 'package:qawarir/shared/style/values_manager.dart';

class QawarirLayout extends StatefulWidget {
  const QawarirLayout({Key? key}) : super(key: key);

  @override
  State<QawarirLayout> createState() => _QawarirLayoutState();
}

class _QawarirLayoutState extends State<QawarirLayout> {
  static bool inProfile = false;
  bool light = true;

  _buildSettingRow(String text, Function() function) {
    return InkWell(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                text,
                style: getRegularStyle(color: Colors.black),
              ),
            )),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }

  _buildDocRow(String text, Function() function) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: function,
        child: Ink(
          height: AppSize.s40,
          color: ColorManager.grey,
          child: Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  text,
                  style: getRegularStyle(color: Colors.black),
                ),
              )),
              const Icon(Icons.login_rounded)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget closeIcon = Padding(
      padding: const EdgeInsets.only(right: 12, top: 12),
      child: Row(
        children: [
          Expanded(child: Container()),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ))
        ],
      ),
    );

    Widget account = Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CircleAvatar(
            minRadius: 45,
            backgroundColor: ColorManager.grey,
            child: Icon(
              color: ColorManager.primary,
              Icons.account_circle,
              size: 60,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Full Name',
              style: getBoldMediumStyle(color: ColorManager.black),
            ),
            Container(
              height: AppSize.s8,
            ),
            Text(
              '@user_email',
              style: getMediumStyle(color: Colors.grey),
            ),
          ],
        )
      ],
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
                value: light,
                activeColor: ColorManager.primary,
                onChanged: (bool value) {
                  setState(() {
                    light = value;
                  });
                })
          ],
        ),
      ),
    );

    Widget logOut = Padding(
      padding: const EdgeInsets.all(16),
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: ColorManager.grey,
            fixedSize: Size(200, 40),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          onPressed: () => null,
          child: Text(
            'Logout',
            style: TextStyle(color: ColorManager.primary),
          )),
    );

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: inProfile
            ? SystemUiOverlayStyle(
                statusBarColor: ColorManager.primary,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark)
            : SystemUiOverlayStyle(
                statusBarColor: ColorManager.white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark),
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
      body: const HomeScreen(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
                  setState(() {
                    inProfile = true;
                  });
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      )),
                      isScrollControlled: true,
                      useSafeArea: true,
                      barrierColor: ColorManager.primary,
                      context: context,
                      builder: (context) {
                        return FractionallySizedBox(
                          heightFactor: 1,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                closeIcon,
                                account,
                                drawLine,
                                _buildSettingRow('Account', () => null),
                                _buildSettingRow('Language', () => null),
                                drawLine,
                                _buildDocRow('What\'s new', () => null),
                                _buildDocRow('FAQ', () => null),
                                _buildDocRow('Terms of Service', () => null),
                                _buildDocRow('Privacy Policy', () => null),
                                lightMode,
                                logOut,
                              ],
                            ),
                          ),
                        );
                      }).then((value) {
                    setState(() {
                      inProfile = !inProfile;
                    });
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
  }
}
