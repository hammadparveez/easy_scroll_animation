import 'package:easy_scroll_animation/easy_scroll_animation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EasyAnimatedScroll(
        topCurve: Curves.linear,
        bottomCurve: Curves.bounceOut,
        bottomAnimationDuration: const Duration(seconds: 1),
        topAnimationDuration: const Duration(seconds: 1),
        animationTopType: AnimationType.scale,
        animateBottomWidget: false,
        bottomWidget: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                label: "Home",
                icon: Icon(
                  Icons.home,
                )),
            BottomNavigationBarItem(
                label: "Location", icon: Icon(Icons.location_city)),
          ],
        ),
        topWidget: AppBar(title: Text("Welcome")),
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          itemBuilder: (_, index) => Text("hi $index"),
          itemCount: 500,
        ),
      ),
    );
  }
}
