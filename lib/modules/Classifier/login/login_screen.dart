import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation_projecttwo/views/password_reset/password_reset.dart';
import 'package:graduation_projecttwo/views/register/register_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../../shared/components.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            formBackground(welcomeTitle: 'Welcome again,',
              welcomeHint: 'Login now and live the experience',),
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
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.9,
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
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return 'You must write your E-mail to login';
                                              }
                                              return null;
                                            }),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        customField(
                                            controller: passController,
                                            name: 'Password',
                                            prefixIcon: Icons.lock,
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return 'You must write your password to login';
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
                                        submitButton(
                                            submitText: 'LOGIN',
                                            onTap: () {

                                            })
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
                  Expanded(child: Container(),
                    flex: 1,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
