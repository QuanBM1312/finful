import 'package:finful_app/core/bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../../core/bloc/load_list/group.dart';
import '../../../../core/entity/entity.dart';
import '../../../../core/utils/cast_type.dart';
import '../load_item_layout.dart';
import '../normal_enum.dart';
import '../load_list_group_header.dart';

class LoadListView<T extends BaseEntity> extends StatelessWidget {
  final List<Object> items;
  final bool supportFlatGroup;
  final GroupItemBuilder? groupItemBuilder;
  final GroupHeaderBuilder? groupHeaderBuilder;
  final ItemSeparatorBuilder? itemSeparatorBuilder;
  final GroupItemPlaceholderBuilder? groupItemPlaceholderBuilder;
  final ItemPlaceholderBuilder<T>? itemPlaceholderBuilder;
  final ListRender<T>? listRender;
  final ItemBuilder<T>? itemBuilder;
  final bool shrinkWrap;
  final EdgeInsets padding;

  LoadListView({
    Key? key,
    required this.items,
    required this.supportFlatGroup,
    this.groupItemBuilder,
    this.groupHeaderBuilder,
    this.itemSeparatorBuilder,
    required this.shrinkWrap,
    required this.padding,
    this.groupItemPlaceholderBuilder,
    this.itemPlaceholderBuilder,
    this.listRender,
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
      if (itemSeparatorBuilder != null) {
        return ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: shrinkWrap,
          padding: padding,
          itemCount: groups.totalItemWithHeader(),
          separatorBuilder: (_, index) => itemSeparatorBuilder!(index),
          itemBuilder: (_, index) {
            if (groups.isGroupHeader(index: index)) {
              return LoadListGroupHeader(
                groups: groups,
                index: index,
                builder: (headerTitle, {extraData}) => groupHeaderBuilder!(
                  headerTitle,
                  extraData: extraData,
                ),
              );
            }
            final item = groups.groupItem(index: index);
            if (item != null) {
              return groupItemPlaceholderBuilder != null
                  ? ListItemLayout(
                      placeHolder: groupItemPlaceholderBuilder!(item, index),
                      child: groupItemBuilder != null
                          ? groupItemBuilder!(item, index)
                          : const SizedBox(),
                    )
                  : (groupItemBuilder != null
                      ? groupItemBuilder!(item, index)
                      : const SizedBox());
            }

            return const SizedBox();
          },
        );
      }

      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: shrinkWrap,
        padding: padding,
        itemCount: groups.totalItemWithHeader(),
        itemBuilder: (_, index) {
          if (groups.isGroupHeader(index: index)) {
            return LoadListGroupHeader(
              groups: groups,
              index: index,
              builder: groupHeaderBuilder!,
            );
          }
          final item = groups.groupItem(index: index);
          if (item != null) {
            return groupItemPlaceholderBuilder != null
                ? ListItemLayout(
                    placeHolder: groupItemPlaceholderBuilder!(item, index),
                    child: groupItemBuilder != null
                        ? groupItemBuilder!(item, index)
                        : const SizedBox(),
                  )
                : (groupItemBuilder != null
                    ? groupItemBuilder!(item, index)
                    : const SizedBox());
          }

          return const SizedBox();
        },
      );
    }

    final data = asT<List<T>>(items)!;

    if (itemSeparatorBuilder != null) {
      return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: shrinkWrap,
        padding: padding,
        itemCount: data.length,
        separatorBuilder: (_, index) => itemSeparatorBuilder!(index),
        itemBuilder: (_, index) {
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
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemCount: items.length,
      itemBuilder: (_, index) {
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
    );
  }
}
