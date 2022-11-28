import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  Future getImage(bool is_cam) async {
    if (is_cam) {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemoprary = File(image.path);
      setState(() {
        _image = imageTemoprary;
      });
    } else {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemoprary = File(image.path);
      setState(() {
        _image = imageTemoprary;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker App'),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            _image != null
                ? Image.file(_image!)
                : Image.network(
                    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
            ElevatedButton(
                onPressed: () {
                  getImage(true);
                },
                child: Center(
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 150,
                      ),
                      Icon(Icons.camera_outlined),
                      Text('Camera')
                    ],
                  ),
                )),
            ElevatedButton(
                onPressed: () {
                  getImage(false);
                },
                child: Center(
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 155,
                      ),
                      Icon(Icons.image_outlined),
                      Text('Gallery')
                    ],
                  ),
                ))
          ],
        ),
      )),
    );
  }
}

Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return Container(
    width: 280,
    child: ElevatedButton(
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 68,
          ),
          Text(title)
        ],
      ),
      onPressed: () {
        onClick;
      },
    ),
  );
}
