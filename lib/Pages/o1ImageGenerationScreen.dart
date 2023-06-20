import 'package:flutter/material.dart';
import 'package:o2openai/apikey/apikey.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImageGeneratingOpenApi extends StatefulWidget {
  const ImageGeneratingOpenApi({super.key});

  @override
  State<ImageGeneratingOpenApi> createState() => _ImageGeneratingOpenApiState();
}

class _ImageGeneratingOpenApiState extends State<ImageGeneratingOpenApi> {
  var finalimages =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjB8TzJsR7ENk2PpjL9pem0W27QYdxT-qgCg&usqp=CAU';
  final apikeys = api_keys;
  TextEditingController TextToImage = TextEditingController();

  Future<void> imagegenerate() async {
    final url = Uri.parse("https://api.openai.com/v1/images/generations");
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apikeys"
    };

    var response = await http.post(url,
        headers: headers,
        body: jsonEncode({
          "prompt": TextToImage.text,
          "n": 3,
          "size": "256x256",
        }));
    // print(response.statusCode);
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body);

      finalimages = responseJson['data'][0]['url'];
    } else {
      // print("failed to generate image");
    }
    // print(finalimages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
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
              icon: const Icon(
                FontAwesomeIcons.sun,
                color: Color.fromARGB(255, 62, 63, 75),
              ),
            ),
          ],
          title: const Text("Image Generation Beta",
              style: TextStyle(
                color: Color.fromARGB(255, 62, 63, 75),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: TextToImage,
              onSubmitted: (value) async {
                setState(() {
                  finalimages = "";
                });
              },
              decoration: InputDecoration(
                hintText: "Search for an image",
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 62, 63, 75),
                  fontSize: 20,
                  // fontWeight: FontWeight.bold,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    //clear text in textfield
                    TextToImage.clear();
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
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.8,
            child: FutureBuilder(
              future: imagegenerate(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // print(finalimages.length);
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 256,
                        width: 256,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(finalimages.toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      //download button here
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 245, 245, 246),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                "Download",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 245, 245, 246),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                "Share",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey[300],
                    ),
                  );
                }
              },
            ),
          )
        ]))
      ]),
    );
  }
}
