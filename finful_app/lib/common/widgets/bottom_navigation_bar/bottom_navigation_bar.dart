import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';

enum BottomNavigationBarItemType {
  lotties,
  rive,
  svg,
}

const _kTooltipBottomMargin = 8.0;
const _kActiveTitleSize = 12.0;
const _kTitleSize = 10.0;
const _kIconPadding = 4.0;
const _kTextSizeScaleDuration = 100; // miliseconds

class AppBottomNavBarItem {
  AppBottomNavBarItem({
    required this.assetPath,
    this.activeAssetPath,
    this.title,
    this.type = BottomNavigationBarItemType.lotties,
    this.riveAnimationName,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  }) : assert(
            type == BottomNavigationBarItemType.svg ||
                type == BottomNavigationBarItemType.lotties ||
                type == BottomNavigationBarItemType.rive &&
                    riveAnimationName != null,
            'Must provide at least one type'
            'and riveName can not be null');

  factory AppBottomNavBarItem.svg({
    required String assetPath,
    String? activeAssetPath,
    String? title,
    Color? activeColor,
    Color? inactiveColor,
  }) {
    return AppBottomNavBarItem(
      type: BottomNavigationBarItemType.svg,
      title: title,
      assetPath: assetPath,
      activeAssetPath: activeAssetPath,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
    );
  }

  factory AppBottomNavBarItem.lotties({
    required String assetPath,
    String? title,
    Color? activeColor,
    Color? inactiveColor,
  }) {
    return AppBottomNavBarItem(
      type: BottomNavigationBarItemType.lotties,
      title: title,
      assetPath: assetPath,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
    );
  }

  factory AppBottomNavBarItem.rive({
    required String assetPath,
    required String riveAnimationName,
    String? title,
    Color? activeColor,
    Color? inactiveColor,
  }) {
    return AppBottomNavBarItem(
      type: BottomNavigationBarItemType.rive,
      riveAnimationName: riveAnimationName,
      title: title,
      assetPath: assetPath,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
    );
  }

  final String? riveAnimationName;

  final String assetPath;

  final String? activeAssetPath;

  final String? title;

  final BottomNavigationBarItemType type;

  final Color? activeColor;

  final Color? inactiveColor;
}

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 32,
    this.backgroundColor,
    required this.items,
    required this.onItemSelected,
  })  : assert(
            items.length >= 2 && items.length <= 5,
            'items should has'
            'length from 2 to 5'),
        super(key: key);

  final int selectedIndex;

  final double iconSize;

  final Color? backgroundColor;

  final bool showElevation;

  final List<AppBottomNavBarItem> items;

  final ValueChanged<int> onItemSelected;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ??
        Theme.of(context).bottomAppBarTheme.color;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: items.map((item) {
              final index = items.indexOf(item);
              return _ItemWidget(
                key: ValueKey('bottom_navigation_bar_item_$index'),
                item: item,
                itemWidth: screenWidth / items.length,
                iconSize: iconSize,
                isSelected: index == selectedIndex,
                onItemPressed: () => onItemSelected(index),
                backgroundColor: bgColor,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatefulWidget {
  final double itemWidth;
  final double iconSize;
  final bool isSelected;
  final Color? backgroundColor;
  final AppBottomNavBarItem item;
  final VoidCallback? onItemPressed;

  const _ItemWidget(
      {Key? key,
      required this.itemWidth,
      required this.item,
      required this.isSelected,
      required this.iconSize,
      required this.onItemPressed,
      this.backgroundColor = Colors.transparent})
      : super(key: key);

  @override
  State<_ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<_ItemWidget>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  SimpleAnimation? _riveController;
  Artboard? _riveArtboard;

  @override
  void initState() {
    super.initState();
    if (widget.item.type == BottomNavigationBarItemType.rive) {
      _riveController = SimpleAnimation(
        widget.item.riveAnimationName!,
        autoplay: widget.isSelected,
      );
    } else {
      _controller = AnimationController(duration: Duration.zero, vsync: this);
      if (widget.isSelected) {
        _controller?.forward();
      }
    }
  }

  @override
  void dispose() {
    _riveController?.dispose();
    super.dispose();
  }

  void _resetRive() {
    _riveController?.reset();
    _riveController?.apply(_riveArtboard as RuntimeArtboard, 0);
    _riveController?.isActive = false;
  }

  Future<void> _playRive() async {
    if (_riveController?.isActive ?? true) {
      return;
    }
    _resetRive();
    _riveController?.isActive = true;
    await Future.delayed(
      const Duration(milliseconds: 20),
    );
    _riveController?.isActive = true;
  }

  void _onPressed() {
    widget.onItemPressed?.call();
    if (!widget.isSelected) {
      if (widget.item.type == BottomNavigationBarItemType.rive) {
        _playRive();
      }
      _controller?.reset();
      _controller?.forward();
    }
  }

  @override
  void didUpdateWidget(covariant _ItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSelected != widget.isSelected && !widget.isSelected) {
      _controller?.reset();
      if (widget.item.type == BottomNavigationBarItemType.rive) {
        _resetRive();
      }
    }
  }

  double get itemHeight =>
      widget.iconSize + _kActiveTitleSize + 2 * _kIconPadding;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.item.title,
      margin: const EdgeInsets.only(bottom: _kTooltipBottomMargin),
      child: GestureDetector(
        onTap: _onPressed,
        child: Container(
          color: widget.backgroundColor,
          height: itemHeight,
          width: widget.itemWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: _kIconPadding,
              ),
              if (widget.item.type == BottomNavigationBarItemType.rive)
                SizedBox(
                  width: widget.iconSize,
                  height: widget.iconSize,
                  child: RiveAnimation.asset(
                    widget.item.assetPath,
                    controllers: [
                      _riveController!,
                    ],
                    fit: BoxFit.cover,
                    onInit: (Artboard artboard) {
                      _riveArtboard = artboard;
                    },
                  ),
                ),
              if (widget.item.type == BottomNavigationBarItemType.lotties)
                Lottie.asset(
                  widget.item.assetPath,
                  controller: _controller,
                  width: widget.iconSize,
                  height: widget.iconSize,
                  fit: BoxFit.cover,
                  repeat: false,
                  onLoaded: (composition) {
                    _controller?.duration = composition.duration;
                  },
                ),
              if (widget.item.type == BottomNavigationBarItemType.svg)
                SizedBox(
                  width: widget.iconSize,
                  height: widget.iconSize,
                  child: SvgPicture.asset(
                    widget.isSelected
                        ? widget.item.activeAssetPath ?? widget.item.assetPath
                        : widget.item.assetPath,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(
                height: _kIconPadding,
              ),
              if (widget.item.title?.isNotEmpty ?? false)
                AnimatedDefaultTextStyle(
                  duration:
                      const Duration(milliseconds: _kTextSizeScaleDuration),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize:
                            widget.isSelected ? _kActiveTitleSize : _kTitleSize,
                        color: widget.isSelected
                            ? widget.item.activeColor
                            : widget.item.inactiveColor,
                        height: 1,
                      ),
                  child: DefaultTextStyle.merge(
                    maxLines: 1,
                    child: Text(widget.item.title!),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
