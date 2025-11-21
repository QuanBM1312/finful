import 'package:flutter/material.dart';

import '../../../core/bloc/load_list/group.dart';
import '../../../core/entity/entity.dart';

// --------- sliver list --------- //
typedef SliverGroupItemPlaceholderBuilder<I extends BaseEntity> = Widget
    Function(I item);
typedef SliverListRender<T extends BaseEntity> = Widget Function(List<T> items);
typedef SliverItemBuilder<T extends BaseEntity> = Widget Function(
    T item, int index);
typedef SliverItemPlaceholderBuilder<T extends BaseEntity> = Widget Function(
    T item);
typedef SliverGroupItemBuilder<I extends BaseEntity> = Widget Function(
    I item, int index);
typedef OnSliverItemRemoved<T extends Object> = void Function(T removedItem);
typedef OnSliverDataIsReady<T extends BaseEntity> = void Function(
    List<T> data, bool isRefreshed);
typedef SliverErrorBuilder = Widget Function(dynamic error);
// --------- * sliver list * --------- //

// --------- sliver common --------- //
typedef SliverGroupHeaderBuilder = Widget Function(
    String headerTitle, List<Group<Object>> groups, int index,
    {Map<String, dynamic>? extraData});
// --------- * sliver common * --------- //

// --------- sliver grid --------- //
typedef SliverGridRender<T extends BaseEntity> = Widget Function(List<T> items);
typedef SliverGridItemBuilder<T extends BaseEntity> = Widget Function(
    T item, int index);
typedef SliverGridItemPlaceholderBuilder<T extends BaseEntity> = Widget
    Function(T item);
typedef OnSliverGridItemRemoved<T extends BaseEntity> = void Function(
    T removedItem);
typedef OnSliverGridDataIsReady<T extends BaseEntity> = void Function(
    List<T> data, bool isRefreshed);
typedef SliverGridErrorBuilder = Widget Function(dynamic error);
typedef SliverGridGroupItemBuilder<I extends BaseEntity> = Widget Function(
    I item, int index);
typedef SliverGridGroupItemPlaceholderBuilder<I extends BaseEntity> = Widget
    Function(I item);
// --------- * sliver grid * --------- //
