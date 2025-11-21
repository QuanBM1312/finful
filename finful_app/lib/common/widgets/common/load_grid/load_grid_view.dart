import 'package:flutter/material.dart';

import '../../../../core/entity/entity.dart';
import '../../custom_slivers/sliver_grid_delegate_fixed_height.dart';
import '../grid_item_layout.dart';
import '../normal_enum.dart';

class LoadGridView<T extends BaseEntity> extends StatelessWidget {
  LoadGridView({
    super.key,
    required this.items,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.childAspectRatio,
    required this.shrinkWrap,
    required this.padding,
    required this.crossAxisCount,
    this.itemHeight,
    required this.isCustomGridDelegate,
    this.itemPlaceholderBuilder,
    this.itemBuilder,
    this.finiteBuilder,
  })  : assert(items.isNotEmpty, 'items can not empty');

  final List<T> items;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final int crossAxisCount;
  final bool shrinkWrap;
  final EdgeInsets padding;
  final double? itemHeight;
  final bool isCustomGridDelegate;
  final GridItemPlaceholderBuilder<T>? itemPlaceholderBuilder;
  final GridItemBuilder<T>? itemBuilder;
  final GridFiniteBuilder<T>? finiteBuilder;

  @override
  Widget build(BuildContext context) {
    if (finiteBuilder != null) {
      return GridView.count(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: shrinkWrap,
        padding: padding,
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio,
        children: finiteBuilder!(items),
      );
    }

    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: shrinkWrap,
      padding: padding,
      gridDelegate: isCustomGridDelegate
          ? SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: mainAxisSpacing,
              crossAxisSpacing: crossAxisSpacing,
              height: itemHeight,
            )
          : SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: mainAxisSpacing,
              crossAxisSpacing: crossAxisSpacing,
              childAspectRatio: childAspectRatio,
            ),
      itemCount: items.length,
      itemBuilder: (_, index) {
        final item = items[index];
        return itemPlaceholderBuilder != null
            ? GridItemLayout(
                placeHolder: itemPlaceholderBuilder!(item),
                child: itemBuilder != null
                    ? itemBuilder!(item, index)
                    : const SizedBox(),
              )
            : (itemBuilder != null
                ? itemBuilder!(item, index)
                : const SizedBox());
      },
    );
  }
}
