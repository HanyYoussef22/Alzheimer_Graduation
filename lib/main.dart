import 'package:alzahimer/Home_Layout/Home_Layout.dart';
import 'package:alzahimer/modules/Classifier/hoistry/hoistry.dart';
import 'package:alzahimer/shard/Provider/app_provider.dart';
import 'package:alzahimer/shard/Provider/user_Provider.dart';
import 'package:alzahimer/shard/styles/My_Themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/Classifier/ClassifierScreen/ClassifierScreen.dart';
import 'modules/login/login_screen.dart';
import 'modules/profile/change_PassWored.dart';
import 'modules/profile/change_name.dart';
import 'modules/profile/profile_Screen.dart';

// ChangeNotifierProvider<AppProvider>(create: (c) => AppProvider()
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppProvider>(create: (c) => AppProvider()),
    ChangeNotifierProvider<UserProvider>(create: (c) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return MaterialApp(
      initialRoute: provider.firebaseUser == null
          ? LoginScreen.roudeName
          : HomeLayout.roudeName,
      routes: {
        ClassifierScreen.roudeName: (c) => ClassifierScreen(),
        HomeLayout.roudeName: (c) => HomeLayout(),
        LoginScreen.roudeName: (c) => LoginScreen(),
        ChangePassword.RoudeName: (c) => ChangePassword(),
        ChangeName.RoudeName: (c) => ChangeName(),
        ProfileScreen.RoudeName: (c) => ProfileScreen(),
        ShowHistory.RouteName: (c) => ShowHistory(),
      },
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
