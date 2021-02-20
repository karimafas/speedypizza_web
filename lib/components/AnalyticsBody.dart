import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/provider/analytics.dart';
import 'package:speedypizza_web/screens/AnalyticsScreen.dart';
import 'package:speedypizza_web/components/StatsHorizontalBar.dart';
import 'package:speedypizza_web/components/FadeIn.dart';

List buttonTimes = ["Oggi", "Ieri", "Ultima settimana", "Ultimo mese"];

class AnalyticsBody extends StatefulWidget {
  const AnalyticsBody({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _AnalyticsBodyState createState() => _AnalyticsBodyState();
}

class _AnalyticsBodyState extends State<AnalyticsBody>
    with TickerProviderStateMixin {
  Animation<Offset> toLeftAnimation;
  Animation<Offset> toRightAnimation;
  AnimationController animationController;

  bool hasAnimated = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    toLeftAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(6.5, 0))
        .animate(new CurvedAnimation(
            parent: animationController, curve: Curves.easeOutQuad));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double delay = 0;

    return Consumer<Analytics>(builder: (context, data, index) {
      return Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.7,
              height: 120,
              child: Stack(alignment: Alignment.center, children: [
                SlideTransition(
                  transformHitTests: true,
                  position: toLeftAnimation,
                  child: FloatingActionButton(
                      onPressed: () {
                        delay = 0;

                        if (data.hasClicked) {
                          animationController.reverse();
                        } else {
                          animationController.forward();
                        }

                        data.click();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: AnimatedSwitcher(
                          switchOutCurve: Curves.easeOutQuad,
                          switchInCurve: Curves.easeInQuad,
                          transitionBuilder: (widget, animation) =>
                              FadeTransition(
                            opacity: animation,
                            child: RotationTransition(
                              turns: animation,
                              child: widget,
                            ),
                          ),
                          duration: const Duration(milliseconds: 1000),
                          child: !data.hasClicked
                              ? Image.asset("images/clock.png")
                              : Image.asset("images/close.png"),
                        ),
                      ),
                      backgroundColor: Colors.black45),
                ),
                Positioned(
                  right: size.width * 0.20,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutQuad,
                    opacity: data.hasClicked ? 0 : 1,
                    child: Text(buttonTimes[data.selectedBtnIndex],
                        style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.left),
                  ),
                ),
                Visibility(
                  visible: data.hasClicked ? true : false,
                  child: SizedBox(
                    width: size.width * 0.5,
                    height: 40,
                    child: Center(
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: buttonTimes.length,
                        separatorBuilder: (context, index) {
                          return Container(width: 20);
                        },
                        itemBuilder: (context, index) {
                          delay += 0.2;

                          return TimeSpanButton(
                              delay: delay, data: data, thisIndex: index);
                        },
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Container(height: 50),
            SizedBox(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: categories.length,
                separatorBuilder: (context, index) {
                  return Container(height: 10);
                },
                itemBuilder: (context, index) {
                  return StatsHorizontalBar(
                      size: widget.size,
                      category: categories[index][0],
                      percentage: categories[index][1],
                      color: categories[index][2],
                      thisIndex: index);
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

class TimeSpanButton extends StatelessWidget {
  const TimeSpanButton({
    Key key,
    @required this.delay,
    this.data,
    this.thisIndex,
    this.tapped,
  }) : super(key: key);

  final double delay;
  final data;
  final int thisIndex;
  final Function tapped;

  @override
  Widget build(BuildContext context) {
    return SlideYFadeIn(
      delay,
      InkWell(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          Provider.of<Analytics>(context, listen: false).changeBtnIndex(thisIndex);
        },
        child: Stack(
          children: [
            Container(
              width: 130,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(buttonTimes[thisIndex],
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: data.selectedBtnIndex == thisIndex ? 1 : 0,
              child: Container(
                width: 130,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(buttonTimes[thisIndex],
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
