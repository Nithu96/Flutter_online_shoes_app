import 'package:flutter/material.dart';

import '../services/font_size.dart';

class MainButton extends StatelessWidget {
  MainButton(
      {required this.handleFunction,
        required this.name,
        required this.backColor,
        this.disableButton = false});

  Function handleFunction;
  Color backColor;
  String name;
  bool disableButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
        height: MediaQuery.of(context).size.height /20,
      child: ElevatedButton(
        onPressed: disableButton ? null : () {
          handleFunction();
        },
        style: ElevatedButton.styleFrom(
            primary:  disableButton ? Colors.grey : backColor ?? Color(0xFFF9D105),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            name,
            style:  TextStyle(fontSize: FontSizeService().fs_s16, color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}