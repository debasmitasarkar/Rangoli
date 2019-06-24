import 'package:flutter/material.dart';
import '../ui-elements/category-card.dart';
import '../models/rangoli-category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_admob/firebase_admob.dart';

class CategoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryScreenState();
  }
}

class _CategoryScreenState extends State<CategoryScreen> {
  final rangoliCategories = Firestore.instance.collection('rangoli-categories');
  final reference = Firestore.instance.collection('rangoli-categories');
  static const String testDevice = null;

  // static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //   testDevices: testDevice != null ? <String>[testDevice] : null,
  //   keywords: <String>['foo', 'bar'],
  //   contentUrl: 'http://foo.com/bar.html',
  //   birthday: DateTime.now(),
  //   childDirected: true,
  //   gender: MobileAdGender.male,
  //   nonPersonalizedAds: true,
  // );

  // BannerAd _bannerAd;

  // BannerAd createBannerAd() {
  //   return BannerAd(
  //     adUnitId: 'ca-app-pub-1734447714483073/7159602938',
  //     size: AdSize.banner,
  //     targetingInfo: targetingInfo,
  //     listener: (MobileAdEvent event) {
  //       print("BannerAd event $event");
  //     },
  //   );
  // }

  @override
  void initState() {
    super.initState();
    // FirebaseAdMob.instance
    //     .initialize(appId: 'ca-app-pub-1734447714483073/7159602938');
    // _bannerAd = createBannerAd()..load();
  }

  @override
  void dispose() {
    // _bannerAd?.dispose();
    super.dispose();
  }

  _buildCategoryCards() {
    // _bannerAd ??= createBannerAd();
    // _bannerAd
    //   ..load()
    //   ..show();

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildCard(),
        ]);
  }

  _buildCard() {
    return Expanded(
        child: new StreamBuilder(
            stream: rangoliCategories.snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Center(child: Text('Loading...'));
              return new ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.documents[index];
                    List<dynamic> images =
                        ds['images'] == null ? ds['image'] : ds['images'];
                    return CategoryCard(RangoliCategory(
                      category: ds['category'],
                      description: ds['description'],
                      images: images,
                    ));
                  });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rangoli Designs'),
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: _buildCategoryCards()),
    );
  }
}
