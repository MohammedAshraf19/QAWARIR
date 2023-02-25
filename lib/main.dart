import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qawarir/layout/cubit/app_cubit.dart';
import 'package:qawarir/modules/splash/splash_screen.dart';
import 'package:qawarir/shared/bloc_observer.dart';
import 'package:qawarir/shared/components/constants.dart';
import 'package:qawarir/shared/network/local/cache_helper.dart';
import 'package:qawarir/shared/style/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUserData(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'QAWARIR',
            theme: myTheme(),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
