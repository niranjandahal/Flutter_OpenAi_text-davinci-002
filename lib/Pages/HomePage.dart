import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main.dart';
import 'o1ImageGenerationScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'o2TextCompletionScreen.dart';

class HomePage extends StatefulWidget {
  bool? darkmode;
  bool? islogin;
  HomePage({
    super.key,
    this.darkmode,
    this.islogin,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

// Qwermnbv@#123

class _HomePageState extends State<HomePage> {
  IconData _iconlight = Icons.wb_sunny;
  IconData _icondark = Icons.nights_stay;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setBool("darkmode", !widget.darkmode!);
                //rerun the entire app from myapp
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyApp(
                              darkmode: !widget.darkmode!,
                              islogin: widget.islogin!,
                            )));
              },
              icon: Icon(widget.darkmode! ? _icondark : _iconlight))
        ],
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            FontAwesomeIcons.sun,
          ),
        ),
        title: const Text("Open AI API BETA",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        customButton(
          tittletext: "Image Generations",
          subtitletext: "Generate any images easily",
          customicon: FontAwesomeIcons.solidImages,
          colorone: const Color.fromARGB(135, 110, 5, 229),
          colortwo: const Color.fromARGB(129, 56, 16, 188),
          // textColor: Colors.black,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const ImageGeneratingOpenApi();
                // TextCompletion
              },
            ));
          },
          context: context,
        ),
        const SizedBox(height: 20),
        customButton(
          tittletext: "Text Completions",
          subtitletext: "Generate and edit Text easily",
          customicon: FontAwesomeIcons.penToSquare,
          colorone: const Color.fromARGB(133, 14, 224, 182),
          colortwo: const Color.fromARGB(129, 19, 187, 142),
          // textColor: Colors.black, is this sufficient enough for the text
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const TextCompletion();
              },
            ));
          },
          context: context,
        ),
        const SizedBox(height: 20),
        customButton(
          //is this recording sufficetn
          tittletext: "Code Completions",
          subtitletext: "Generate edit and explain code ",
          customicon: FontAwesomeIcons.code,
          colorone: const Color.fromARGB(133, 218, 15, 221),
          colortwo: const Color.fromARGB(129, 145, 16, 100),
          // textColor: Theme.of(context).,
          onPressed: () {
            // print("code generation button pressed");
          },
          context: context,
        ),
        SizedBox(height: 20),
        //logout button
        ElevatedButton(
          onPressed: () async {
            SharedPreferences sp = await SharedPreferences.getInstance();
            sp.setBool("islogin", false);
            sp.remove('name');
            //go to runapp
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MyApp(darkmode: widget.darkmode!, islogin: false),
                ));
          },
          child: const Text("Logout"),
        ),
      ])),
    );
  }
}

Widget customButton(
    {required String tittletext,
    required String subtitletext,
    required IconData customicon,
    required Color colorone,
    required Color colortwo,
    // required Color textColor,
    required onPressed,
    context}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      // width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 65,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  colorone,
                  colortwo,
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Icon(
              customicon,
            ),
          ),
          Container(
              padding: EdgeInsets.only(left: 20),
              width: 250,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tittletext,
                    style: TextStyle(
                      // color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitletext,
                    style: TextStyle(
                      // color: textColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              )),
        ],
      ),
    ),
  );
}
