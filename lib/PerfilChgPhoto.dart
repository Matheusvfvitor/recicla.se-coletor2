import 'dart:io';
import 'dart:math' as Math;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'Navegador.dart';
import 'TrashColors.dart';

FirebaseAuth auth = FirebaseAuth.instance;
String currUser = auth.currentUser.uid;

class PerfilChgPhoto extends StatefulWidget {
  createState() => _PerfilChgPhoto();
}

class _PerfilChgPhoto extends State<PerfilChgPhoto> {
  File _imageFile;
  final imagePicker = ImagePicker();
  bool _inProgress = false;
  bool _compressProgress = false;
  StorageUploadTask storage;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: "gs://trashapp-284420.appspot.com");

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage(ImageSource source) async {
    setState(() {
      _inProgress = true;
    });
    final selected = await imagePicker.getImage(source: source);
    var selectedImage = File(selected.path);
    if (selectedImage != null) {
      //var compressedImage = await compressImage(selected);
      setState(() {
        _imageFile = selectedImage;
        _inProgress = false;
      });
    } else {
      setState(() {
        _inProgress = false;
      });
    }
  }

  Future<File> compressImage(File selected) async {
    setState(() {
      _compressProgress = true;
    });
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = new Math.Random().nextInt(10000);

    Im.Image image = Im.decodeImage(selected.readAsBytesSync());

    var compressedImage = File('$path/img_$rand.jpg')
      ..writeAsBytesSync(Im.encodeJpg(image, quality: 5));

    return compressedImage;
  }

  void _startUpload() async {
    String filepath = "image_users/$currUser.png";
    var compressed = await compressImage(_imageFile);
    //var compressed = await testCompressAndGetFile(_imageFile);

    setState(() {
      _compressProgress = false;
      storage = _storage.ref().child(filepath).putFile(compressed);
    });
    Future.delayed(Duration(seconds: 1), () {
      Navegador().goToPerfilPage(context);
    });
  }

  Future<File> testCompressAndGetFile(File file) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      path,
      quality: 88,
      rotate: 180,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TrashColors().appBarBackGround,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navegador().goToPerfilPage(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[],
        title: Text("Altere sua Foto"),
      ),
      bottomNavigationBar: BottomAppBar(
        color: TrashColors().buttonColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(""),
            IconButton(
                icon: Icon(
                  Icons.photo_camera,
                  color: Colors.white,
                ),
                onPressed: () {
                  _pickImage(ImageSource.camera);
                }),
            IconButton(
                icon: Icon(
                  Icons.photo_library,
                  color: Colors.white,
                ),
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                }),
            Text(""),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[
            (_inProgress)
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.95,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Image.file(_imageFile),
                        ),
                        if (storage != null) ...[
                          StreamBuilder<StorageTaskEvent>(
                            stream: storage.events,
                            builder: (context, snapshot) {
                              var event = snapshot?.data?.snapshot;

                              double progressPercent = event != null
                                  ? event.bytesTransferred /
                                      event.totalByteCount
                                  : 0;

                              return Column(
                                children: [
                                  if (storage.isComplete)
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Text('Completo'),
                                    ),

                                  if (storage.isPaused)
                                    FlatButton(
                                      child: Icon(Icons.play_arrow),
                                      onPressed: storage.resume,
                                    ),

                                  if (storage.isInProgress)
                                    FlatButton(
                                      child: Icon(Icons.pause),
                                      onPressed: storage.pause,
                                    ),

                                  // Progress bar
                                  LinearProgressIndicator(
                                      value: progressPercent),
                                  Text(
                                      '${(progressPercent * 100).toStringAsFixed(2)} % '),
                                ],
                              );
                            },
                          )
                        ] else ...[
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            child: FlatButton.icon(
                                color: TrashColors().buttonColor,
                                onPressed: _startUpload,
                                textColor: Colors.white,
                                icon: Icon(Icons.cloud_upload),
                                label: Text("Salvar foto")),
                          )
                        ],
                      ]))
          ] else ...[
            Container(
                margin: EdgeInsets.only(top: 50, bottom: 20),
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png'))))
          ]
        ],
      ),
    );
  }
}
