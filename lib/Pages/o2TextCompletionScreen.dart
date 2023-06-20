import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:o2openai/apikey/apikey.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TextCompletion extends StatefulWidget {
  const TextCompletion({super.key});

  @override
  State<TextCompletion> createState() => _TextCompletionState();
}

class _TextCompletionState extends State<TextCompletion> {
  TextEditingController textsolution = TextEditingController();

  // List<dynamic> textanswer = [];
  String finaltextanswer = "";
  Future<void> generateAnswer() async {
    final url = Uri.parse(
        "https://api.openai.com/v1/engines/davinci-codex/completions");
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $api_keys"
    };
    final body = jsonEncode(
        {"prompt": textsolution.text, "temperature": 0.5, "max_tokens": 100});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      finaltextanswer = json['choices'][0]['text'];
      print(finaltextanswer);
    } else {
      throw Exception("Failed to generate answer: ${response.statusCode}");
    }
    print(finaltextanswer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
            color: Colors.black,
          ),
        ],
        title: const Text(
          "Text Completion",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            //textformfield with validation
            TextField(
              controller: textsolution,
              decoration: InputDecoration(
                hintText: "Ask Anything",
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 62, 63, 75),
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    textsolution.clear();
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Color.fromARGB(255, 62, 63, 75),
                  ),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 62, 63, 75),
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 240, 240, 240),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 240, 240, 240),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      // color: Color.fromARGB(255, 240, 240, 240),
                      color: Colors.green.shade200),
                ),
              ),
              onSubmitted: (value) async {
                setState(() {});
              },
            ),
            SizedBox(height: 20),

            //show the finaltextanswer calling the futurebuilder function
            FutureBuilder(
                future: generateAnswer(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      finaltextanswer,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 62, 63, 75),
                        fontSize: 20,
                        // fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  }
                }),
          ],
        )),
      ),
    );
  }
}
