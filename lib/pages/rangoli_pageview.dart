import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';

class RangoliPageView extends StatefulWidget {
  final String category;
  final int imageIndex;
  RangoliPageView({this.category, this.imageIndex});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RangoliPageViewState();
  }
}

class _RangoliPageViewState extends State<RangoliPageView> {
  bool isOriginalSize = true;
  String imageurl;
  _buildPageView() {
    final rangoliImages = Firestore.instance
        .collection('rangoli-categories')
        .where('category', isEqualTo: widget.category);
    return Container(
        child: StreamBuilder(
            stream: rangoliImages.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              return _buildPages(snapshot);
            }));
  }

  _buildPages(snapshot) {
    dynamic ds = snapshot.data.documents[0];
    List<dynamic> images = ds['images'] == null ? ds['image'] : ds['images'];
    return PageView.builder(
        itemCount: images.length,
        scrollDirection: Axis.horizontal,
        onPageChanged: (_) {},
        controller: PageController(
          initialPage: widget.imageIndex,
        ),
        physics: isOriginalSize == true
            ? ScrollPhysics()
            : NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          imageurl = images[index];

          return DecoratedBox(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.075),
                  backgroundBlendMode: BlendMode.modulate,
                  // color: const Color(0xff7c94b6),
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    image: new NetworkImage(
                      images[index],
                    ),
                  )),
              child: PhotoView(
                scaleStateChangedCallback: (scale) {
                  if (scale == PhotoViewScaleState.originalSize) {
                    setState(() {
                      isOriginalSize = true;
                    });
                  } else {
                    setState(() {
                      isOriginalSize = false;
                    });
                  }
                },
                imageProvider: NetworkImage(
                  images[index],
                ),
              )
              //  Image.network(
              //   section.backgroundAsset,
              //   color: const Color.fromRGBO(255, 255, 255, 0.075),
              //   colorBlendMode: BlendMode.modulate,
              //   fit: BoxFit.cover,
              // ),
              );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(
          'Designs',
          style: TextStyle(
              fontFamily: 'Raleway',
              inherit: false,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              textBaseline: TextBaseline.alphabetic),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                final RenderBox box = context.findRenderObject();
                Share.share(imageurl,
                    sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size);
              },
              icon: Icon(
                Icons.share,
                size: 25.0,
              ))
        ],
      ),
      body: Container(
        child: _buildPageView(),
      ),
      // floatingActionButton: FloatingActionButton(

      //   backgroundColor:
      //       Color.alphaBlend(Color(0xFF8266D4), Color(0xFF3B5F8F)),
      //   elevation: 4,
      //   onPressed: () {
      //     final RenderBox box = context.findRenderObject();
      //     Share.share(imageurl,
      //         sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      //   },
      //   child: Icon(
      //     Icons.share,
      //     size: 25.0,
      //   ),
      // )
    );
  }
}
