import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  File _image = File("not yet");
  File _pickedIamages = File("not yet");

  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        print("object1111111111111111111" + pickedFile.path);

        _image = File(pickedFile.path);

        setState(() {
          _pickedIamages = File(pickedFile.path);
        });
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rends ta photo parfaite  ! "),
      ),
      body: Container(
        width: w,
        height: h,
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                width: 40,
                height: 40,
                child: Image.asset("assets/upload-image.png"),
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return Container(
                        padding: const EdgeInsets.all(0),
                        child: Wrap(
                          children: <Widget>[
                           /* ListTile(
                                leading: const Icon(Icons.camera),
                                title: const Text('Camera'),
                                onTap: () {
                                  getImage(ImageSource.camera);
                                  Navigator.pop(context);
                                }),*/
                            ListTile(
                              leading: const Icon(Icons.image),
                              title: const Text('Gallerie'),
                              onTap: () {
                                getImage(ImageSource.gallery);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
            Center(
                child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Table(
                        border: TableBorder.symmetric(
                            inside: BorderSide(color: Colors.black)),
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0))),
                              children: [
                                Container(
                                    height: 30.0,
                                    child: Center(child: Text(' Image  réelle ')))
                              ]),
                          TableRow(children: [
                            Container(
                                height: (h - 270) / 2,
                                padding: const EdgeInsets.all(0),
                                child: _image.path == "not yet"
                                    ? Center(
                                        child: const Text(
                                            "cliquer sur l'icone de l'upload au dessus ."))
                                    : Container(
                                        color: Colors.amberAccent,
                                        child: Image.file(
                                          _pickedIamages,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                          ]),
                          TableRow(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.0))),
                              children: [
                                Container(
                                    height: 30.0,
                                    child: Center(child: Text('nouvelle image ')))
                              ]),
                          TableRow(children: [
                            Container(
                                height: (h - 270) / 2,
                                padding: const EdgeInsets.all(0),
                                child: _image.path == "not yet"
                                    ? Center(child: const Text("not yet !!!!"))
                                    : Container(
                                        color: Colors.amberAccent,
                                        child: Image.file(
                                          _pickedIamages,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                          ]),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ])),
          ],
        ),
      ),
    );
  }
}
