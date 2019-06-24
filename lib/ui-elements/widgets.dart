// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_scale_state.dart';
import 'sections.dart';
import 'dart:async';

const double kSectionIndicatorWidth = 32.0;

// The card for a single section. Displays the section's gradient and background image.
class SectionCard extends StatelessWidget {
  const SectionCard({Key key, @required this.section})
      : assert(section != null),
        super(key: key);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: section.title,
      button: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              section.leftColor,
              section.rightColor,
            ],
          ),
        ),
        child: Image.network(
          section.backgroundAsset,
          color: const Color.fromRGBO(255, 255, 255, 0.075),
          colorBlendMode: BlendMode.modulate,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// The title is rendered with two overlapping text widgets that are vertically
// offset a little. It's supposed to look sort-of 3D.
class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.section,
    @required this.scale,
    @required this.opacity,
  })  : assert(section != null),
        assert(scale != null),
        assert(opacity != null && opacity >= 0.0 && opacity <= 1.0),
        super(key: key);

  final Section section;
  final double scale;
  final double opacity;

  static const TextStyle sectionTitleStyle = TextStyle(
    fontFamily: 'Raleway',
    inherit: false,
    fontSize: 24.0,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    textBaseline: TextBaseline.alphabetic,
  );

  static final TextStyle sectionTitleShadowStyle = sectionTitleStyle.copyWith(
    color: const Color(0x19000000),
  );

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Opacity(
        opacity: opacity,
        child: Transform(
          transform: Matrix4.identity()..scale(scale),
          alignment: Alignment.center,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 4.0,
                child: Text(section.title.toUpperCase(),
                    style: sectionTitleShadowStyle),
              ),
              Text(section.title.toUpperCase(), style: sectionTitleStyle),
            ],
          ),
        ),
      ),
    );
  }
}

// Small horizontal bar that indicates the selected section.
class SectionIndicator extends StatelessWidget {
  const SectionIndicator({Key key, this.opacity = 1.0}) : super(key: key);

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: kSectionIndicatorWidth,
        height: 3.0,
        color: Colors.white.withOpacity(opacity),
      ),
    );
  }
}

// Display a single SectionDetail.
class SectionDetailView extends StatelessWidget {
  SectionDetailView({Key key, @required this.detail})
      : assert(detail != null && detail.imageAsset != null),
        assert((detail.imageAsset ?? detail.title) != null),
        super(key: key);

  final SectionDetail detail;
  ImageInfo _imageInfo;

  Future<ImageInfo> _getImage(String imageURL) {
    final Completer completer = Completer<ImageInfo>();
    ImageProvider imageProvider = NetworkImage(imageURL);
    final ImageStream stream =
        imageProvider.resolve(const ImageConfiguration());
    final ImageStreamListener listener =ImageStreamListener(
      (ImageInfo info, bool syncCall) {
      },
      onError: (dynamic error, StackTrace stackTrace) {
        print('ERROR caught by framework');
      },
    );
    //     var imageStreamListener = ImageStreamListener((ImageInfo info, bool synchronousCall) async{
    //   if (!completer.isCompleted) {
    //     completer.complete(info);
    //     //  setState(() {
    //     _imageInfo = info;
    //     // });
    //   }
    // }) ;
    stream.addListener(listener);
    completer.future.then((_) {
      stream.removeListener(listener);
    });
    return completer.future;
  }

  Widget _buildWithFuture(BuildContext context, String imageURL) {
    String image = imageURL;
    return FutureBuilder(
        future: _getImage(image),
        builder: (BuildContext context, AsyncSnapshot<ImageInfo> info) {
          if (info.hasData) {
            return _buildWrapper();
          } else {
            return buildLoading();
          }
        });
  }

  Widget _buildWrapper() {
    Widget image = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        image: DecorationImage(
          image: NetworkImage(
            detail.imageAsset,
          ),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
    );
    return image;
  }

  Widget buildLoading() {
    return Center(
      child: Container(
        height: 80.0,
        width: 80.0,
        child: Image.asset(
          'assets/rangoli_loader.gif',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget item;
    if (detail.title == null && detail.subtitle == null) {
      item = Container(
        color: Colors.white10,
        height: 240.0,
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          top: false,
          bottom: false,
          child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context,
                    '/rangoli/image/${detail.category}/${detail.index}');
              },
              //child: image,
              child: _buildWithFuture(context, detail.imageAsset)),
        ),
      );
    } else {
      item = ListTile(
        title: Text(detail.title),
        subtitle: Text(detail.subtitle),
        leading: SizedBox(width: 32.0, height: 32.0, child: _buildWrapper()),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.white),
      // decoration: BoxDecoration(color: Colors.red),

      child: item,
    );
  }
}
