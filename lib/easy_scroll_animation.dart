import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum AnimationType { scale, size, fade }

class EasyAnimatedScroll extends StatefulWidget {
  final Duration topAnimationDuration, bottomAnimationDuration;
  final Curve topCurve, bottomCurve;
  final Widget child;
  final Widget? topWidget, bottomWidget;
  final bool animateTopWidget, animateBottomWidget;
  final AnimationType animationTopType, animationBottomType;
  const EasyAnimatedScroll(
      {Key? key,
      required this.child,
      this.topWidget,
      this.bottomWidget,
      this.animateTopWidget = true,
      this.animateBottomWidget = true,
      this.animationTopType = AnimationType.size,
      this.animationBottomType = AnimationType.size,
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
    if (widget.animateTopWidget) {
      _topController.currentState?.animateForward();
    }
    if (widget.animateBottomWidget) {
      _bottomController.currentState?.animateForward();
    }
  }

  _animatedReverse() {
    if (widget.animateTopWidget) {
      _topController.currentState?.animateReverse();
    }
    if (widget.animateBottomWidget) {
      _bottomController.currentState?.animateReverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: widget.bottomWidget != null
          ? _BottomBarAnimation(
              animationType: widget.animationBottomType,
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
            if (widget.topWidget != null)
              _TopBarAnimation(
                animationType: widget.animationTopType,
                key: _topController,
                animationCurve: widget.topCurve,
                animationDuration: widget.topAnimationDuration,
                child: widget.topWidget!,
              ),
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
      this.animationType = AnimationType.size,
      this.animationDuration = const Duration(milliseconds: 500)})
      : super(key: key);
  final Widget child;
  final Duration animationDuration;
  final Curve animationCurve;
  final AnimationType animationType;
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
    if (widget.animationType == AnimationType.scale) {
      return ScaleTransition(scale: _animation, child: widget.child);
    } else if (widget.animationType == AnimationType.fade) {
      return FadeTransition(opacity: _animation, child: widget.child);
    } else {
      return SizeTransition(sizeFactor: _animation, child: widget.child);
    }
  }
}

class _BottomBarAnimation extends StatefulWidget {
  const _BottomBarAnimation(
      {Key? key,
      required this.child,
      this.animationCurve = Curves.linear,
      this.animationType = AnimationType.size,
      this.animationDuration = const Duration(milliseconds: 500)})
      : super(key: key);
  final Widget child;
  final Duration animationDuration;
  final Curve animationCurve;
  final AnimationType animationType;
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
    if (widget.animationType == AnimationType.scale) {
      return ScaleTransition(scale: _animation, child: widget.child);
    } else if (widget.animationType == AnimationType.fade) {
      return FadeTransition(opacity: _animation, child: widget.child);
    } else {
      return SizeTransition(sizeFactor: _animation, child: widget.child);
    }
  }
}
