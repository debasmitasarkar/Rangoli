import 'package:flutter/material.dart';
import '../models/rangoli-category.dart';

class CategoryCard extends StatelessWidget {
  final RangoliCategory category;
  CategoryCard(this.category);
  final TextStyle _categoryNameStyle = TextStyle(
    color: Colors.black54,
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.2,
  );
  final TextStyle _descriptionStyle = TextStyle(
    color: Colors.black87,
    fontSize: 15.0,
  );

  _buildImageContainer() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Image.network(category.images[0],
          fit: BoxFit.cover, height: 250.0, width: 400.0),
    );
  }

  _buildDescriptionContainer() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: <Widget>[
            Text(category.category, style: _categoryNameStyle),
            SizedBox(height: 5.0),
            Text(category.description, style: _descriptionStyle)
          ],
        ));
  }

  _buildCard(context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/rangoliImages/${category.category}');
        },
        child: Card(
          color: Color.fromRGBO(255, 231, 195, 1.0),
            child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(children: <Widget>[
                  _buildImageContainer(),
                  _buildDescriptionContainer(),
                ]))));
  }

  @override
  Widget build(BuildContext context) {
    return _buildCard(context);
  }
}
