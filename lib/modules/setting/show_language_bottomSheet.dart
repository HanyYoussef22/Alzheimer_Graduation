// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../shard/styles/clors.dart';
// import '../../shard/providers/app_provider.dart';
//
// class ShowLanguageBottomSheet extends StatefulWidget {
//   const ShowLanguageBottomSheet({Key? key}) : super(key: key);
//
//   @override
//   State<ShowLanguageBottomSheet> createState() =>
//       _ShowLanguageBottomSheetState();
// }
//
// class _ShowLanguageBottomSheetState extends State<ShowLanguageBottomSheet> {
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
//                 provider.ChangeAppLanguage('en');
//                 Navigator.of(context).pop();
//               },
//               child: FunIfSelect(
//                   'English', provider.AppLanguage == 'en' ? true : false),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             InkWell(
//               onTap: () {
//                 provider.ChangeAppLanguage('ar');
//                 Navigator.of(context).pop();
//               },
//               child: FunIfSelect(
//                   'Arabic', provider.AppLanguage == 'ar' ? true : false),
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
//                   .displayMedium!
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
//             style: Theme.of(context).textTheme.displayMedium!.copyWith(
//                 color: provider.themeMode == ThemeMode.dark
//                     ? WhiteColor
//                     : Colors.black)),
//         Icon(Icons.check, color: Colors.black)
//       ]);
//     }
//   }
// }
