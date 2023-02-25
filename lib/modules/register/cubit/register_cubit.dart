import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/user_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  void userRegister({
    required email,
    required password,
    required name,
  }){
    emit(AppRegisterLoading());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      createUser(
        email: email,
        name: name,
        uId: value.user!.uid,
      );
    }).catchError((error){
      emit(AppCreateUserError(error));
    });
  }

  void createUser({
    required email,
    required name,
    required uId,
  }){
    UserModel _userModel = UserModel(
      name: name,
      uId: uId,
      email: email,
      image: 'https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?w=2000',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(_userModel.toMap())
        .then((value){
      emit(AppCreateUserSuccess(uId: uId));
    }).catchError((error){
      emit(AppCreateUserError(error));
    });
  }
}
