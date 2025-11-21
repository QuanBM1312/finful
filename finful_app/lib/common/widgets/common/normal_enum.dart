import 'package:flutter/material.dart';
import '../../../core/entity/entity.dart';

// --------- list --------- //
typedef ListRender<T extends BaseEntity> = Widget Function(List<T> items);
typedef ItemBuilder<T extends BaseEntity> = Widget Function(T item, int index);
typedef ItemSeparatorBuilder = Widget Function(int index);
typedef ItemPlaceholderBuilder<T extends BaseEntity> = Widget Function(T item);
typedef GroupItemBuilder<I extends BaseEntity> = Widget Function(
    I item, int index);
typedef GroupItemPlaceholderBuilder<I extends BaseEntity> = Widget Function(
    I item, int index);
typedef OnItemRemoved<T extends Object> = void Function(T removedItem);
typedef OnDataIsReady<T extends BaseEntity> = void Function(
    List<T> data, bool isRefreshed);
typedef ErrorBuilder = Widget Function(dynamic error);
// --------- * list * --------- //

// --------- common --------- //
typedef GroupHeaderBuilder = Widget Function(String? headerTitle,
    {Map<String, dynamic>? extraData});
// --------- * common * --------- //

// --------- grid --------- //
typedef GridRender<T extends BaseEntity> = Widget Function(List<T> items);
typedef GridFiniteBuilder<T extends BaseEntity> = List<Widget> Function(
    List<T> items);
typedef GridItemBuilder<T extends BaseEntity> = Widget Function(
    T item, int index);
typedef GridItemPlaceholderBuilder<T extends BaseEntity> = Widget Function(
    T item);
typedef OnGridItemRemoved<T extends BaseEntity> = void Function(T removedItem);
typedef OnGridDataIsReady<T extends BaseEntity> = void Function(
    List<T> data, bool isRefreshed);
typedef GridErrorBuilder = Widget Function(dynamic error);
// --------- * grid * --------- //
