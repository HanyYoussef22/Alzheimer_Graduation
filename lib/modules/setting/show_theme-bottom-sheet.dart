// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../shard/providers/app_provider.dart';
// import '../../shard/styles/clors.dart';
//
// class ShowThemeBottomSheet extends StatefulWidget {
//   @override
//   State<ShowThemeBottomSheet> createState() => _ShowThemeBottomSheetState();
// }
//
// class _ShowThemeBottomSheetState extends State<ShowThemeBottomSheet> {
//   var provider;
//
//   @override
//   Widget build(BuildContext context) {
//     provider = Provider.of<AppProvider>(context);
//     return Container(
//       decoration: BoxDecoration(
//           color:
//               provider.themeMode == ThemeMode.dark ? SecendColor : WhiteColor,
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(15), topLeft: Radius.circular(15))),
//       height: MediaQuery.of(context).size.height * .50,
//       child: Padding(
//         padding: const EdgeInsets.all(40.0),
//         child: Column(
//           children: [
//             InkWell(
//               onTap: () {
//                 provider.ChangeAppTheme(ThemeMode.light);
//                 Navigator.of(context).pop();
//               },
//               child: FunIfSelect('light',
//                   provider.themeMode == ThemeMode.light ? true : false),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             InkWell(
//               onTap: () {
//                 provider.ChangeAppTheme(ThemeMode.dark);
//                 Navigator.of(context).pop();
//               },
//               child: FunIfSelect(
//                   'Dark', provider.themeMode == ThemeMode.dark ? true : false),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget FunIfSelect(String text, bool selected) {
//     if (selected) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Text('$text',
//               style: Theme.of(context)
//                   .textTheme
//                   .headline2!
//                   .copyWith(color: PrimaryColor)),
//           Icon(
//             Icons.check,
//             color: PrimaryColor,
//           )
//         ],
//       );
//     } else {
//       return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//         Text('$text',
//             style: Theme.of(context).textTheme.headline2!.copyWith(
//                 color: provider.themeMode == ThemeMode.dark
//                     ? WhiteColor
//                     : Colors.black)),
//         Icon(Icons.check, color: Colors.black)
//       ]);
//     }
//   }
// }
