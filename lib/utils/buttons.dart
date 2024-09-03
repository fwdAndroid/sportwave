import 'package:flutter/material.dart';
import 'package:sportwave/utils/colors.dart';

// ignore: must_be_immutable
class SaveButton extends StatelessWidget {
  String title;
  final void Function()? onTap;

  SaveButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color(0xff000080),
            Color(0xff000080),
            //add more colors
          ]),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              fixedSize: const Size(270, 49),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 14,
                fontFamily: "Mulish",
                fontWeight: FontWeight.w500,
                color: colorwhite),
          ),
        ));
  }
}

// ignore: must_be_immutable
class OutlineButton extends StatelessWidget {
  String title;
  final void Function()? onTap;

  OutlineButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xffE94057), width: 1),
          fixedSize: const Size(46, 20),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      child: Text(
        title,
        style: const TextStyle(
            fontFamily: "Mulish",
            fontWeight: FontWeight.w600,
            color: Color(0xffE94057)),
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  const DefaultButton({
    super.key,
    required this.text,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          onPressed: press,
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
