import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EasyAnimatedScroll extends StatefulWidget {
  final Duration topAnimationDuration, bottomAnimationDuration;
  final Curve topCurve, bottomCurve;
  final Widget child;
  final Widget? topWidget, bottomWidget;
  const EasyAnimatedScroll(
      {Key? key,
      required this.child,
      this.topWidget,
      this.bottomWidget,
      this.topAnimationDuration = const Duration(milliseconds: 500),
      this.bottomAnimationDuration = const Duration(milliseconds: 500),
      this.topCurve = Curves.linear,
      this.bottomCurve = Curves.linear})
      : super(key: key);

  @override
  State<EasyAnimatedScroll> createState() => _HPScrollAnimationState();
}

class _HPScrollAnimationState extends State<EasyAnimatedScroll> {
  final _topController = GlobalKey<_TopBarAnimationState>();
  final _bottomController = GlobalKey<_BottomBarAnimationState>();
  ScrollDirection _prevDirection = ScrollDirection.idle;

  bool _onAnimate(UserScrollNotification notification) {
    switch (notification.direction) {
      case ScrollDirection.forward:
        _prevDirection = ScrollDirection.forward;
        _animatedReverse();

        break;
      case ScrollDirection.reverse:
        _prevDirection = ScrollDirection.reverse;
        _animateForward();

        break;
      default:
        if (_prevDirection == ScrollDirection.reverse) {
          _animateForward();
        } else {
          _animatedReverse();
        }
    }

    return true;
  }

  _animateForward() {
    _topController.currentState?.animateForward();
    _bottomController.currentState?.animateForward();
  }

  _animatedReverse() {
    _topController.currentState?.animateReverse();
    _bottomController.currentState?.animateReverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: widget.bottomWidget != null
          ? _BottomBarAnimation(
              key: _bottomController,
              child: widget.bottomWidget!,
              animationCurve: widget.bottomCurve,
              animationDuration: widget.bottomAnimationDuration,
            )
          : null,
      body: NotificationListener<UserScrollNotification>(
        onNotification: _onAnimate,
        child: Column(
          children: [
            _TopBarAnimation(
                key: _topController,
                animationCurve: widget.topCurve,
                animationDuration: widget.topAnimationDuration,
                child: AppBar(
                  title: Text("Hammad"),
                )),
            Expanded(child: widget.child),
          ],
        ),
      ),
    );
  }
}

class _TopBarAnimation extends StatefulWidget {
  const _TopBarAnimation(
      {Key? key,
      required this.child,
      this.animationCurve = Curves.linear,
      this.animationDuration = const Duration(milliseconds: 500)})
      : super(key: key);
  final Widget child;
  final Duration animationDuration;
  final Curve animationCurve;
  @override
  State<_TopBarAnimation> createState() => _TopBarAnimationState();
}

class _TopBarAnimationState extends State<_TopBarAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: widget.animationDuration);
    _animation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: _controller, curve: widget.animationCurve));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  animateForward() => _controller.forward();
  animateReverse() => _controller.reverse();
  @override
  Widget build(BuildContext context) {
    return SizeTransition(sizeFactor: _animation, child: widget.child);
  }
}

class _BottomBarAnimation extends StatefulWidget {
  const _BottomBarAnimation(
      {Key? key,
      required this.child,
      this.animationCurve = Curves.linear,
      this.animationDuration = const Duration(milliseconds: 500)})
      : super(key: key);
  final Widget child;
  final Duration animationDuration;
  final Curve animationCurve;
  @override
  State<_BottomBarAnimation> createState() => _BottomBarAnimationState();
}

class _BottomBarAnimationState extends State<_BottomBarAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: widget.animationDuration);
    _animation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(parent: _controller, curve: widget.animationCurve));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  animateForward() => _controller.forward();
  animateReverse() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return SizeTransition(sizeFactor: _animation, child: widget.child);
  }
}
