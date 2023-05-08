import 'dart:ui';
import 'package:lottie/lottie.dart';

import 'package:flutter/material.dart';

import '../../../../shard/styles/clors.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            child: Lottie.asset('assets/3.json'),
          ),
          Text(
            'Uploude Image',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              // pickImage();
            },
            child: Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: PrimaryColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.upload_file,
                    color: WhiteColor,
                  ),
                  Text('Uploude Image',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.normal,
                          color: WhiteColor))
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
