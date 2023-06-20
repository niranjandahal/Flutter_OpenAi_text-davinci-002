import 'package:flutter/material.dart';
import 'package:o2openai/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  bool? darkmode;

  LoginScreen({super.key, this.darkmode});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
          child: Column(
        children: [
          textformfield(
            hinttext: "Name",
            controller: namecontroller,
            textinputtype: TextInputType.emailAddress,
            obscuretext: false,
            prefixicon: Icons.email,
            suffixicon: Icons.visibility,
            suffixicononpressed: () {},
          ),
          textformfield(
            hinttext: "Password",
            controller: passwordcontroller,
            textinputtype: TextInputType.visiblePassword,
            obscuretext: true,
            prefixicon: Icons.lock,
            suffixicon: Icons.visibility,
            suffixicononpressed: () {},
          ),
          //login button
          ElevatedButton(
            onPressed: () async {
              if (namecontroller.text == "admin" &&
                  passwordcontroller.text == "admin") {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setBool("islogin", true);
                sp.setString("name", 'ADMIN');
                //go to runapp
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MyApp(darkmode: widget.darkmode!, islogin: true),
                    ));
              } else {}
            },
            child: const Text("Login"),
          ),
        ],
      )),
    );
  }
}

Widget textformfield({
  required String? hinttext,
  required TextEditingController? controller,
  required TextInputType? textinputtype,
  required bool? obscuretext,
  required IconData? prefixicon,
  required IconData? suffixicon,
  required Function? suffixicononpressed,
}) {
  return TextFormField(
    key: UniqueKey(),
    validator: (value) {
      if (value!.isEmpty) {
        return "Please enter some text";
      }
      return null;
    },
    controller: controller,
    keyboardType: textinputtype,
    obscureText: obscuretext!,
    decoration: InputDecoration(
      hintText: hinttext,
      prefixIcon: Icon(prefixicon),
      suffixIcon: IconButton(
        onPressed: suffixicononpressed as void Function()?,
        icon: Icon(suffixicon),
      ),
    ),
  );
}
