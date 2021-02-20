import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/provider/cart.dart';
import 'package:speedypizza_web/navigation/routing_constants.dart';
import 'package:speedypizza_web/screens/DetailsScreen.dart';
import 'package:speedypizza_web/theme/style_constants.dart';
import 'package:speedypizza_web/components/SpeedySeparator.dart';
import 'package:speedypizza_web/globals/globals.dart' as globals;
import 'package:speedypizza_web/components/FadeIn.dart';
import 'package:transparent_image/transparent_image.dart';
import '../provider/archive.dart';

class TimeAndDetails extends StatelessWidget {
  const TimeAndDetails({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> amColumnTimes = ["10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00"];
    List<String> pmColumnTimes = ["17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00"];
    double leftDelay = 0.5;
    double rightDelay = 1;
    bool isAm = true;
    TimeOfDay timeNow = TimeOfDay.now();

    String deliveryTimes(List ordersList, String time) {
      String times = "";
      List timesList = [];

      for(int i = 0; i < ordersList.length; i++) {
        timesList.add(ordersList[i][1]);
      }

      for(int i = 0; i < timesList.length; i++) {
        String specificTime = timesList[i].toString();

        if(specificTime.substring(0, 2) == time.substring(0,2)) {
          if(times.isEmpty) {
            times += timesList[i];
          }
          else {
            times += " | " + timesList[i];
          }
        }
      }

      return times;
    }

    return Consumer<Cart>(builder: (context, data, index) {
      if(double.parse(timeNow.format(context).substring(0,2)) <= 16) {
        isAm = true;
      }
      else {
        isAm = false;
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Consumer<Archive>(builder: (aContext, aData, aIndex) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isAm ? Colors.black26 : darkGrey,
                        borderRadius: BorderRadius.circular(100)
                      ),
                      height: 30,
                      width: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: isAm
                            ? "https://i.imgur.com/j31WSxG.png"
                            : "https://i.imgur.com/ILWu3ne.png"),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: SizedBox(
                          height: 220,
                          width: 60,
                          child: ListView.separated(
                              itemBuilder: (context, lIndex) {
                                if(lIndex != 0) {
                                  leftDelay += 0.5;
                                }
                                return SlideFadeInRTL(
                                  leftDelay, Text(
                                      isAm
                                          ? amColumnTimes[lIndex]
                                          : pmColumnTimes[lIndex],
                                      style: TextStyle(color: Colors.grey), textAlign: TextAlign.right),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Container(height: 15);
                              },
                              shrinkWrap: true,
                              itemCount: 7),
                        ),
                      ),
                      SlideYFadeInBottom(
                        3.5, Container(
                          width: 3,
                          height: 210,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurpleAccent.withOpacity(0.3),
                                spreadRadius: 3,
                                blurRadius: 15,
                                offset: Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: SizedBox(
                          width: 60,
                          height: 220,
                          child: ListView.separated(
                              itemBuilder: (context, rIndex) {
                                if(rIndex != 0) {
                                  rightDelay += 0.5;
                                }
                                return SlideFadeIn(
                                  rightDelay, Tooltip(
                                  margin: EdgeInsets.only(left: 100),
                                  verticalOffset: -10,
                                  message: deliveryTimes(globals.todaysList, pmColumnTimes[rIndex]),
                                    decoration: BoxDecoration(
                                      color: deliveryTimes(globals.todaysList, amColumnTimes[rIndex]) == ""
                                          ? Colors.transparent
                                          : Colors.deepPurple.withOpacity(.6),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    textStyle: TextStyle(fontSize: 16, color: Colors.white),
                                    child: Text(
                                        isAm
                                            ? aData.amDeliveryTimes[rIndex]
                                                    .toString() +
                                                " ordini"
                                            : aData.pmDeliveryTimes[rIndex]
                                                    .toString() +
                                                " ordini",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Container(height: 15);
                              },
                              shrinkWrap: true,
                              itemCount: 7),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
          Text("Orario di consegna:",
              style: TextStyle(color: Colors.white, fontSize: 17)),
          Container(height: 20),
          SizedBox(
            height: 70,
            width: 150,
            child: InkWell(
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              onHover: (isHovering) {
                if (isHovering) {
                  Provider.of<Cart>(context, listen: false)
                      .switchIsHovering(true);
                } else {
                  Provider.of<Cart>(context, listen: false)
                      .switchIsHovering(false);
                }
              },
              splashColor: Colors.transparent,
              onTap: () async {
                TimeOfDay picked = await showTimePicker(
                  context: context,
                  initialTime: data.deliveryTime,
                );
                Provider.of<Cart>(context, listen: false).setTime(picked);

                data.switchHasChosenTime(true);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeOutQuad,
                    opacity: data.isHovering ? 1 : 0,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple.withOpacity(.3),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0Xff202020),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 70,
                      width: 150,
                      child: Center(
                          child: Text(
                              data.hasChosenTime
                                  ? data.deliveryTime.format(context)
                                  : "Scegli...",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: !data.hasChosenTime ? 20 : 30))),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(height: 30),
          SpeedySeparator(width: 100),
          Container(height: 30),
          Text(globals.surname,
              style: TextStyle(color: Colors.white, fontSize: 18)),
          Container(height: 3),
          Text(globals.phone,
              style: TextStyle(color: Colors.grey, fontSize: 13)),
          Container(height: 3),
          Text(globals.address + ", " + globals.doorno,
              style: TextStyle(color: Colors.grey, fontSize: 13)),
          Container(height: 3),
          Text("Piano: " + globals.floor,
              style: TextStyle(color: Colors.grey, fontSize: 13)),
          Container(height: 20),
          ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, DetailsScreenRoute,
                    arguments: DetailsArgs(globals.phone, true, false, false));
              },
              child: Text(
                "Cambia dettagli...",
              ))
        ],
      );
    });
  }
}
