import 'package:alzahimer/Base.dart';
import 'package:alzahimer/Home_Layout/Home_Layout.dart';
import 'package:alzahimer/Models/My_User.dart';
import 'package:alzahimer/modules/register/RegisterNavigetor.dart';
import 'package:alzahimer/shard/Provider/user_Provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../shard/shared/components.dart';
import '../login/login_screen.dart';
import 'Register_View_Model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen, RgisterViewModel>
    implements RegisterNavigetor {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  TextEditingController confirmController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.navigetor = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (c) => viewModel,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              formBackground(
                welcomeHint: 'Register now and live the experience ..',
                welcomeTitle: 'Welcome',
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
                        elevation: 9,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
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
                                            type:
                                                PageTransitionType.leftToRight,
                                            alignment: Alignment.center,
                                            duration: const Duration(
                                              milliseconds: 450,
                                            ),
                                            child: LoginScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'LOGIN',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                        color: Colors.black,
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
                                  name: 'Name',
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
                                  name: 'Email',
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
                                const SizedBox(
                                  height: 10,
                                ),
                                customField(
                                  obsecureText: true,
                                  name: 'Password',
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
                                  obsecureText: true,
                                  name: 'Confirm Password',
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
                                submitButton(
                                  submitText: 'REGISTER',
                                  onTap: () {
                                    RegisterScreenFunction();
                                  },
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
      ),
    );
  }

  void RegisterScreenFunction() {
    if (formKey.currentState!.validate()) {
      viewModel.createAcount(
          fName: nameController.text,
          email: emailController.text,
          password: passController.text);
    }
  }

  @override
  void goToHome(MyUser user) {
    var provider = Provider.of<UserProvider>(context, listen: false);
    User? FirebaseUser = FirebaseAuth.instance.currentUser;
    provider.firebaseUser = FirebaseUser;
    provider.user = user;
    Navigator.pushReplacementNamed(context, HomeLayout.roudeName);
  }

  @override
  RgisterViewModel iniViewModel() {
    return RgisterViewModel();
  }
}
