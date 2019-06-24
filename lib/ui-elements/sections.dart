// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Raw data for the animation demo.

import 'package:flutter/material.dart';
import './sections.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

// const Color _mariner = Color(0xFF3B5F8F);
// const Color _mediumPurple = Color(0xFF8266D4);
// const Color _tomato = Color(0xFFF95B57);
// const Color _mySin = Color(0xFFF3A646);

// const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

class SectionDetail {
  const SectionDetail(
      {this.title, this.subtitle, this.imageAsset, this.index, this.category});
  final String title;
  final String subtitle;
  final String imageAsset;
  final int index;
  final String category;
}

class Section {
  const Section({
    this.title,
    this.backgroundAsset,
    this.leftColor,
    this.rightColor,
    this.details,
  });
  final String title;
  final String backgroundAsset;
  final Color leftColor;
  final Color rightColor;
  final List<SectionDetail> details;

  @override
  bool operator ==(Object other) {
    if (other is! Section) return false;
    final Section otherSection = other;
    return title == otherSection.title;
  }

  @override
  int get hashCode => title.hashCode;
}

final List<Section> allSections = [];

// // TODO(hansmuller): replace the SectionDetail images and text. Get rid of
// // the const vars like _eyeglassesDetail and insert a variety of titles and
// // image SectionDetails in the allSections list.

// const SectionDetail _eyeglassesDetail = SectionDetail(
//   imageAsset: 'products/sunnies.png',
//   title: 'Flutter enables interactive animation',
//   subtitle: '3K views - 5 days',
// );

// const SectionDetail _eyeglassesImageDetail = SectionDetail(
//   imageAsset: 'http://www.4to40.com/wp-content/uploads/2016/10/diwali-diya.jpg',
// );

// const SectionDetail _seatingDetail = SectionDetail(
//   imageAsset: 'http://www.4to40.com/wp-content/uploads/2016/10/diwali-diya.jpg',
//   title: 'Flutter enables interactive animation',
//   subtitle: '3K views - 5 days',
// );

// const SectionDetail _seatingImageDetail = SectionDetail(
//   imageAsset: 'http://www.4to40.com/wp-content/uploads/2016/10/diwali-diya.jpg',
// );

// const SectionDetail _decorationDetail = SectionDetail(
//   imageAsset: 'http://www.4to40.com/wp-content/uploads/2016/10/diwali-diya.jpg',
//   title: 'Flutter enables interactive animation',
//   subtitle: '3K views - 5 days',
// );

// const SectionDetail _decorationImageDetail = SectionDetail(
//   imageAsset: 'http://www.4to40.com/wp-content/uploads/2016/10/diwali-diya.jpg',
// );

// const SectionDetail _protectionDetail = SectionDetail(
//   imageAsset: 'http://www.4to40.com/wp-content/uploads/2016/10/diwali-diya.jpg',
//   title: 'Flutter enables interactive animation',
//   subtitle: '3K views - 5 days',
// );

// const SectionDetail _protectionImageDetail = SectionDetail(
//   imageAsset: 'http://www.4to40.com/wp-content/uploads/2016/10/diwali-diya.jpg',
// );

// final List<Section> allSections = <Section>[
//   const Section(
//     title: 'SUNGLASSES',
//     leftColor: _mediumPurple,
//     rightColor: _mariner,
//     backgroundAsset:
//         'http://www.4to40.com/wp-content/uploads/2016/10/diwali-diya.jpg',
//     details: <SectionDetail>[
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//     ],
//   ),
//   const Section(
//     title: 'SUNGLASSES',
//     leftColor: _mediumPurple,
//     rightColor: _mariner,
//     backgroundAsset:
//         'http://www.4to40.com/wp-content/uploads/2016/10/diwali-diya.jpg',
//     details: <SectionDetail>[
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//     ],
//   ),
//   const Section(
//     title: 'SUNGLASSES',
//     leftColor: _mediumPurple,
//     rightColor: _mariner,
//     backgroundAsset:
//         'http://www.4to40.com/wp-content/uploads/2016/10/diwali-diya.jpg',
//     details: <SectionDetail>[
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//     ],
//   ),
//   const Section(
//     title: 'SUNGLASSES',
//     leftColor: _mediumPurple,
//     rightColor: _mariner,
//     backgroundAsset:
//         'http://www.4to40.com/wp-content/uploads/2016/10/diwali-diya.jpg',
//     details: <SectionDetail>[
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//     ],
//   ),
//   const Section(
//     title: 'SUNGLASSES',
//     leftColor: _mediumPurple,
//     rightColor: _mariner,
//     backgroundAsset:
//         'http://www.4to40.com/wp-content/uploads/2016/10/diwali-diya.jpg',
//     details: <SectionDetail>[
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//       _eyeglassesImageDetail,
//     ],
//   ),
// ];
