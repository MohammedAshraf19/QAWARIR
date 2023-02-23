import 'package:flutter/material.dart';
import 'package:qawarir/shared/style/color_manager.dart';
import 'package:qawarir/shared/style/styles_manager.dart';
import 'package:qawarir/shared/style/values_manager.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

    return SingleChildScrollView(
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
          logOut
        ],
      ),
    );
  }
}
