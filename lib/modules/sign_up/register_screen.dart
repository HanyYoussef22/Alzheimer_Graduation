import 'package:alzahimer/Home_Layout/Home_Layout.dart';
import 'package:alzahimer/modules/sign_up/register_cubit.dart';
import 'package:alzahimer/modules/sign_up/register_state.dart';
import 'package:alzahimer/shard/styles/Theme_Cubit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../Home_Layout/layout_cubit.dart';
import '../../shard/network/local/cache_helper.dart';
import '../../shard/network/remote/datdbase/database_utils.dart';
import '../../shard/shared/components.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    TextEditingController nameController = TextEditingController();

    TextEditingController emailController = TextEditingController();

    TextEditingController passController = TextEditingController();

    TextEditingController confirmController = TextEditingController();

    TextEditingController dateController = TextEditingController();

    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
          builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                formBackground(
                  isDark: BlocProvider.of<ThemeCubit>(context).state,
                  welcomeTitle: AppLocalizations.of(context)!.hell,
                  welcomeHint: AppLocalizations.of(context)!.loginnow,
                ),
                Visibility(
                  visible: BlocProvider.of<ThemeCubit>(context).state,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.hell,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          AppLocalizations.of(context)!.loginnow,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                layoutForm(
                  Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Card(
                          color: BlocProvider.of<ThemeCubit>(context).state
                              ? Color(0xFF141922)
                              : Colors.white,
                          elevation: 9,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11)),
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            // height: screenSize.height * 0.55,
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .leftToRight,
                                              alignment: Alignment.center,
                                              duration: const Duration(
                                                milliseconds: 450,
                                              ),
                                              child: LoginScreen(),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.login,
                                          style: TextStyle(
                                            color: BlocProvider.of<ThemeCubit>(
                                                        context)
                                                    .state
                                                ? Colors.purple
                                                : Colors.grey,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.signup,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 28,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  customField(
                                    isDark: BlocProvider.of<ThemeCubit>(context)
                                        .state,
                                    name: AppLocalizations.of(context)!.name,
                                    prefixIcon: Icons.person,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter your name to sign up.';
                                      }
                                      return null;
                                    },
                                    controller: nameController,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  customField(
                                    isDark: BlocProvider.of<ThemeCubit>(context)
                                        .state,
                                    name: AppLocalizations.of(context)!.email,
                                    prefixIcon: Icons.mail,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Email is required to sign up.';
                                      }

                                      if (value.contains('@') == false) {
                                        return 'Please Enter valid email';
                                      }
                                      return null;
                                    },
                                    controller: emailController,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  customField(
                                      isDark:
                                          BlocProvider.of<ThemeCubit>(context)
                                              .state,
                                      name: AppLocalizations.of(context)!.birth,
                                      fieldTapping: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2020 - 10 - 10),
                                          lastDate: DateTime(2099 - 3 - 3),
                                        ).then((value) => dateController.text =
                                            DateFormat.yMMMd().format(value!));
                                      },
                                      prefixIcon: Icons.date_range_rounded,
                                      validate: (value) {
                                        if (value == null) {
                                          return 'Birth Date is required';
                                        }
                                      },
                                      controller: dateController),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  customField(
                                    isDark: BlocProvider.of<ThemeCubit>(context)
                                        .state,
                                    obsecureText: true,
                                    name: AppLocalizations.of(context)!.pass,
                                    prefixIcon: Icons.lock,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'You must write your password to login';
                                      }
                                      return null;
                                    },
                                    controller: passController,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  customField(
                                    isDark: BlocProvider.of<ThemeCubit>(context)
                                        .state,
                                    obsecureText: true,
                                    name: AppLocalizations.of(context)!.passon,
                                    prefixIcon: Icons.lock,
                                    validate: (value) {
                                      if (value != passController.text) {
                                        return 'Password and confirm password doesn\'t match!';
                                      }
                                      return null;
                                    },
                                    controller: confirmController,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  SizedBox(
                                    height: 62,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            RegisterCubit.get(context)
                                                .userRegister(
                                                    email: emailController.text,
                                                    password:
                                                        passController.text,
                                                    name: nameController.text,
                                                    birthDate:
                                                        dateController.text);
                                          }
                                        },
                                        child: ConditionalBuilder(
                                          builder: (context) {
                                            return const SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                          fallback: (context) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.login_outlined),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .register,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                          condition:
                                              state is RegisterLoadingState,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is RegisterSuccessState) {
          CacheHelper.saveString(key: 'signed', value: "signed ok")
              .then((value) async {
            var Cubit = BlocProvider.of<LayoutCubit>(context);
            var user = await DataBaseUtil.readUser(state.ui);
            Cubit.model = user;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeLayout()),
            );
          });
        } else if (state is RegisterFailureState) {
          AwesomeDialog(
                  btnOkColor: Colors.indigoAccent,
                  context: context,
                  dialogType: DialogType.error,
                  borderSide: const BorderSide(
                    color: Colors.redAccent,
                    width: 2,
                  ),
                  width: 590,
                  buttonsBorderRadius: const BorderRadius.all(
                    Radius.circular(2),
                  ),
                  dismissOnTouchOutside: true,
                  dismissOnBackKeyPress: false,
                  buttonsTextStyle:
                      const TextStyle(fontSize: 17, fontFamily: 'Poppins'),
                  headerAnimationLoop: false,
                  animType: AnimType.bottomSlide,
                  title: 'try again',
                  titleTextStyle: const TextStyle(
                    fontSize: 17,
                    fontFamily: 'oxygen',
                    fontWeight: FontWeight.w700,
                  ),
                  descTextStyle:
                      const TextStyle(fontFamily: 'oxygen', fontSize: 15),
                  desc: state.error,
                  showCloseIcon: true,
                  btnOkOnPress: () {},
                  btnOkText: 'OK')
              .show();
        }
      }),
    );
  }
}
