
import 'package:alzahimer/Home_Layout/Home_Layout.dart';
import 'package:alzahimer/shard/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'modules/login/login_screen.dart';

Widget startWidget () {
  if(CacheHelper.getData('signed') == null ) {
    return LoginScreen();
  }
  return  HomeLayout();
}