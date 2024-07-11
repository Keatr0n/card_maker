import 'dart:io';

import 'package:flutter/material.dart';

import 'backdrop.dart';

class BirthdayCard extends StatelessWidget {
  const BirthdayCard(this.text, this.image, this.headerFontSize, this.textFontSize, {super.key});

  final String text;
  final File image;
  final double headerFontSize;
  final double textFontSize;

  @override
  Widget build(BuildContext context) {
    final imageWidget = Image.file(image);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: Backdrop(
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          color: Colors.white24,
          width: imageWidget.width,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Text(
                  text.split("\n").first,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: headerFontSize, color: Colors.black54),
                ),
              ),
              Text(
                text.replaceFirst(text.split("\n").first, ""),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: textFontSize,
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
        imageWidget,
      ),
    );
  }
}
