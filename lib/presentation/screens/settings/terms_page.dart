import 'package:flutter/material.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 25,
            )),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: const Column(
        children: [
          Image(image: AssetImage("asset/images/vidPlay.png"), height: 100),
          Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Center(
                child: Text(
                  'Terms and Conditions',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ]),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                        "1. Acceptance of Terms By using this video player, you agree to comply with these terms and conditions. If you do not agree with any part of these terms, please refrain from using the video player.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                        "2. License and Usage\na. The video player is licensed, not sold, for personal or non-commercial use.\nb. Users may not modify, reverse engineer, or distribute the video player without prior written consent",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                  Text(
                      "3. User Conduct\na. Users are responsible for the content they upload or play using the video player.\nb. Users must not violate any laws, infringe copyrights, or share inappropriate content.\nc. Users must not attempt to access unauthorized parts of the video player or disrupt its functionality.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400))
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
