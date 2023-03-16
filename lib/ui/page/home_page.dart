import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widget/verical_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String contentText = "";
  String from = "";

  int lineWidth = 18;
  double lineLength = 12;

  bool darkModeOn = false;

  void textContext() async {
    var url = Uri.parse("https://v1.hitokoto.cn/?c=i");
    var res = await http.post(url);
    Map<String, dynamic> resData = json.decode(res.body);

    setState(() {
      contentText = resData['hitokoto'];
      from = resData['from'];
    });
  }

  Widget textWidget() {
    return VericalText(
      contentText: contentText,
      from: from,
      lineLength: lineLength,
      lineWidth: lineWidth,
    );
  }

  Widget imageWiget() {
    return const CircleAvatar(radius: 90, backgroundColor: Colors.white, backgroundImage: NetworkImage("https://img6.bdstatic.com/img/image/pcindex/sunjunpchuazhoutu.JPG"));
  }

  @override
  void initState() {
    super.initState();
    textContext();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [imageWiget(), textWidget()],
      ),
    );
  }
}
