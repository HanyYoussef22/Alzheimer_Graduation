import 'package:alzahimer/resources/app_images.dart';
import 'package:flutter/material.dart';

Widget submitButton({
  required String submitText,
  required onTap,
}) {
  return SizedBox(
    height: 55,
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:  Colors.purple
        ,
      ),
      onPressed: onTap,
      child: Text(
        submitText,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
            fontFamily: 'Poppins'),
      ),
    ),
  );
}


customTextField(
    {TextInputType? inputType,
      double? borderRadius,
      required Controller,
      String? title,
      String? hintText,
      VoidCallback? fieldTapping,
      required validator,
      double? cp,
      required IconData? prefixIcon}) {
  return TextFormField(
    onTap: fieldTapping,
    keyboardType: inputType,
    controller: Controller,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: cp ?? 18),
      labelStyle: TextStyle(
        fontSize: 15,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
      labelText: title,
      hintText: hintText,
      prefixIcon: Icon(prefixIcon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
    ),
    validator: validator,
  );
}

Widget
formBackground({
  required bool isDark,
  required String welcomeTitle,
  required String welcomeHint,
}) {
  return isDark?
  Container(
    decoration:  BoxDecoration(
      color:Color(0xFF060E1E),
    ),
    child: Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 35
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text(welcomeTitle,
            style:const  TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8,),
          Text(welcomeHint,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    ),
  ):
  Container(
    decoration: const BoxDecoration(
      image: DecorationImage(

        image: AssetImage(
           AppImages.loginBackground,
        ),
        fit: BoxFit.cover,

      ),



    ),
    child: Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 35
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text(welcomeTitle,
            style:const  TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8,),
          Text(welcomeHint,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    ),
  );
}

Widget layoutForm(Widget widget) {
  return LayoutBuilder(
    builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: widget,
          ),
        ),
      );
    },
  );
}

customField({
  required bool isDark,
  VoidCallback? fieldTapping,
  required String name,
  required IconData prefixIcon,
  required String? Function(String?) validate,
  IconButton? suffixIcon,

  required TextEditingController controller,
  bool? obsecureText,
  bool? autofocus,
}) {
  return TextFormField(
    autofocus: autofocus ?? false,
    controller: controller,
    validator: validate,
    onTap: fieldTapping,
    obscureText: obsecureText ?? false,
    decoration: InputDecoration(
      hintText: name,
      suffixIcon: suffixIcon,
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontFamily: 'Poppins',
        // fontWeight: FontWeight.w600,
      ),
      prefixIcon: Icon(prefixIcon),
      filled: true,
      fillColor: isDark?Colors.white70: Color(0xffEEEEEE),
      border: InputBorder.none,
    ),
  );
}

