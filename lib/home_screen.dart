import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;

  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> deleteImage() async {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            _image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      _image!,
                      height: size.height / 3,
                      width: size.width,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: size.height / 3,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(),
                    ),
                    child: const Center(
                      child: Icon(Icons.image),
                    ),
                  ),
            const SizedBox(
              height: 50,
            ),
            IconButton(
              iconSize: 20,
              icon: const Icon(
                Icons.delete,
              ),
              onPressed: deleteImage,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  foregroundColor: Colors.black,
                ),
                onPressed: pickImageFromGallery,
                child: const Text("Pick Image From Gallery"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.amberAccent),
                onPressed: pickImageFromCamera,
                child: const Text("Pick Image From Camera"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
