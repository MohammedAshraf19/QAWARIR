import 'package:flutter/material.dart';
import 'package:qawarir/modules/home/home_screen.dart';
import 'package:qawarir/modules/profile/profile_screen.dart';
import 'package:qawarir/shared/style/color_manager.dart';
import 'package:qawarir/shared/style/values_manager.dart';

class QawarirLayout extends StatelessWidget {
  const QawarirLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                      builder: (context) => ProfileScreen());
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
