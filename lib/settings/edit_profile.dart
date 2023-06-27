import 'dart:io';
import 'package:alzahimer/Models/My_User.dart';
import 'package:alzahimer/shard/styles/Theme_Cubit.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Home_Layout/layout_cubit.dart';
import '../Home_Layout/layout_states.dart';
import '../Models/user.dart';
import '../l10n/Localization_Cubit.dart';

class EditProfileScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  // EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      builder: (context, state) {
        LayoutCubit cubit = LayoutCubit.get(context);
        File? profileImage = LayoutCubit.get(context).profileImage;
        MyUser userModel = LayoutCubit.get(context).model!;
        nameController.text = userModel!.fName;

        phoneController.text = userModel.phone ?? '';
        return Scaffold(
          appBar: AppBar(
            title:  Text(AppLocalizations.of(context)!.editInfo),
            actions: [
              TextButton(onPressed: (){
                if(profileImage !=null) {
                  cubit.profileImageUpload(
                    name: nameController.text,
                    phone: phoneController.text,
                  );
                }
                LayoutCubit.get(context).updateUser(
                  name: nameController.text,
                  phone: phoneController.text,
                );
              }, child:  Text(AppLocalizations.of(context)!.update, style: TextStyle(
                  color: Colors.white
              ),)),
            ],
          ),
          body:  Container(
            width: double.maxFinite,
            height: double.maxFinite,
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConditionalBuilder(condition: state is UserUpdateLoadingState,
                    builder: (context){
                      return LinearProgressIndicator(color: Colors.purple.withOpacity(0.9),);
                    }, fallback: (context){return const SizedBox();}),
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircularProfileAvatar(
                      'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4',
                      borderWidth: 3,
                      borderColor: Colors.white,
                      radius: 56,
                      imageFit: BoxFit.fitWidth,
                      child: profileImage == null
                          ? Image.network(
                        userModel.image!,
                        fit: BoxFit.cover,
                      )
                          : Image.file(
                        profileImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(2, 5),
                      child: IconButton(
                        onPressed: () {
                          LayoutCubit.get(context).getProfileImage();
                        },
                        icon: const CircleAvatar(
                          radius: 15.0,
                          backgroundColor: Colors.purple,
                          child: Icon(

                            IconBroken.Camera,
                            size: 17.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                TextFormField(
                  controller: phoneController,
                  style:  TextStyle(
                      color: BlocProvider.of<ThemeCubit>(context).state?Colors.purple:Colors.black,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 17,
                      fontFamily: 'oxygen',
                      fontWeight: FontWeight.w500),
                  decoration:  InputDecoration(
                    labelText: AppLocalizations.of(context)!.phone,
                    labelStyle: TextStyle(
                      color: BlocProvider.of<ThemeCubit>(context).state?Colors.grey:Colors.black, // Replace with your desired color
                    ),
                    contentPadding: EdgeInsets.all(17),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(IconBroken.Call),
                  ),
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  controller: nameController,
                  style:  TextStyle(
                      color: BlocProvider.of<ThemeCubit>(context).state?Colors.purple:Colors.black,
                      fontSize: 17,
                      fontFamily: 'oxygen',
                      fontWeight: FontWeight.w500),
                  decoration:  InputDecoration(
                    labelText: AppLocalizations.of(context)!.name,
                    labelStyle: TextStyle(
                      color: BlocProvider.of<ThemeCubit>(context).state?Colors.grey:Colors.black, // Replace with your desired color
                    ),
                    contentPadding: EdgeInsets.all(17),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      IconBroken.Profile,
                    ),
                  ),
                ),

                BlocBuilder<LanguageCubit, String>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        String newLanguageCode = BlocProvider.of<LanguageCubit>(context).state == 'ar' ? 'en' : 'ar';
                        BlocProvider.of<LanguageCubit>(context).toggleLanguage(languageCode: newLanguageCode);
                      },
                      child: Text(BlocProvider.of<LanguageCubit>(context).state == 'ar' ? 'Change to English' : 'تغيير اللغة إلى العربية'),
                    );

                  },
                ),


              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}

