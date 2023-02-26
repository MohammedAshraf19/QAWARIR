part of 'app_cubit.dart';

@immutable
abstract class AppState {}
class AppInitial extends AppState {}
//Get User Data
class AppGetUserDataLoading extends AppState {}
class AppGetUserDataSuccess extends AppState {}
class AppGetUserDataError extends AppState {}

// Change switch
class ChangeSwitch extends AppState {}

// show profile
class ShowProfile extends AppState {}

// Test Image
class AppTestImagePickedSuccessState extends AppState {}
class AppTestImagePickedErrorState extends AppState {}
class AppTestImagePickedLoadingState extends AppState {}

class AppUpdateTestLoadingState extends AppState {}
class AppUpdateTestErrorState extends AppState {}