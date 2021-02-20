import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/provider/archive.dart';
import 'package:speedypizza_web/theme/style_constants.dart';
import 'package:speedypizza_web/components/FadeIn.dart';

class OrderTracker extends StatefulWidget {
  const OrderTracker({
    Key key,
  }) : super(key: key);

  @override
  _OrderTrackerState createState() => _OrderTrackerState();
}

class _OrderTrackerState extends State<OrderTracker> {
  @override
  Widget build(BuildContext context) {
    double lDelay = 0;
    double rDelay = 0.5;

    return Consumer<Archive>(builder: (context, data, index) {
      int currentLeftIndex = 0;
      int currentRightIndex = 1;
      List<String> amLeftColumnTimes = ["10:00", "12:00", "14:00", "16:00"];
      List<String> amRightColumnTimes = ["11:00", "13:00", "15:00"];
      List<String> pmLeftColumnTimes = ["17:00", "19:00", "21:00", "23:00"];
      List<String> pmRightColumnTimes = ["18:00", "20:00", "22:00"];

      return SizedBox(
        key: data.orderTrackerKey,
        width: 260,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  width: 100,
                  height: 470,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      if (index != 0) {
                        lDelay += 1.5;
                        currentLeftIndex += 2;
                      }
                      return Column(
                        children: [
                          Container(height: 7),
                          SlideYFadeIn(
                              3.5,
                              Text(
                                 data.dinner
                                      ? pmLeftColumnTimes[index]
                                      : amLeftColumnTimes[index],
                                  style: TextStyle(color: Colors.grey))),
                          Container(height: 10),
                          SlideFadeInRTL(
                            lDelay,
                            AnimatedContainer(
                              duration: Duration(milliseconds: 400),
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: data.dinner
                                      ? darkGrey
                                      : Colors.black26,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: Text(
                                    data.timesSorted[currentLeftIndex] == 1
                                        ? data.timesSorted[currentLeftIndex]
                                                .toString() +
                                            " ordine"
                                        : data.timesSorted[currentLeftIndex]
                                                .toString() +
                                            " ordini",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    textAlign: TextAlign.end),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(height: 55);
                    },
                    itemCount: 4,
                    shrinkWrap: true,
                  ),
                ),
              ],
            ),
            LineWithDots(data: data),
            Column(
              children: [
                Container(height: 70),
                SizedBox(
                  width: 100,
                  height: 400,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      if (index != 0) {
                        rDelay += 1.5;
                        currentRightIndex += 2;
                      }
                      return Column(
                        children: [
                          SlideYFadeIn(
                              4,
                              Text(data.dinner
                                  ? pmRightColumnTimes[index]
                                  : amRightColumnTimes[index],
                                  style: TextStyle(color: Colors.grey))),
                          Container(height: 10),
                          SlideFadeIn(
                            rDelay,
                            AnimatedContainer(
                              duration: Duration(milliseconds: 400),
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: data.dinner
                                      ? darkGrey
                                      : Colors.black26,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: Text(
                                    data.timesSorted[currentRightIndex] == 1
                                        ? data.timesSorted[currentRightIndex]
                                                .toString() +
                                            " ordine"
                                        : data.timesSorted[currentRightIndex]
                                                .toString() +
                                            " ordini",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    textAlign: TextAlign.end),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(height: 65);
                    },
                    itemCount: 3,
                    shrinkWrap: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class LineWithDots extends StatelessWidget {
  const LineWithDots({
    Key key,
    this.data,
  }) : super(key: key);
  final data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 30),
        Stack(alignment: Alignment.topCenter, children: [
          FadeIn(
            2,
            AnimatedContainer(
                height: 405,
                width: 3,
                color: Colors.deepPurple,
                duration: Duration(seconds: 1),
                curve: Curves.easeOutQuad),
          ),
          Positioned(
              child: SlideYFadeIn(
            1,
            Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurpleAccent.withOpacity(0.5),
                      spreadRadius: 7,
                      blurRadius: 15,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                )),
          )),
          HourDot(delay: 2, margin: 130),
          HourDot(delay: 3, margin: 260),
          HourDot(delay: 4, margin: 390),
        ]),
      ],
    );
  }
}

class HourDot extends StatelessWidget {
  const HourDot({
    Key key,
    this.delay,
    this.margin,
  }) : super(key: key);
  final double delay;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: margin,
        child: SlideYFadeIn(
          delay,
          Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurpleAccent.withOpacity(0.5),
                    spreadRadius: 7,
                    blurRadius: 15,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              )),
        ));
  }
}
