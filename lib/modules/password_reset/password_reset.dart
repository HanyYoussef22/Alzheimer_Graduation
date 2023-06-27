import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../shard/shared/components.dart';
import '../../shard/styles/Theme_Cubit.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:BlocProvider.of<ThemeCubit>(context).state? Color(0xFF141922):Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                 Text(
                  'Reset password',

                  style: TextStyle(
                      color: BlocProvider.of<ThemeCubit>(context).state? Colors.white:Color(0xFF141922),
                      fontSize: 30, fontFamily: 'oxygen'),
                ),
                const SizedBox(
                  height: 15,
                ),
                 Text(
                  'Enter the email address associated with your account and we\'ll send an email with instructions to reset your password ',
                  style: TextStyle(
                    color: BlocProvider.of<ThemeCubit>(context).state? Colors.white:Color(0xFF141922),                    // color: Colors.black54,
                    fontSize: 16,
                    fontFamily: 'oxygen',
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),

                customField(
                  isDark: BlocProvider.of<ThemeCubit>(context).state,
                  name: AppLocalizations.of(context)!.email,
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
                  height: 35,
                ),
                SizedBox(
                  height: 48,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        ),
                      onPressed: () {
                        if(formKey.currentState!.validate()){
                          RestPass();
                          print('test');
                          AwesomeDialog(
                              btnOkColor: Colors.indigoAccent,
                              context: context,
                              dialogType: DialogType.success,
                              borderSide: const BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                              width: 590,
                              buttonsBorderRadius: const BorderRadius.all(
                                Radius.circular(2),
                              ),
                              dismissOnTouchOutside: true,
                              dismissOnBackKeyPress: false,
                              buttonsTextStyle: TextStyle(fontSize: 17),
                              headerAnimationLoop: false,
                              animType: AnimType.bottomSlide,
                              title: 'Sent Successfully',
                              titleTextStyle: const TextStyle(
                                fontSize: 17,
                                fontFamily: 'oxygen',
                                fontWeight: FontWeight.w700,
                              ),
                              descTextStyle:
                              const TextStyle(fontFamily: 'oxygen', fontSize: 15),
                              desc:
                              'Password reset email has been sent, please check your email.',
                              showCloseIcon: true,
                              btnOkOnPress: () {},
                              btnOkText: 'OK').show();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.email_outlined),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Reset Password',
                          style: TextStyle(
                            fontSize: 19,
                            fontFamily: 'oxygen',
                            fontWeight: FontWeight.w800
                          ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void RestPass() {
    if (formKey.currentState!.validate()) {
      FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
    }
  }
}

