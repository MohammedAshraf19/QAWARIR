import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../style/color_manager.dart';
import '../style/fonts_manager.dart';
import '../style/styles_manager.dart';
import '../style/values_manager.dart';

// Auth Screens

Widget   buildTextField(
    TextEditingController controller, String label, bool isPassword,
    )
{
  return TextFormField(
      controller: controller,
      obscureText: isPassword,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        fillColor: ColorManager.grey,
        enabledBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s2)),
        focusedBorder: UnderlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s3)),
        label: Text(label),
        labelStyle:getRegularStyle(color: ColorManager.primary),
      ),
      validator: (String? value){
        if(value!.isEmpty) {
          return '$label Must Not Be Null';
        } else
          return null;
      },
      );
}

Widget authTitle(String text){
  return Text(
    text,
    style: getBoldStyle(color: ColorManager.black),
  );
}
Widget authSubTitle(String text){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSize.s60),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: getRegularStyle(color: Colors.grey),
    ),
  );
}
Widget buildBigButton(String text, Function()? function) {
  return SizedBox(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          backgroundColor: ColorManager.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30))),
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(fontSize: FontSize.s16, color: ColorManager.white),
      ),
    ),
  );
}
Widget smallEmptyBox (){
  return  Container(
    height: AppSize.s18,
  );
}
Widget medEmptyBox (){
  return Container(
    height: AppSize.s34,
  );
}
Widget bigEmptyBox (){
  return Container(
    height: AppSize.s40,
  );
}

// Home
Widget buildSettingRow(String text, Function() function) {
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
                  style: getBoldStyle(color: Colors.black,fontSize: FontSize.s16),
                ),
              )),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    ),
  );
}

Widget buildDocRow(String text, Function() function) {
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
                    style: getBoldStyle(color: Colors.black,fontSize: FontSize.s16),
                  ),
                )),
            const Icon(Icons.login_rounded)
          ],
        ),
      ),
    ),
  );
}



void showToast({required String txt, required ToastState state}) {
  Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastState { SUCCESS, ERROR }
late Color color;
Color chooseToastColor(ToastState state) {
  switch (state) {
    case ToastState.SUCCESS:
      color = ColorManager.primary;
      break;
    case ToastState.ERROR:
      color = ColorManager.red;
      break;
  }
  return color;
}

Widget circularIndicator({
  required Color color,
}){
  return CircularProgressIndicator(
    backgroundColor: color,
    color: ColorManager.white,
    strokeWidth: 2,

  );
}
