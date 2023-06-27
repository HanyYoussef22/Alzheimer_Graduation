import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../shard/styles/Theme_Cubit.dart';
import '../../../../shard/styles/clors.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Lottie.asset('assets/3.json'),
              ),
               Text(
                 AppLocalizations.of(context)!.classify,
                style: TextStyle(
                    color: BlocProvider.of<ThemeCubit>(context).state ?Colors.grey:Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  width: MediaQuery.of(context).size.width * .80,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(10),
                    border: Border.all(color: Colors.purple,width: 3),
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children:  [
                      Icon(
                        Icons.image_outlined,
                        color: Colors.purple,

                      ),
                      SizedBox(width: 8,),
                      Text(AppLocalizations.of(context)!.chose,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.purple))
                    ],
                  ),
                ),
              )
            ]),
        Container(
          color: Colors.black54,
          child: Stack(
            children: [
              // The blurred background
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                  child: Container(color: Colors.white.withOpacity(0.1)),
                ),
              ),

              // The loading indicator
              Center(
                  child: Container(
                alignment: Alignment.center,
                child: Lottie.asset('assets/4.json'),
              )),
            ],
          ),
        ),
      ],
    );
  }
}
