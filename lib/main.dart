import 'package:alzahimer/Home_Layout/Home_Layout.dart';
import 'package:alzahimer/Home_Layout/layout_cubit.dart';
import 'package:alzahimer/modules/Classifier/hoistry/hoistry.dart';
import 'package:alzahimer/shard/Provider/app_provider.dart';
import 'package:alzahimer/shard/Provider/user_Provider.dart';
import 'package:alzahimer/shard/bloc_observer.dart';
import 'package:alzahimer/shard/network/local/cache_helper.dart';
import 'package:alzahimer/shard/styles/My_Themes.dart';
import 'package:alzahimer/start_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'login/login_screen.dart';
import 'modules/Classifier/ClassifierScreen/ClassifierScreen.dart';
import 'modules/profile/change_PassWored.dart';
import 'modules/profile/change_name.dart';
import 'modules/profile/profile_Screen.dart';

// ChangeNotifierProvider<AppProvider>(create: (c) => AppProvider()
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppProvider>(create: (c) => AppProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LayoutCubit()..getUserData(),
        ),
      ],
      child: MaterialApp(
        routes: {
          ClassifierScreen.roudeName: (c) => ClassifierScreen(),
          HomeLayout.roudeName: (c) => HomeLayout(),
          // LoginScreen.roudeName: (c) => LoginScreen(),
          '/': (context) => startWidget(),
          ChangePassword.RoudeName: (c) => ChangePassword(),
          ChangeName.RoudeName: (c) => ChangeName(),
          ProfileScreen.RoudeName: (c) => ProfileScreen(),
          ShowHistory.RouteName: (c) => ShowHistory(),
        },
        debugShowCheckedModeBanner: false,
        theme: MyThemeData.lightTheme,
        darkTheme: MyThemeData.darkTheme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
