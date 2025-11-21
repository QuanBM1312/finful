import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../core/bloc/load_list/group.dart';
import '../../../../core/entity/entity.dart';
import '../../../../core/utils/cast_type.dart';
import '../../custom_slivers/sliver_grid_delegate_fixed_height.dart';
import '../grid_item_layout.dart';
import '../load_sliver_group_header.dart';
import '../sliver_enum.dart';

class LoadSliverGridView<T extends BaseEntity> extends StatelessWidget {
  LoadSliverGridView({
    Key? key,
    required this.items,
    required this.supportFlatGroup,
    required this.padding,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
    required this.childAspectRatio,
    required this.shrinkWrap,
    required this.crossAxisCount,
    this.itemHeight,
    required this.isCustomGridDelegate,
    this.itemPlaceholderBuilder,
    this.itemBuilder,
    this.groupItemBuilder,
    this.groupHeaderBuilder,
    this.groupItemPlaceholderBuilder,
  })  : assert(items.isNotEmpty, 'items can not empty'),
        super(key: key);

  final List<Object> items;
  final bool supportFlatGroup;
  final EdgeInsets padding;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;
  final int crossAxisCount;
  final bool shrinkWrap;
  final double? itemHeight;
  final bool isCustomGridDelegate;
  final SliverGridItemPlaceholderBuilder? itemPlaceholderBuilder;
  final SliverGridItemBuilder<T>? itemBuilder;
  final SliverGridGroupItemBuilder? groupItemBuilder;
  final SliverGroupHeaderBuilder? groupHeaderBuilder;
  final SliverGridGroupItemPlaceholderBuilder? groupItemPlaceholderBuilder;

  @override
  Widget build(BuildContext context) {
    if (supportFlatGroup) {
      assert(groupItemBuilder != null && groupHeaderBuilder != null,
          '''When you need flat group, you must provide 
          builder for group item in case support flat group''');
      final groups = asT<List<Group>>(items)!;
      final slivers = <Widget>[];
      for (int i = 0; i < groups.length; i++) {
        final listData = groups[i].list.toList();
        final widget = MultiSliver(
          children: <Widget>[
            SliverToBoxAdapter(
              child: LoadSliverGroupHeader(
                groups: groups,
                index: i,
                builder: (headerTitle, groups, index, {extraData}) =>
                    groupHeaderBuilder!(
                  headerTitle,
                  groups,
                  index,
                  extraData: extraData,
                ),
              ),
            ),
            if (listData.isNotEmpty)
              SliverPadding(
                padding: padding,
                sliver: SliverGrid(
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
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      final temp = listData[index];
                      final item = asT<BaseEntity>(temp)!;
                      return itemPlaceholderBuilder != null
                          ? GridItemLayout(
                              placeHolder: itemPlaceholderBuilder!(item),
                              child: groupItemBuilder != null
                                  ? groupItemBuilder!(item, index)
                                  : const SizedBox(),
                            )
                          : (groupItemBuilder != null
                              ? groupItemBuilder!(item, index)
                              : const SizedBox());
                    },
                    childCount: listData.length,
                  ),
                ),
              ),
          ],
        );
        slivers.add(widget);
      }

      return MultiSliver(
        children: slivers,
      );
    }

    final data = asT<List<T>>(items)!;
    return SliverPadding(
      padding: padding,
      sliver: SliverGrid(
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
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            final item = data[index];
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
          childCount: data.length,
        ),
      ),
    );
  }
}
