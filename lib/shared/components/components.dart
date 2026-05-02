import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(BuildContext context, Widget targetPage) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => targetPage));
}

void navigateToAndRemove(BuildContext context, Widget targetPage) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => targetPage),
    (route) => false,
  );
}

Widget formField({
  required String label,
  IconData? prefixIcon,
  IconData? suffixIcon,
  Function? onSuffixIconTapped,
  TextInputType? inputType,
  bool hidePassword = false,
  TextEditingController? controller,
  Function(String?)? validator,
  Function(String?)? onSubmit,
}) => TextFormField(
  controller: controller,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    prefixIcon: Icon(prefixIcon),
    suffixIcon: (suffixIcon != null)
        ? InkWell(
            onTap: () => onSuffixIconTapped?.call(),
            child: Icon(suffixIcon),
          )
        : null,
    labelText: label,
  ),
  onFieldSubmitted: (value) => onSubmit?.call(value),
  obscureText: hidePassword,
  validator: (value) => validator?.call(value),
  keyboardType: inputType,
);

void showToast({
  required String message,
  Color textColor = Colors.white,
  double textSize = 16.0,
  Color backgroundColor = Colors.red,
  ToastGravity position = ToastGravity.BOTTOM,
  Toast duration = Toast.LENGTH_SHORT,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: duration,
    gravity: position,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor,
    textColor: textColor,
    fontSize: textSize,
  );
}
