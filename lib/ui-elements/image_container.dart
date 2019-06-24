import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imageUrl;
  ImageContainer(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: GridTile(
      // footer: new Text(data[index]['name']),
      child: new Image.network(imageUrl,
          height: 200.0, width: 200.0, fit: BoxFit.cover),
    ));
  }
}
