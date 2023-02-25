import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context)=>BlocProvider.of(context);

  bool isRemember = true;
  void changeRemember(bool newBool){
    isRemember = newBool;
    emit(ChangeRemember());
  }

  void userLogin({
    required String email,
    required String password,
  }){
    emit(AppLoginLoading());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.uid);
      emit(AppLoginSuccess(value.user!.uid));
    }).catchError((error){
      emit(AppLoginError(error));
    });
  }

}
