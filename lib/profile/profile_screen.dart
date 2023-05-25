import 'package:alzahimer/Home_Layout/layout_cubit.dart';
import 'package:alzahimer/Home_Layout/layout_states.dart';
import 'package:alzahimer/settings/edit_profile.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login/login_screen.dart';
import '../resources/app_images.dart';
import '../shard/components/custom_row.dart';
import '../shard/network/local/cache_helper.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        return BlocConsumer<LayoutCubit, LayoutStates>(
          builder: (context, state) {
            LayoutCubit cubit = LayoutCubit.get(context);

            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22, right: 22),
                          child: Row(
                            children: [
                               CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(
                                   cubit.model!.image!),
                              ),

                              const SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text(
                                    cubit.model!.fName,
                                    style: const TextStyle(
                                      color: Colors.purple,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    cubit.model!.birthDate!,
                                    style: const TextStyle(
                                      // color: AppColors.kPrimaryColor,
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                    ConditionalBuilder(
                      fallback: (context)=>const SizedBox(),
                      builder: (context){
                        return     Padding(
                          padding:  const EdgeInsets.only(left: 22, right: 22),
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children:  [
                              const Icon(
                                Icons.call_outlined,
                                color: Colors.grey,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                               LayoutCubit.get(context).model!.phone!,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        );
                      },
                      condition: cubit.model!.phone !=null && cubit.model!.phone !='',
                    ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 22, right: 22),
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.email_outlined,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'alaa_hazem@gmail.com',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: 80,
                                width: MediaQuery.of(context).size.width * .41,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: .8)),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        '15',
                                        style: TextStyle(
                                          color: Colors.purple,
                                          fontSize: 18,
                                          height: .98,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'Classifications',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 18,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: .8)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      cubit.model!.registerDate!,
                                      style: const TextStyle(
                                        color: Colors.purple,
                                        fontSize: 17,
                                        height: .98,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Text(
                                      'Register Date',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500),
                                    ),
                                    // Image.asset(
                                    //   AppImages.drIcon,
                                    //   scale: 8,
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 22, right: 22),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return EditProfileScreen();
                              }));
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.settings),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Settings',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 1.5,
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 22, right: 22),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              children: const [
                                Icon(Icons.attachment_sharp),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'History',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          thickness: 1.5,
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 22, right: 22),
                          child: CustomRow(
                            textColor: Colors.red,
                            imageColor: Colors.red,
                            text: 'Log Out',
                            image: AppImages.logout,
                            function: () {
                              CacheHelper.removeData('signed').then((value) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const LoginScreen();
                                }));
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {},
        );
      },
      listener: (context, state) {},
    );
  }
}
