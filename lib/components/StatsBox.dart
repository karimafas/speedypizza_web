import 'package:flutter/material.dart';
import 'package:speedypizza_web/theme/style_constants.dart';
import 'package:speedypizza_web/components/FadeIn.dart';
import 'package:transparent_image/transparent_image.dart';

class StatsBox2 extends StatelessWidget {
  const StatsBox2({
    Key key, this.imageUrl, this.stat1Key, this.stat2Key, this.stat1Value, this.stat2Value, this.statsKey, this.delay,
  }) : super(key: key);
  final String imageUrl;
  final String stat1Key;
  final String stat2Key;
  final String stat1Value;
  final String stat2Value;
  final Key statsKey;
  final double delay;

  @override
  Widget build(BuildContext context) {
    return SlideYFadeInBottom(
      2, Container(
        key: statsKey,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: darkGrey,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 15,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SlideYFadeInBottom(
              delay * 2.3, Padding(
              padding: const EdgeInsets.all(35.0),
              child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: imageUrl),
            ),
            ),
            SlideYFadeInBottom(
              delay * 2.6, Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(stat1Key, style: TextStyle(color: Colors.grey, fontSize: 18)),
                Container(height: 10),
                Text(stat2Key, style: TextStyle(color: Colors.grey, fontSize: 18)),
              ],
            ),
            ),
            Container(width: 25),
            SlideYFadeInBottom(
              delay * 3, Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(stat1Value, style: TextStyle(color: Colors.white, fontSize: 18)),
                Container(height: 10),
                Text(stat2Value, style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
            ),
            Container(width: 30),
          ],
        ),
      ),
    );
  }
}