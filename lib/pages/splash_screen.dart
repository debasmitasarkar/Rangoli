import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import '../ui-elements/sections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ui-elements/home.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
//  final List<Section> allSections = [];
  Color _mariner = Colors.redAccent;
  Color _mediumPurple = Colors.amber;
  Color _tomato = Color(0xFFF95B57);
  Color _mySin = Color(0xFFF3A646);

  void navigationPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => AnimationDemoHome()));
  }

  @override
  void initState() {
    super.initState();
    // _saveImageUrlToCategory();
    _getData(context);
  }

  _getSectionDetails(List<dynamic> images, String category) {
    List<SectionDetail> sectionDetails = [];
    int index = 0;
    images.forEach((image) {
      sectionDetails.add(
          SectionDetail(imageAsset: image, index: index, category: category));
      index++;
    });
    return sectionDetails;
  }

  _getData(context) {
    Duration duration = Duration(seconds: 1);
    Stream<QuerySnapshot> snapshots =
        Firestore.instance.collection('rangoli-categories').snapshots();
    snapshots.listen((snapshot) {
      snapshot.documents.forEach((document) {
        Map<String, dynamic> ds = document.data;
        List<dynamic> images =
            ds['images'] == null ? ds['image'] : ds['images'];
        allSections.add(Section(
            title: ds['category'],
            backgroundAsset: images[0],
            leftColor: _mediumPurple, //_mediumPurple,
            rightColor: _mariner,
            details: _getSectionDetails(images, ds['category'])));
      });
      allSections.length == 4 ? Timer(duration, navigationPage) : '';
    });
  }

  // uploadImagesToStore() async {
  //   print(Directory.current.path);
  //   PermissionStatus storagePermission = await PermissionHandler()
  //       .checkPermissionStatus(PermissionGroup.storage);
  //   if (storagePermission == PermissionStatus.granted) {
  //     dirContents(Directory('/')).then((files) {
  //       print(files);
  //     });
  //   } else {
  //     PermissionHandler()
  //         .requestPermissions([PermissionGroup.storage]).then((value) {
  //       print(value);
  //       dirContents(Directory('~/Documents')).then((files) {
  //         print(files);
  //       });
  //     });
  //   }
  // }

  // Future<List<FileSystemEntity>> dirContents(Directory dir) {
  //   var files = <FileSystemEntity>[];
  //   var completer = new Completer<List<FileSystemEntity>>();
  //   var lister = dir.list(recursive: false);
  //   lister.listen((file) => files.add(file),
  //       // should also register onError
  //       onDone: () => completer.complete(files));
  //   return completer.future;
  // }

  // Future<String> _saveImage() async {
  //   File imageFile = File('../../../Rangoli app/Diwali Rangoli/dr2.jpg');
  //   StorageReference ref =
  //       FirebaseStorage.instance.ref().child('Rangoli').child('Diwa');
  //   StorageUploadTask uploadTask = ref.putFile(imageFile);
  //   return await (await uploadTask.onComplete).ref.getDownloadURL();
  // }

  // Future<String> _saveImageUrlToCategory() async {
  //   List<String> urlArray = [];
  //   for (var i = 1; i <= 20; i++) {
  //     var downloadUrl = await FirebaseStorage.instance
  //         .ref()
  //         .child('Rangoli')
  //         .child('Ganesha Rangoli')
  //         .child('g$i.jpg')
  //         .getDownloadURL();
  //     urlArray.add(downloadUrl);
  //   }
  //   print(urlArray);
  //   Firestore.instance
  //       .collection('rangoli-categories')
  //       .where('category-name', isEqualTo: 'Ganesha Rangoli')
  //       .getDocuments()
  //       .then((qs) {
  //     qs.documents[0].reference.setData({
  //       'images': urlArray,
  //     }, merge: true);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
            //flex: 5,
            child: Image.asset('assets/rangoli_loader.gif',
                height: 100.0, width: 100.0)),
      ),
    );
  }
}
