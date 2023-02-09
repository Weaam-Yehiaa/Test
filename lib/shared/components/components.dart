import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.purpleAccent,
  bool isUpperCase = true,
  double radius = 0,
  required void Function()? function,
  required String text,

}) =>   Container(
  width: width,

  height: 40.0,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text ,
      style: TextStyle(
          color: Colors.white
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
      radius,
    ),
    color: background,
  ),
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword=false,
  Function? onSumbmit,
  Function? onChanged,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,

}) => TextFormField(
  controller: controller,
  obscureText: isPassword,
  decoration: InputDecoration(
    labelText: label,
    border: OutlineInputBorder(),
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix!=null ?
    IconButton(
      onPressed:suffixPressed!() ,
      icon: Icon(
        suffix,),

    ):null,

  ),
  keyboardType: type,
  onFieldSubmitted:(value) {
    return onSumbmit!(value);
  } ,
  onChanged:(value) {
    return onChanged!(value);
  } ,
  validator: (value) {
    return validate!(value);
  },

);