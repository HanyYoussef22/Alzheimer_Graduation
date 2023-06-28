
import 'package:alzahimer/Home_Layout/Home_Layout.dart';
import 'package:alzahimer/login/login_screen.dart';
import 'package:alzahimer/shard/network/local/cache_helper.dart';
import 'package:flutter/material.dart';

Widget startWidget () {
  if(CacheHelper.getData('signed') == null ) {
    return LoginScreen();
  }
  return  HomeLayout();
}