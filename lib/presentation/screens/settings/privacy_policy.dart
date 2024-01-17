import 'package:flutter/material.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPage> createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Image(image: AssetImage("asset/images/vidPlay.png"), height: 100),
            Column(children: [
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Center(
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                        "VidPlay Video player app provides mobile applications on Google Play and We provide this Privacy Policy to inform you of our policies regarding the collection, use, disclosure and protection of information regarding this application.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                        "1. Information We Receive\nBy installing this mobile application from Google Play, you are authorizing the application to collect, store, and use in accordance with this Privacy policy.\nBased on the type of the application, there may be a need to access Videos and directories . Currently, our applications do not store this information on it’s Servers. It is primarily to enrich your user experience in the application.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                        "2. We Don’t Collect Information of Children\nOur website and mobile applications comply with the Children’s Online Privacy Protection Act. We don’t knowingly collect personal information from children under the age of 13, and if in the event that a user identifies himself or herself as a child under the age of 13 through a support request, we will not collect, store or use, and will delete in a secure manner, any personal information of such user.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                  Text(
                      "3. Location Information\nWe do not use or collect your geographic location.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400))
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
