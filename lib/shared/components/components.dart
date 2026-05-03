import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nexus/shared/components/constants.dart';
import 'package:nexus/shared/styles/colors.dart';

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

PreferredSizeWidget appBar({String title = 'Nexus', List<Widget>? actions}) {
  return AppBar(
    title: Text('Nexus'),
    actions: actions,
    backgroundColor: Colors.white,
    elevation: 0,
  );
}

Widget formField({
  required String label,
  double labelSize = labelSmallTextSize,
  Color labelColor = inputLabelColor,
  FontWeight labelWeight = FontWeight.bold,
  String? hint,
  IconData? prefixIcon,
  IconData? suffixIcon,
  Function? onSuffixIconTapped,
  TextInputType? inputType,
  bool hidePassword = false,
  TextEditingController? controller,
  Function(String?)? validator,
  Function(String?)? onSubmit,
}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      label,
      style: TextStyle(
        fontSize: labelSize,
        color: labelColor,
        fontWeight: labelWeight,
      ),
    ),
    SizedBox(height: 5),
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(inputFieldRadius),
        ),
        prefixIcon: (suffixIcon != null) ? Icon(prefixIcon) : null,
        suffixIcon: (suffixIcon != null)
            ? InkWell(
                onTap: () => onSuffixIconTapped?.call(),
                child: Icon(suffixIcon),
              )
            : null,
        hintText: hint,
        hintStyle: TextStyle(color: secondaryColor),
      ),
      onFieldSubmitted: (value) => onSubmit?.call(value),
      obscureText: hidePassword,
      validator: (value) => validator?.call(value),
      keyboardType: inputType,
    ),
  ],
);

// TODO: fix the ripple effect bug later
Widget button({
  required Function onPressed,
  required String label,
  Color labelColor = buttonLabelColor,
  double labelSize = labelSmallTextSize,
  FontWeight labelWeight = FontWeight.bold,
  IconData? suffixIcon,
  Color suffixIconColor = Colors.white,
  IconData? prefixIcon,
  Color prefixIconColor = Colors.white,
  Color buttonColor = buttonBackgroundColor,
  bool isOutlined = false,
}) {
  return InkWell(
    onTap: () {
      onPressed.call();
    },
    child: Container(
      height: 60,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadiusGeometry.circular(buttonRadius),
        border: isOutlined
            ? BoxBorder.all(width: 1, color: neutralColor)
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcon != null)
            Icon(prefixIcon, color: prefixIconColor, size: 20),
          if (prefixIcon != null) SizedBox(width: 20),
          Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontSize: labelSize,
              fontWeight: labelWeight,
            ),
          ),
          if (suffixIcon != null) SizedBox(width: 20),
          if (suffixIcon != null)
            Icon(suffixIcon, color: suffixIconColor, size: 20),
        ],
      ),
    ),
  );
}

// TODO: fix the ripple effect bug later
Widget textButton({
  required Function onPressed,
  required String label,
  Color labelColor = textButtonLabelColor,
  double labelSize = labelSmallTextSize,
  FontWeight labelWeight = FontWeight.bold,
}) {
  return InkWell(
    onTap: () {
      onPressed.call();
    },
    child: Text(
      label,
      style: TextStyle(
        color: labelColor,
        fontSize: labelSize,
        fontWeight: labelWeight,
      ),
    ),
  );
}

Widget horizontalDivider({String centerLabel = ''}) {
  return Row(
    children: [
      Expanded(child: Container(height: 1, color: neutralColor)),
      Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 20),
        child: Text(
          centerLabel,
          style: TextStyle(color: neutralColor, fontSize: labelSmallTextSize),
        ),
      ),
      Expanded(child: Container(height: 1, color: neutralColor)),
    ],
  );
}

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
