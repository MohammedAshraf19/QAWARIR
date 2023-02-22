import 'package:flutter/cupertino.dart';
import 'package:qawarir/shared/style/color_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text('Home Screen',
          style: TextStyle(
            color: ColorManager.primary
          ),),
        ),
      ],
    );
  }
}
