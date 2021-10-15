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
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image "),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            GestureDetector(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: _image.path == "not yet"
                    ? const NetworkImage(
                            "https://cdn4.iconfinder.com/data/icons/avatars-xmas-giveaway/128/batman_hero_avatar_comics-512.png")
                        as ImageProvider
                    : FileImage(_image),
              ),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return Container(
                        padding: const EdgeInsets.all(0),
                        child: Wrap(
                          children: <Widget>[
                            ListTile(
                                leading: const Icon(Icons.camera),
                                title: const Text('Camera'),
                                onTap: () {
                                  getImage(ImageSource.camera);
                                  Navigator.pop(context);
                                }),
                            ListTile(
                              leading: const Icon(Icons.image),
                              title: const Text('Gallery'),
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
            Container(
                height: 250,
                padding: const EdgeInsets.all(0),
                child: _image.path == "not yet"
                    ? const Text("not yet !!!!")
                    : Container(
                        color: Colors.amberAccent,
                        child: Image.file(
                          _pickedIamages,
                          fit: BoxFit.cover,
                        ),
                      ))
          ],
        ),
      ),
    );
  }
}
