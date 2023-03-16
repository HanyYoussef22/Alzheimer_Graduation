import 'package:flutter/material.dart';

void showMessage(BuildContext context, String message, String actionName,
    VoidCallback actionCallBack) {
  showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(onPressed: actionCallBack, child: Text(actionName)),
          ],
        );
      });
}

void showLoading(BuildContext context, String text) {
  showDialog(
      context: context,
      builder: (c) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 10,
              ),
              Text(text),
            ],
          ),
        );
      });
}

void hideBottomSheet(BuildContext context) {
  Navigator.pop(context);
}

Widget defaultButton({
  double width = double.infinity,
  double heidth = 50,
  double radius = 0,
  required String text,
  bool IsUpperCase = false,
  Color btnColor = Colors.blue,
  required VoidCallback onPressed,
}) {
  return Container(
    height: heidth,
    width: width,
    child: MaterialButton(
      onPressed: onPressed,
      child: Text(
        IsUpperCase! ? text.toUpperCase() : text,
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.normal, color: Colors.white),
      ),
    ),
    decoration: BoxDecoration(
        color: btnColor, borderRadius: BorderRadius.circular(radius)),
  );
}

Widget defaultTextButton({
  required String text,
  bool IsUpperCase = false,
  Color btnColor = Colors.blue,
  required VoidCallback onPressed,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      IsUpperCase! ? text.toUpperCase() : text,
      style: TextStyle(
          fontSize: 17, fontWeight: FontWeight.normal, color: Colors.green),
    ),
  );
}

// void  showToast({required String text,})
// //Install>>>> Terminal>>>  flutter pub add fluttertoast
// {
//   Fluttertoast.showToast(
//       msg: text,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 2,
//       backgroundColor: Colors.black87,
//       textColor: Colors.white,
//       fontSize: 16.0
//   );
// }

Widget defaultTextField({
  double radius = 12,
  // installation   flutter pub add passwordfield
}) {
  bool State = true;
  return TextFormField(
    obscureText: State,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: Colors.blue),
      ),
      hintText: 'Password',
      hintStyle: TextStyle(fontSize: 13),
    ),
    validator: (text) {
      if (text!.isEmpty || text.trim().isEmpty) {
        return 'Pleas Enter Your Password';
      }
      return null;
    },
  );
}

defaultTextFormField({
  VoidCallback? onPressed,
  TextInputType? keyboardType,
  required String? hintText,
  required String? Function(String?) validate,
  required TextEditingController? Controller,
  IconButton? prefixIcon,
  double? circular,
  Color? Colorfill,
  bool obscureText = false,
}) {
  return TextFormField(
    keyboardType: keyboardType,
    obscureText: obscureText,
    controller: Controller,
    onTap: onPressed,
    validator: validate,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      filled: true,
      fillColor: Colorfill ?? Colors.white,
      hintText: hintText,
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontFamily: 'oxygen',
        // fontWeight: FontWeight.w600,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(circular ?? 0),
        borderSide: BorderSide(color: Colors.blue),
      ),
    ),
  );
}
