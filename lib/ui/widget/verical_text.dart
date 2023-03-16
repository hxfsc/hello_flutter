import 'dart:ui';

import 'package:flutter/material.dart';

class VericalText extends StatefulWidget {
  const VericalText({Key? key, required this.contentText, required this.from, required this.lineWidth, required this.lineLength}) : super(key: key);

  final String contentText;
  final String from;
  final int lineWidth;
  final double lineLength;
  @override
  _VericalTextState createState() => _VericalTextState();
}

class _VericalTextState extends State<VericalText> {
  @override
  Widget build(BuildContext context) {
    String from = widget.from;
    int contentLength = widget.contentText.length;

    int lines = contentLength ~/ widget.lineWidth;

    if (contentLength % widget.lineLength > 0) {
      lines++;
    }

    List<Widget> allList = [];

    for (int i = 0; i < lines; i++) {
      String singleLineText = "";
      singleLineText = widget.contentText.substring(widget.lineWidth * i, i < (lines - 1) ? widget.lineWidth * (i + 1) : contentLength);
      allList.add(Container(
        margin: const EdgeInsets.only(left: 5),
        width: widget.lineLength,
        child: Text(
          singleLineText,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: widget.lineWidth + 1),
        ),
      ));
    }

    for (int i = 0; i < allList.length / 2; i++) {
      Widget temp = allList[i];
      allList[i] = allList[allList.length - 1 - i];
      allList[allList.length - 1 - i] = temp;
    }

    return AnimatedScale(
        scale: widget.contentText != "" ? 1.0 : 0.0,
        duration: const Duration(seconds: 1),
        child: AnimatedRotation(
          turns: widget.contentText != "" ? 1.0 : 0.0,
          duration: const Duration(seconds: 1),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: allList),
                  ),
                ],
              ),
              Text("- $from -")
            ],
          ),
        ));
  }
}
