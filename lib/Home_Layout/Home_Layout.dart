import 'package:alzahimer/Base.dart';
import 'package:alzahimer/Home_Layout/Home_Layout_Navigetor.dart';
import 'package:alzahimer/Home_Layout/Home_Layout_ViewModel.dart';
import 'package:alzahimer/Home_Layout/test.dart';
import 'package:flutter/material.dart';

import '../modules/Classifier/ClassifierScreen/ClassifierScreen.dart';
import '../modules/Classifier/hoistry/hoistry.dart';
import '../modules/login/login_screen.dart';
import '../modules/profile/profile_Screen.dart';

class HomeLayout extends StatefulWidget {
  static const String roudeName = 'HomeLayout';
  int currentIndex = 0;

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends BaseState<HomeLayout, HomeLayoutViewModel>
    implements HomeLayoutNavigetor {
  int currentIndex = 0;
  List<Widget> taps = [
    ClassifierScreen(),
    LoginScreen(),
    ProfileScreen(),
    ShowHistory(),
    ScanScreen()
  ];

  @override
  HomeLayoutViewModel iniViewModel() {
    return HomeLayoutViewModel();
  }

  @override
  void initState() {
    super.initState();
    viewModel.navigetor = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   title: Text('Welcome', style: Theme.of(context).textTheme.bodyMedium),
      //   elevation: 0,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit_sharp), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit_sharp), label: "")
        ],
      ),
      body: taps[currentIndex],
    );
  }
}
