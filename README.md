# Easy Scroll Animation

## Easy Scroll Animation lets you optionally (Size/Scale/Fade) your Topbar or Bottom Bar

You can now optionally hide TopBar or BottomBar, along with that You can set your Animation Type (default AnimationType.size)

![f3af61ac-539a-4ca9-935e-7bafe407d542](https://user-images.githubusercontent.com/33895363/164036173-cc3bdc60-b40d-4f2a-86b9-dd3653e95164.gif)

### Installation

#### Step 1:

```yml
easy_scroll_animation: <latest-version>
```

#### Step 2:

```dart
import 'package:easy_scroll_animation/easy_scroll_animation.dart';
```

#### Step 3: How to use

```dart
EasyAnimatedScroll(
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
```

##### Paramaters

<b> Scrolling Content </b>

- child (required)

<b> Bottom Bar Widget </b>

- bottomWidget (optional)
- animationType (default: AnimationType.size)
- bottomAnimationDuration (default: 500milliseconds)
- bottomCurve (defualt: linear)

<b> Top Bar Widget </b>

- topWidget (optional)
- animationType (default: AnimationType.size)
- topAnimationDuration (default: 500milliseconds)
- topCurve (defualt: linear)
