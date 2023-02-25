import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qawarir/modules/login/login_screen.dart';

import '../network/local/cache_helper.dart';

class AppConstant{
  static const int splashDelay = 3;
}

String? uId = '';
void signOut(context){
  CacheHelper.removeData(key: 'uId').then((value) {
    if(value){
      FirebaseAuth.instance.signOut().then((value){
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>LoginScreen())
        );
      });
    }
  });
}