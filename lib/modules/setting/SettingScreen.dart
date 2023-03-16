import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shard/styles/clors.dart';
import '../../shard/Provider/app_provider.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          InkWell(
            onTap: () {
              // showLanguageBottomSheet();
            },
            child: Text(
              'Language',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: provider.themeMode == ThemeMode.light
                      ? Colors.black
                      : WhiteColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              // showLanguageBottomSheet();
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: provider.themeMode == ThemeMode.light
                      ? WhiteColor
                      : SecendColor,
                  borderRadius: BorderRadius.circular(0),
                  border: Border.all(color: PrimaryColor)),
              child: Text(
                provider.AppLanguage == 'en' ? 'English' : 'عربي',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Theme',
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: provider.themeMode == ThemeMode.light
                    ? Colors.black
                    : WhiteColor,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
            onTap: () {
              // showThemeBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: provider.themeMode == ThemeMode.light
                      ? WhiteColor
                      : SecendColor,
                  borderRadius: BorderRadius.circular(0),
                  border: Border.all(color: PrimaryColor)),
              child: Text(
                provider.themeMode == ThemeMode.light ? 'Light' : 'Dark',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: Colors.black, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    ));
  }

// void showThemeBottomSheet() {
//   showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         // return ShowThemeBottomSheet();
//       });
// }

// void showLanguageBottomSheet() {
//   showModalBottomSheet(
//       context: context,
//       // builder: (context) {
//         // return ShowLanguageBottomSheet();
//       });
// }
}
