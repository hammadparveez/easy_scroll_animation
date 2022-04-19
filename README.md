# Easy Scroll Animation

## Easy Scroll Animation is very simple to use

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
        bottomWidget: //(Optional) e.g: BottomNavigationBar , bottom Widget that you want to hide on scroll
        topWidget: topWidget  //(Optional) e.g Appbar , top widget that you want to hide on scroll
        child: yourScrollingWidget //e.g: ListView/ListView.builder or any other scrolling widget
    ),
```

##### Paramaters

<b> Scrolling Content </b>

- child (required)

<b> Bottom Bar Widget </b>

- bottomWidget (optional)
- bottomAnimationDuration (default: 500milliseconds)
- bottomCurve (defualt: linear)

<b> Top Bar Widget </b>

- topWidget (optional)
- topAnimationDuration (default: 500milliseconds)
- topCurve (defualt: linear)
