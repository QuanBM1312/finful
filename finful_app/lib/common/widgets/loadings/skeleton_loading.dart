import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../core/utils/cast_type.dart';

enum SkeletonDirection { ltr, rtl, ttb, btt }

@immutable
class SkeletonLoading extends StatefulWidget {
  final Widget child;
  final SkeletonDirection direction;
  final Gradient gradient;
  final int loop;
  final bool enabled;
  final Duration? duration;

  const SkeletonLoading({
    super.key,
    required this.child,
    required this.gradient,
    this.direction = SkeletonDirection.ltr,
    this.loop = 0,
    this.enabled = true,
    this.duration,
  });

  SkeletonLoading.instance({
    super.key,
    required Color color,
    required Color highLightColor,
    this.direction = SkeletonDirection.ltr,
    required this.child,
    this.duration,
  })  : gradient = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            color,
            color,
            highLightColor,
            color,
            color,
          ],
          stops: const <double>[
            0.0,
            0.35,
            0.5,
            0.65,
            1.0,
          ],
        ),
        enabled = true,
        loop = 0;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Gradient>(
        'gradient',
        gradient,
        defaultValue: null,
      ))
      ..add(EnumProperty<SkeletonDirection>('direction', direction))
      ..add(DiagnosticsProperty<Duration>(
        'period',
        duration ?? const Duration(milliseconds: 1500),
        defaultValue: null,
      ))
      ..add(DiagnosticsProperty<bool>(
        'enabled',
        enabled,
        defaultValue: null,
      ))
      ..add(DiagnosticsProperty<int>(
        'loop',
        loop,
        defaultValue: 0,
      ));
  }

  @override
  _SkeletonLoadingState createState() => _SkeletonLoadingState();
}

class _SkeletonLoadingState extends State<SkeletonLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _count = 0;

  @override
  void initState() {
    super.initState();

    _count = 0;
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(milliseconds: 1500),
    )..addStatusListener((AnimationStatus status) {
        if (status != AnimationStatus.completed) {
          return;
        }

        _count++;
        if (widget.loop <= 0) {
          _controller.repeat();
        } else if (_count < widget.loop) {
          _controller.forward(from: 0.0);
        }
      });

    if (widget.enabled) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SkeletonLoading oldWidget) {
    if (widget.enabled) {
      _controller.forward();
    } else {
      _controller.stop();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) => _Skeleton(
        direction: widget.direction,
        gradient: widget.gradient,
        percent: _controller.value,
        child: child,
      ),
      child: widget.child,
    );
  }
}

@immutable
class _Skeleton extends SingleChildRenderObjectWidget {
  final double percent;
  final SkeletonDirection direction;
  final Gradient gradient;

  const _Skeleton({
    super.child,
    required this.percent,
    required this.direction,
    required this.gradient,
  });

  @override
  _SkeletonFilter createRenderObject(BuildContext context) {
    return _SkeletonFilter(
      percent,
      direction,
      gradient,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _SkeletonFilter _skeletonFilter,
  ) {
    _skeletonFilter.percent = percent;
    // ignore: cascade_invocations
    _skeletonFilter.gradient = gradient;
  }
}

class _SkeletonFilter extends RenderProxyBox {
  final SkeletonDirection _direction;
  Gradient _gradient;
  double _percent;

  _SkeletonFilter(
    this._percent,
    this._direction,
    this._gradient,
  );

  @override
  ShaderMaskLayer? get layer => asT<ShaderMaskLayer>(super.layer);

  @override
  bool get alwaysNeedsCompositing => child != null;

  set percent(double newValue) {
    if (newValue == _percent) {
      return;
    }
    _percent = newValue;
    markNeedsPaint();
  }

  set gradient(Gradient newValue) {
    if (newValue == _gradient) {
      return;
    }
    _gradient = newValue;
    markNeedsPaint();
  }

  double _offset(double start, double end, double percent) {
    return start + (end - start) * percent;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      assert(needsCompositing, '$runtimeType--Must provide child');

      final width = child!.size.width;
      final height = child!.size.height;
      Rect rect;
      double dx, dy;
      if (_direction == SkeletonDirection.rtl) {
        dx = _offset(width, -width, _percent);
        dy = 0.0;
        rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
      } else if (_direction == SkeletonDirection.ttb) {
        dx = 0.0;
        dy = _offset(-height, height, _percent);
        rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
      } else if (_direction == SkeletonDirection.btt) {
        dx = 0.0;
        dy = _offset(height, -height, _percent);
        rect = Rect.fromLTWH(dx, dy - height, width, 3 * height);
      } else {
        dx = _offset(-width, width, _percent);
        dy = 0.0;
        rect = Rect.fromLTWH(dx - width, dy, 3 * width, height);
      }
      layer ??= ShaderMaskLayer();
      layer!
        ..shader = _gradient.createShader(rect)
        ..maskRect = offset & size
        ..blendMode = BlendMode.srcIn;
      context.pushLayer(layer!, super.paint, offset);
    } else {
      layer = null;
    }
  }
}
