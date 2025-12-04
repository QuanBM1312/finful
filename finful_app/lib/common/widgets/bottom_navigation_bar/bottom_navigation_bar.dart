import 'package:finful_app/app/theme/theme.dart';
import 'package:finful_app/common/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum BottomNavigationBarItemType {
  svg,
}

const _kTooltipBottomMargin = 8.0;
const _kActiveTitleSize = 12.0;
const _kTitleSize = 10.0;
const _kIconPadding = 8.0;
const _kTextSizeScaleDuration = 100; // miliseconds

class AppBottomNavBarItem {
  AppBottomNavBarItem({
    required this.assetPath,
    this.activeAssetPath,
    this.title,
    this.type = BottomNavigationBarItemType.svg,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  }) : assert(
  type == BottomNavigationBarItemType.svg,
  'Must provide at least one type');

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

  final String assetPath;

  final String? activeAssetPath;

  final String? title;

  final BottomNavigationBarItemType type;

  final Color? activeColor;

  final Color? inactiveColor;
}

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 32,
    this.backgroundColor,
    required this.items,
    required this.onItemSelected,
  })  : assert(
  items.length >= 2 && items.length <= 5,
  'items should has'
      'length from 1 to 3');

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
            BoxShadow(
              color: FinfulColor.tabBarElevationColor,
              blurRadius: 1.0,
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

  const _ItemWidget({
    super.key,
    required this.itemWidth,
    required this.item,
    required this.isSelected,
    required this.iconSize,
    required this.onItemPressed,
    this.backgroundColor = Colors.transparent,
  });

  @override
  State<_ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<_ItemWidget> {

  void _onPressed() {
    widget.onItemPressed?.call();
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
                height: Dimens.p_4,
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
                height: Dimens.p_4,
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
