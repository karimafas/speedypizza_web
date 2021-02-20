import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speedypizza_web/provider/analytics.dart';

class StatsHorizontalBar extends StatelessWidget {
  const StatsHorizontalBar({
    Key key,
    @required this.size,
    this.color,
    this.percentage,
    this.category,
    this.thisIndex,
  }) : super(key: key);

  final Size size;
  final Color color;
  final double percentage;
  final String category;
  final int thisIndex;

  @override
  Widget build(BuildContext context) {
    return Consumer<Analytics>(builder: (context, data, index) {
      return InkWell(
        onTap: () {},
        onHover: (isHovering) {
          if(isHovering) {
            data.changeIndex(thisIndex);
          }
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusColor: Colors.transparent,
        child: Stack(alignment: Alignment.center, children: [
          Container(),
          Stack(children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                  borderRadius: BorderRadius.circular(10)),
              width: size.width * 0.5,
              height: 40,
            ),
            Positioned(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    width: (size.width * percentage) * 0.5,
                    height: 40,
                    decoration: BoxDecoration(
                        color: color.withOpacity(.5),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  Positioned(child:
                  AnimatedOpacity(
                    curve: Curves.easeOutQuad,
                    opacity: thisIndex == data.selectedIndex ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      width: (size.width * percentage) * 0.5,
                      height: 40,
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  )),
                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(category,
                          style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: 22,
                              fontStyle: FontStyle.italic)),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ]),
      );
    });
  }
}
