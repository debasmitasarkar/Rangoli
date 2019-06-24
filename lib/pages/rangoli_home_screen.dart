import 'package:flutter/material.dart';
import '../ui-elements/category-card.dart';
import '../models/rangoli-category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import '../ui-elements/sections.dart';
import '../ui-elements/home.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final rangoliCategories = Firestore.instance.collection('rangoli-categories');
  final reference = Firestore.instance.collection('rangoli-categories');
  static const String testDevice = null;
  final List<Section> allSections = <Section>[];

  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    birthday: DateTime.now(),
    childDirected: true,
    gender: MobileAdGender.unknown,
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: 'ca-app-pub-1734447714483073/7159602938',
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

//   MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//   keywords: <String>['flutterio', 'beautiful apps'],
//   contentUrl: 'https://flutter.io',
//   nonPersonalizedAds: true,
//   childDirected: false,
// );

// BannerAd myBanner = BannerAd(
//   // Replace the testAdUnitId with an ad unit id from the AdMob dash.
//   // https://developers.google.com/admob/android/test-ads
//   // https://developers.google.com/admob/ios/test-ads
//   adUnitId: BannerAd.testAdUnitId,
//   size: AdSize.smartBanner,
//   targetingInfo: targetingInfo,
//   listener: (MobileAdEvent event) {
//     print("BannerAd event is $event");
//   },
// );

  @override
  void initState() {
    super.initState();

    FirebaseAdMob.instance
        .initialize(appId: 'ca-app-pub-1734447714483073/7159602938');
    _bannerAd = createBannerAd()..load();
  }

  @override
  void dispose() {
    // _bannerAd?.dispose();
    super.dispose();
  }

  _buildCategoryCards() {
    _bannerAd ??= createBannerAd();
    _bannerAd
      ..load()
      ..show(
        anchorOffset: 60.0,
        anchorType: AnchorType.bottom,
      );

    _buildSections();
    return AnimationDemoHome();
  }

  _buildSectionDetails(List<dynamic> images) {
    List<SectionDetail> sectionDetails;
    images.forEach((image) {
      sectionDetails.add(SectionDetail(imageAsset: image));
    });
    return sectionDetails;
  }

  _buildSections() {
    StreamBuilder(
        stream: rangoliCategories.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: Text('Loading...'));
          return new ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.documents[index];
                List<dynamic> images =
                    ds['images'] == null ? ds['image'] : ds['images'];
                allSections.add(Section(
                  title: 'ds[category]',
                  leftColor: Colors.redAccent,
                  rightColor: Colors.pinkAccent,
                  backgroundAsset: images[0],
                  details: <SectionDetail>[_buildSectionDetails(images)],
                ));
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildCategoryCards();
  }
}
