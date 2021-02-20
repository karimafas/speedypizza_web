import 'package:flutter/material.dart';
import 'package:speedypizza_web/components/FadeIn.dart';
import 'package:transparent_image/transparent_image.dart';
import '../navigation/routing_constants.dart';
import '../theme/style_constants.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
    this.selectedIndex,
  }) : super(key: key);
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: backgroundColor),
      child: Drawer(
        child: SlideFadeIn(
          0.3,
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                  child: DrawerHeader(
                      child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: "https://i.ibb.co/JyHDxWv/logo.png"))),
              ListTile(
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 0
                              ? Colors.deepPurpleAccent
                              : Colors.white,
                          BlendMode.srcIn),
                      child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: "https://i.imgur.com/NgJqkOa.png")),
                ),
                title: Text("Ordina",
                    style: TextStyle(
                        fontSize: 20,
                        color: selectedIndex == 0
                            ? Colors.deepPurpleAccent
                            : Colors.white)),
                onTap: () {
                  if (selectedIndex != 0) {
                    Navigator.pushReplacementNamed(context, HomeScreenRoute);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              SlideFadeIn(
                0.6,
                ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              selectedIndex == 1
                                  ? Colors.deepPurpleAccent
                                  : Colors.white,
                              BlendMode.srcIn),
                          child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: "https://i.imgur.com/sJXWlv4.png")),
                    ),
                    title: Text("Archivio",
                        style: TextStyle(
                            fontSize: 20,
                            color: selectedIndex == 1
                                ? Colors.deepPurpleAccent
                                : Colors.white)),
                    onTap: () {
                      if (selectedIndex != 1) {
                        Navigator.pushReplacementNamed(
                            context, ArchiveScreenRoute);
                      } else {
                        Navigator.pop(context);
                      }
                    }),
              ),
              SlideFadeIn(
                0.9,
                ListTile(
                    enabled: false,
                    leading: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              selectedIndex == 2
                                  ? Colors.deepPurpleAccent
                                  : Colors.grey,
                              BlendMode.srcIn),
                          child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: "https://i.imgur.com/F0ctPux.png")),
                    ),
                    title: Text("Statistiche",
                        style: TextStyle(
                            fontSize: 20,
                            color: selectedIndex == 2
                                ? Colors.deepPurpleAccent
                                : Colors.grey)),
                    onTap: () {
                      if (selectedIndex != 2) {
                        Navigator.pushReplacementNamed(
                            context, AnalyticsScreenRoute);
                      } else {
                        Navigator.pop(context);
                      }
                    }),
              ),
              SlideFadeIn(
                1.2,
                ListTile(
                    enabled: false,
                    leading: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              selectedIndex == 3
                                  ? Colors.deepPurpleAccent
                                  : Colors.grey,
                              BlendMode.srcIn),
                          child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: "https://i.imgur.com/TTO8xoa.png")),
                    ),
                    title: Text("Clienti",
                        style: TextStyle(
                            fontSize: 20,
                            color: selectedIndex == 3
                                ? Colors.deepPurpleAccent
                                : Colors.grey)),
                    onTap: () {
                      if (selectedIndex != 3) {
                        Navigator.pushReplacementNamed(context, CustomersRoute);
                      } else {
                        Navigator.pop(context);
                      }
                    }),
              ),
              SlideFadeIn(
                1.5,
                ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              selectedIndex == 4
                                  ? Colors.deepPurpleAccent
                                  : Colors.white,
                              BlendMode.srcIn),
                          child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: "https://i.imgur.com/6V5MwbO.png")),
                    ),
                    title: Text("Speedy Pony",
                        style: TextStyle(
                            fontSize: 20,
                            color: selectedIndex == 4
                                ? Colors.deepPurpleAccent
                                : Colors.white)),
                    onTap: () {
                      if (selectedIndex != 4) {
                        Navigator.pushReplacementNamed(
                            context, SpeedyPonyRoute);
                      } else {
                        Navigator.pop(context);
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
