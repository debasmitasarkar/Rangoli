import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ui-elements/image_container.dart';

class RangoliImages extends StatelessWidget {
  final String category;
  RangoliImages({this.category});
  _buildImages() {
    final rangoliImages = Firestore.instance
        .collection('rangoli-categories')
        .where('category', isEqualTo: category);
    return Container(
        child: StreamBuilder(
            stream: rangoliImages.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              return _buildGrid(snapshot);
            }));
  }

  _buildGrid(snapshot) {
    dynamic ds = snapshot.data.documents[0];
    List<dynamic> images = ds['images'] == null ? ds['image'] : ds['images'];
    return OrientationBuilder(builder: (context, orientation) {
      return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, '/rangoli/image/$category/$index');
                },
                child: ImageContainer(images[index]));
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(category),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: _buildImages(),
        ));
  }
}
