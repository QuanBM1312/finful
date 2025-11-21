import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../core/bloc/load_list/group.dart';
import '../../../../core/entity/entity.dart';
import '../../../../core/utils/cast_type.dart';
import '../load_item_layout.dart';
import '../load_sliver_group_header.dart';
import '../sliver_enum.dart';

class LoadSliverListView<T extends BaseEntity> extends StatelessWidget {
  final List<Object> items;
  final EdgeInsets padding;
  final bool supportFlatGroup;
  final SliverGroupHeaderBuilder? groupHeaderBuilder;
  final SliverGroupItemBuilder? groupItemBuilder;
  final SliverGroupItemPlaceholderBuilder? groupItemPlaceholderBuilder;
  final SliverItemPlaceholderBuilder<T>? itemPlaceholderBuilder;
  final SliverItemBuilder<T>? itemBuilder;

  LoadSliverListView({
    Key? key,
    required this.items,
    required this.padding,
    required this.supportFlatGroup,
    this.groupHeaderBuilder,
    this.groupItemBuilder,
    this.groupItemPlaceholderBuilder,
    this.itemPlaceholderBuilder,
    this.itemBuilder,
  })  : assert(items.isNotEmpty, 'items can not empty'),
        super(key: key);

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
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      final item = listData[index];
                      final fItem = asT<BaseEntity>(item)!;
                      return groupItemPlaceholderBuilder != null
                          ? ListItemLayout(
                              placeHolder: groupItemPlaceholderBuilder!(fItem),
                              child: groupItemBuilder != null
                                  ? groupItemBuilder!(fItem, index)
                                  : const SizedBox(),
                            )
                          : (groupItemBuilder != null
                              ? groupItemBuilder!(fItem, index)
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
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            final item = data[index];
            return itemPlaceholderBuilder != null
                ? ListItemLayout(
                    placeHolder: itemPlaceholderBuilder!(item),
                    child: itemBuilder != null
                        ? itemBuilder!(item, index)
                        : const SizedBox(),
                  )
                : (itemBuilder != null
                    ? itemBuilder!(item, index)
                    : const SizedBox());
          },
          childCount: items.length,
        ),
      ),
    );
  }
}
