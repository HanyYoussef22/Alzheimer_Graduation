import 'package:alzahimer/Home_Layout/Home_Layout.dart';
import 'package:alzahimer/login/login_cubit.dart';
import 'package:alzahimer/login/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import '../modules/password_reset/password_reset.dart';
import '../shard/network/local/cache_helper.dart';
import '../shard/shared/components.dart';
import '../sign_up/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Stack(
                children: [
                  formBackground(
                    welcomeTitle: 'Welcome again ,',
                    welcomeHint: 'Login now and live the experience',
                  ),
                  layoutForm(
                    Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                        Transform.translate(
                          offset: const Offset(0, 37),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    // height: MediaQuery.of(context).size.height *
                                    //     0.45,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 30, horizontal: 15),
                                      child: Form(
                                        key: formKey,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    'LOGIN',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 30,
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .rightToLeft,
                                                          alignment:
                                                              Alignment.center,
                                                          duration:
                                                              const Duration(
                                                            milliseconds: 450,
                                                          ),
                                                          child:
                                                              const RegisterScreen(),
                                                        ),
                                                      );
                                                    },
                                                    child: const Text(
                                                      'SIGN UP',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              customField(
                                                name: 'Email',
                                                controller: emailController,
                                                prefixIcon: Icons.email,
                                                validate: (text) {
                                                  if (text!.isEmpty ||
                                                      text.trim().isEmpty) {
                                                    return 'Pleas Enter Your Email';
                                                  }
                                                  bool emailValid = RegExp(
                                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                      .hasMatch(text);
                                                  if (!emailValid) {
                                                    return 'Email not Valid';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              customField(
                                                  controller: passController,
                                                  name: 'Password',
                                                  prefixIcon: Icons.lock,
                                                  validate: (text) {
                                                    if (text!.isEmpty ||
                                                        text.trim().isEmpty) {
                                                      return 'You must write Your Password';
                                                    }
                                                    if (text.length < 6) {
                                                      return 'Password Enter Valid ';
                                                    }
                                                    return null;
                                                  }),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Center(
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const ResetPasswordScreen()),
                                                    );
                                                  },
                                                  child: const Text(
                                                    'Forget Password?',
                                                    style: TextStyle(
                                                      fontFamily: 'oxygen',
                                                      color: Colors.grey,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              SizedBox(
                                                height: 62,
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      LoginCubit.get(context)
                                                          .userLogin(
                                                              email:
                                                                  emailController
                                                                      .text,
                                                              password:
                                                                  passController
                                                                      .text);
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
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Icon(Icons
                                                                .login_outlined),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              'LOGIN',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            )
                                                          ],
                                                        );
                                                      },
                                                      condition: state
                                                          is LoginLoadingState,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'signed', value: true).then((value) {
              Navigator.pushNamed(context, HomeLayout.roudeName);
            });
          }
        },
      ),
    );
  }
}
