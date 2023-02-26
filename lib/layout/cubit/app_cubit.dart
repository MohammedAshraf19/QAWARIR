import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:qawarir/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../models/user_model.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) =>BlocProvider.of(context);

  bool inProfile = false;
  bool light = true;
  void changeSwitch(bool value){
   light = value;
   emit(ChangeSwitch());
  }
  void showProfile(){
    inProfile = !inProfile;
    emit(ShowProfile());
  }
  void profileTrue(){
    inProfile = true;
    emit(ShowProfile());
  }

  // Get User Data
  UserModel? userModel ;
  void getUserData(){
    emit(AppGetUserDataLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value){
      userModel = UserModel.fromJson(value.data()!);
      emit(AppGetUserDataSuccess());
    })
        .catchError((error){
      emit(AppGetUserDataError());
    });
  }

  // Upload Test
  File? testImage;
  var picker = ImagePicker();
  Future<void> getTestImage() async {
    emit(AppTestImagePickedLoadingState());
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      testImage = File(pickedFile.path);
      emit(AppTestImagePickedSuccessState());
    } else {
      emit(AppTestImagePickedErrorState());
    }
  }


  // void uploadTestImage(){
  //   emit(AppUpdateTestLoadingState());
  //   firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(testImage!.path).pathSegments.last}')
  //       .putFile(testImage!)
  //       .then((value){
  //     value.ref.getDownloadURL()
  //         .then((value) {
  //     })
  //         .catchError((error){
  //       emit(AppUpdateTestErrorState());
  //     }
  //     );
  //   })
  //       .catchError((error){
  //     emit(AppUpdateTestErrorState());
  //   });
  // }
}
