import 'package:finful_app/common/widgets/loadings/skeleton_loading.dart';
import 'package:flutter/material.dart';

class _Dot extends StatelessWidget {
  final Color? color;
  final double? radius;

  const _Dot({
    Key? key,
    @required this.color,
    @required this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      height: radius,
      width: radius,
    );
  }
}

const int _kNumberDots = 3;

class DotsLoading extends StatefulWidget {
  const DotsLoading({
    Key? key,
  }) : super(key: key);

  @override
  _DotsLoadingState createState() => _DotsLoadingState();
}

class _DotsLoadingState extends State<DotsLoading>
    with TickerProviderStateMixin {
  List<AnimationController>? _animationControllers;

  final List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    for (final controller in _animationControllers!) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initAnimation() {
    _animationControllers = List.generate(
      _kNumberDots,
      (index) {
        return AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
        );
      },
    ).toList();

    const double iHeight = -6;
    for (int i = 0; i < _kNumberDots; i++) {
      final ratio = i == 0 ? iHeight : iHeight + (iHeight * ((i + 1) * 1 / 10));
      _animations.add(Tween<double>(begin: 0, end: ratio)
          .animate(_animationControllers![i]));
    }

    for (int i = 0; i < _kNumberDots; i++) {
      _animationControllers![i].addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          if (mounted) {
            await _animationControllers![i].reverse();
          }
        }

        const iDuration = 50;
        await Future.delayed(Duration(milliseconds: iDuration * (i + 1)));
        if (i != _kNumberDots - 1 && status == AnimationStatus.forward) {
          if (mounted) {
            await _animationControllers![i + 1].forward();
          }
        }
        if (i == _kNumberDots - 1 && status == AnimationStatus.dismissed) {
          if (mounted) {
            await _animationControllers!.first.forward();
          }
        }
      });
    }

    if (mounted) {
      _animationControllers!.first.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_kNumberDots, (index) {
            return AnimatedBuilder(
              animation: _animationControllers![index],
              builder: (context, child) {
                return Container(
                  padding: const EdgeInsets.all(2),
                  child: Transform.translate(
                    offset: Offset(0, _animations[index].value),
                    child: SkeletonLoading.instance(
                      duration: const Duration(milliseconds: 1000),
                      color: Colors.white.withOpacity(0.7),
                      highLightColor: Colors.white,
                      child: const _Dot(
                        color: Colors.white,
                        radius: 6.0,
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
