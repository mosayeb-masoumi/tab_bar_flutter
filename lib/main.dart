// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tabs',
      home: tabs(),
    );
  }
}

class tabs extends StatefulWidget {
  @override
  _tabsState createState() => _tabsState();
}

class _tabsState extends State<tabs> with SingleTickerProviderStateMixin {
  List list_name = ["Most Selling", "Burger", "Pizza", "Chicken", "Eggs"];
  SwiperController _scrollController = new SwiperController();
  TabController tabController;

  int currentIndex2 = 0; // for swiper index initial
  int selectedIndex = 0; // for tab

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      initialIndex: selectedIndex,
      length: list_name.length,
      vsync: this,
    );

    tabController.addListener(() {
      setState(() {
        print(tabController.index);
        _scrollController.move(tabController.index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: list_name.length,
        child: Scaffold(
          body: Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 50),
                  height: 120,
                  child: DefaultTabController(
                    length: list_name.length,
                    child: Container(
                      constraints: BoxConstraints(maxHeight: 35),
                      child: Material(
                        child: TabBar(
                          onTap: (index) => _scrollController.move(index),
                          controller: tabController,
                          isScrollable: true,
                          indicatorColor: Color.fromRGBO(0, 202, 157, 1),
                          labelColor: Colors.black,
                          labelStyle: TextStyle(fontSize: 12),
                          unselectedLabelColor: Colors.black,
                          tabs: List.generate(list_name.length, (index) {
                            return new Tab(text: list_name[index]);
                          }),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: new Swiper(
                    onIndexChanged: (index) {
                      setState(() {
                        selectedIndex = index;
                        tabController.animateTo(index);
                        currentIndex2 = index;
                        print(index);
                      });
                    },
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                        tabController.animateTo(index);
                        currentIndex2 = index;
                        print(index);
                      });
                    },
                    duration: 2,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return new Swiper(
                        duration: 2,
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return VisibilityDetector(
                            key: Key(index.toString()),
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              height: 500,
                              width: double.infinity,
                              color: Colors.blue,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    list_name[index],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onVisibilityChanged: (VisibilityInfo info) {
                              if (info.visibleFraction == 1)
                                setState(() {
                                  selectedIndex = index;
                                  tabController.animateTo(index);
                                  currentIndex2 = index;
                                  print(index);
                                });
                            },
                          );
                        },
                        itemCount: list_name.length,
                      );
                    },
                    itemCount: list_name.length,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
