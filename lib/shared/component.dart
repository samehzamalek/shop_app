import 'package:flutter/material.dart';


Widget defaultFormField({
  required context,
  TextEditingController? controller,
  dynamic label,
  IconData ? prefix,
  String ? initialValue,
  TextInputType ?keyboardType,
  Function(String)? onSubmit,
  onChange,
  onTap,
  required String? Function(String?) validate,
  bool isPassword = false,
  bool enabled = true,
  IconData ?suffix,
  suffixPressed,
}) =>
    TextFormField(

      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      textAlign: TextAlign.start,
      onFieldSubmitted: onSubmit,
      enabled: enabled,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      textCapitalization: TextCapitalization.words,
      textAlignVertical: TextAlignVertical.center,
      style:Theme.of(context).textTheme.bodyText1,
      initialValue:initialValue,

      //textCapitalization: TextCapitalization.words,

      decoration: InputDecoration(
        hintText: label,
        border:const OutlineInputBorder(),
        prefixIcon: Icon(prefix,),
        suffixIcon: suffix != null ? IconButton(onPressed: suffixPressed, icon: Icon(suffix)) : null,

      ),
    );

Widget defaultButton({
  required VoidCallback onTap,
  required String text,
  double? width = double.infinity,

}) => Container(
  height: 50,
  width: width,
  decoration: const BoxDecoration(
    color: Colors.red,
  ),
  child: ElevatedButton(
    onPressed: onTap,
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 17,
      ),
    ),
  ),
);



