import 'package:flutter/material.dart';
import 'package:qawarir/shared/style/color_manager.dart';
import 'package:qawarir/shared/style/values_manager.dart';

class QawarirLayout extends StatelessWidget {
  const QawarirLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: const Center(
        child: Text(
            'Hallo'
        ),
      ),
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
