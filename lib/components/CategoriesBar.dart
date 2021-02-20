import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'MenuView.dart';

List categoriesItems = [
  ["Pizze", "https://i.ibb.co/kQzQ2yr/pizza.png"],
  ["Panini", "https://i.ibb.co/mDMXd6n/burger.png"],
  ["Antipasti", "https://i.ibb.co/18g6K9L/starter.png"],
  ["Primi piatti", "https://i.ibb.co/n8V3dC2/spaghetti.png"],
  ["Snack", "https://i.ibb.co/hL4pw7F/fries.png"],
  ["Dessert", "https://i.ibb.co/YtsS2tD/dessert.png"],
  ["Bevande", "https://i.ibb.co/vB09vFS/drink.png"],
  ["Variazioni", "https://i.ibb.co/XSGN01y/variations.png"],
];

class CategoriesBar extends StatefulWidget {
  const CategoriesBar({
    Key key, this.viewController,
  }) : super(key: key);
  final PageController viewController;

  @override
  _CategoriesBarState createState() => _CategoriesBarState();
}

class _CategoriesBarState extends State<CategoriesBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        separatorBuilder: (context, index) => Container(
          width: 30,
          height: 100,
          color: Colors.transparent,
        ),
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) {
          return Category(
              name: categoriesItems[index][0],
              image: categoriesItems[index][1],
              selected: selectedIndex == index ? true : false,
              pressed: () {
                setState(() {
                  selectedIndex = index;
                  widget.viewController.animateToPage(index,
                      duration: Duration(milliseconds: 1),
                      curve: Curves.easeOutQuad);
                });
              });
        },
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
      ),
      height: 80,
    );
  }
}

class Category extends StatelessWidget {
  const Category({
    Key key,
    this.image,
    this.name,
    this.pressed,
    this.selected,
  }) : super(key: key);
  final String image;
  final String name;
  final Function pressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: pressed,
      child: SizedBox(
        width: 70,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 20, height: 20, child: FadeInImage.memoryNetwork(image: image, placeholder: kTransparentImage)),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(name,
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
            AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: selected ? 1 : 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                    width: 35,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(.5),
                          spreadRadius: 1.5,
                          blurRadius: 10,
                          offset: Offset(0, -7), // changes position of shadow
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}