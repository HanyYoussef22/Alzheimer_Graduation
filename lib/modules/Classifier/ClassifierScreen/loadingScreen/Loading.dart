import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

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
                'Classify Your MRI !',
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
                onTap: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15)),
                      ),
                      context: context,
                      builder: (context) {
                        return Container(
                          decoration:  BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15)),
                            color: Colors.purple.withOpacity(0.9),
                          ),
                          height: MediaQuery.of(context).size.height * .22,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration:  BoxDecoration(
                                      border:  GradientBoxBorder(
                                        gradient: LinearGradient(colors: [
                                          Colors.blue,
                                          Colors.red,
                                          Colors.blue,
                                          Colors.red,
                                        ]),
                                        width: 2,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    height: 65,
                                    width: 65,
                                    child: IconButton(
                                      alignment: Alignment.center,
                                      onPressed: () {
                        },
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Camera',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      border: GradientBoxBorder(
                                        gradient: LinearGradient(colors: [
                                          Colors.blue,
                                          Colors.red,
                                          Colors.blue,
                                          Colors.red,
                                        ]),
                                        width: 2,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    height: 65,
                                    width: 65,
                                    child: IconButton(
                                      alignment: Alignment.center,
                                      onPressed: () {


                                      },
                                      icon: const Icon(
                                        Icons.image,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Gallery',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      });
                },
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
                    children: const [
                      Icon(
                        Icons.image_outlined,
                        color: Colors.purple,

                      ),
                      SizedBox(width: 8,),
                      Text('CHOOSE IMAGE',
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
