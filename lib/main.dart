import 'package:flutter/material.dart';

import './ui/page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool darkModeOn = false;
  bool customTheme = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    Brightness brightness = WidgetsBinding.instance.window.platformBrightness;
    if (customTheme) {
      return;
    }

    if (brightness.name == 'light') {
      setState(() {
        darkModeOn = false;
      });
    } else {
      setState(() {
        darkModeOn = true;
      });
    }
  }

  Brightness lightBrightness() {
    Brightness brightness;
    if (customTheme && darkModeOn) {
      brightness = Brightness.dark;
    } else {
      brightness = Brightness.light;
    }

    return brightness;
  }

  Brightness darkBrightness() {
    Brightness brightness;
    if (customTheme && !darkModeOn) {
      brightness = Brightness.light;
    } else {
      brightness = Brightness.dark;
    }

    return brightness;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '一个',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          fontFamily: "shuyunsong",
          brightness: lightBrightness()),
      darkTheme: ThemeData(fontFamily: "shuyunsong", brightness: darkBrightness()),
      home: Scaffold(
        body: Stack(children: [
          const HomePage(),
          Positioned(
            right: 20,
            top: 50,
            child: SizedBox(
                width: 30,
                height: 30,
                child: MaterialButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () {
                    setState(() {
                      customTheme = true;
                      darkModeOn = !darkModeOn;
                    });
                  },
                  child: Icon(
                    darkModeOn ? Icons.dark_mode_outlined : Icons.dark_mode,
                    size: 25,
                  ),
                )),
          )
        ]),
      ),
    );
  }
}
