import 'package:alzahimer/Base.dart';
import 'package:alzahimer/Home_Layout/Home_Layout_Navigetor.dart';
import 'package:alzahimer/Home_Layout/Home_Layout_ViewModel.dart';
import 'package:alzahimer/Home_Layout/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';

import '../article_screen/articles/articles_screen.dart';
import '../home.dart';
import '../modules/Classifier/ClassifierScreen/ClassifierScreen.dart';
import '../modules/Classifier/hoistry/hoistry.dart';
import '../modules/profile/profile_Screen.dart';
import '../profile/profile_screen.dart';
import 'layout_cubit.dart';
import 'layout_states.dart';

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
    ShowHistory(),
    ArticleScreen(),
    ClassifierScreen(),
    ShowHistory(),
    Profile(),
  ]; List<String> titles = [
    'Home',
    'Blogs',
    'Classify',
    'History',
    'Profile',
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
  Widget currentPage = ArticleScreen();
  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return BlocConsumer<LayoutCubit,LayoutStates>(
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text(titles[currentIndex], style: TextStyle(color: Colors.purple,
                fontFamily: 'Poppins',
                fontSize: 20
            ),),
          ),
          body: PageStorage(
            bucket: bucket,
            child: currentPage,
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            elevation: 10,
            notchMargin: 8,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(
                                () {
                              currentPage = const Profile();
                              currentIndex = 0;
                            },
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Home,
                              color:
                              currentIndex == 0 ? Colors.purple : Colors.grey,
                              size: 22,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                color:
                                currentIndex == 0 ? Colors.purple : Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(
                                () {
                              currentPage = ArticleScreen();
                              currentIndex = 1;
                            },
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Document,
                              color:
                              currentIndex == 1 ? Colors.purple : Colors.grey,
                              size: 22,
                            ),
                            Text(
                              'Blogs',
                              style: TextStyle(
                                  color: currentIndex == 1
                                      ? Colors.purple
                                      : Colors.grey,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(
                                () {
                              currentPage = const Profile();
                              currentIndex = 3;
                            },
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Document,
                              color:
                              currentIndex == 3 ? Colors.purple : Colors.grey,
                              size: 22,
                            ),
                            Text(
                              'History',
                              style: TextStyle(
                                color:
                                currentIndex == 3 ? Colors.purple : Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(
                                () {
                              currentPage = const Profile();
                              currentIndex = 4;
                            },
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Profile,
                              color:
                              currentIndex == 4 ? Colors.purple : Colors.grey,
                              size: currentIndex == 4 ? 24 : 22,
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(
                                  color: currentIndex == 4
                                      ? Colors.purple
                                      : Colors.grey,
                                  fontSize: 15),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            elevation: 15,
            backgroundColor: Colors.purple,
            child: Image.asset(
              'assets/images/brain.png',
              color: currentIndex == 2 ? Colors.white : Colors.grey,
              scale: 12,
            ),
            onPressed: () {
              setState(() {
                currentIndex = 2;
                currentPage =  ClassifierScreen();
              });
            },
          ),



        );
      },
      listener: (context,state){},
    );
  }
}
