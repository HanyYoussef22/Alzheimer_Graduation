import 'package:alzahimer/Home_Layout/Home_Layout.dart';
import 'package:alzahimer/shard/providers/app_provider.dart';
import 'package:alzahimer/shard/styles/My_Themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/Classifier/ClassifierScreen/ClassifierScreen.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AppProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeLayout.roudeName,
      routes: {
        ClassifierScreen.roudeName: (c) => ClassifierScreen(),
        HomeLayout.roudeName: (c) => HomeLayout(),
      },
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
