import 'package:flutter/material.dart';
import 'package:o2openai/login/login.dart';
import 'Pages/HomePage.dart';
import 'package:o2openai/Themes/themes_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool darkmode = sp.getBool("darkmode") ?? false;
  bool islogin = sp.getBool("islogin") ?? false;
  String name = sp.getString("name") ?? "";
  String imagepath = sp.getString("imagepath") ?? "";

  runApp(MyApp(
    darkmode: darkmode,
    islogin: islogin,
    name: name,
    imagepath: imagepath,
  ));
}
// it think now this recording is far good then other
//now  i think this is good recording than other

class MyApp extends StatefulWidget {
  bool darkmode;
  bool islogin;
  String? name;
  String? imagepath;

  MyApp({
    super.key,
    required this.darkmode,
    required this.islogin,
    this.name,
    this.imagepath,
  });
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: widget.darkmode ? customdarktheme : customlighttheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: widget.islogin
              ? HomePage(
                  darkmode: widget.darkmode,
                  islogin: widget.islogin,
                )
              : LoginScreen(
                  darkmode: widget.darkmode,
                )),
    );
  }
}