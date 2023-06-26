import 'package:alzahimer/Home_Layout/Home_Layout.dart';
import 'package:alzahimer/sign_up/register_cubit.dart';
import 'package:alzahimer/sign_up/register_state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:intl/intl.dart';
import '../login/login_screen.dart';
import '../shard/network/local/cache_helper.dart';
import '../shard/shared/components.dart';

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
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
         builder: (context,state) {
           return Scaffold(
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
                                     customField(
                                         name: 'Birth',
                                         fieldTapping: (){
                                           showDatePicker(
                                             context: context,
                                             initialDate: DateTime.now(),
                                             firstDate: DateTime(2020 - 10 - 10),
                                             lastDate: DateTime(2099 - 3 - 3),
                                           ).then((value) => dateController.text =
                                               DateFormat.yMMMd().format(value!));
                                         },
                                         prefixIcon: Icons.date_range_rounded,
                                         validate: (value){
                                           if(value ==null) {
                                             return 'Birth Date is required';
                                           }
                                         }, controller: dateController),
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
                                     SizedBox(
                                       height: 62,
                                       width: double.infinity,
                                       child: ElevatedButton(
                                           onPressed: () {
                                             if(formKey.currentState!.validate()) {
                                               RegisterCubit.get(context).userRegister(
                                                   email: emailController.text,
                                                   password: passController.text,
                                                   name: nameController.text,
                                                   birthDate: dateController.text
                                               );
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
                                                 MainAxisAlignment
                                                     .center,
                                                 children: const [
                                                   Icon(Icons
                                                       .login_outlined),
                                                   SizedBox(
                                                     width: 10,
                                                   ),
                                                   Text(
                                                     'REGISTER',
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
                                             is RegisterLoadingState,
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
         },
        listener: (context,state){
          CacheHelper.saveData(key: 'signed', value: true).then((value) {
            Navigator.pushNamed(context, HomeLayout.roudeName);
          });
        },
      ),

    );
  }
}
