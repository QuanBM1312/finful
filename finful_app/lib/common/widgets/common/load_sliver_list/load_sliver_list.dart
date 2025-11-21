import 'dart:collection';

import 'package:finful_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/bloc/base/bloc_manager.dart';
import '../../../../core/bloc/load_list/constants.dart';
import '../../../../core/bloc/load_list/load_list_bloc.dart';
import '../../../../core/bloc/load_list/load_list_event.dart';
import '../../../../core/bloc/load_list/load_list_state.dart';
import '../../../../core/entity/entity.dart';
import '../../../../core/exception/api_exception.dart';
import '../../../../core/mixin/widget_didmount_mixin.dart';
import '../../../../core/utils/cast_type.dart';
import '../../../constants/dimensions.dart';
import '../../loadings/dots_loading.dart';
import '../row_column.dart';
import '../sliver_enum.dart';
import 'load_sliver_list_view.dart';

class LoadSliverList<T extends BaseEntity> extends StatefulWidget {
  LoadSliverList({
    Key? key,
    required this.blocKey,
    required this.scrollController,
    required this.emptyWidget,
    required this.errorWidget,
    this.listRender,
    this.itemBuilder,
    this.onItemRemoved,
    this.itemPlaceholderBuilder,
    this.groupHeaderBuilder,
    this.groupItemBuilder,
    this.groupItemPlaceholderBuilder,
    this.loadingWidget,
    this.onDataIsReady,
    this.padding = const EdgeInsets.all(Dimens.p_16),
    this.supportFlatGroup = false,
    this.params,
    this.needRefresh = true,
    this.needLoadMore = true,
    this.autoStart = false,
    this.shouldDelayStart = false,
  }) : super(key: key);

  final Key blocKey;
  final ScrollController scrollController;
  final SliverListRender<T>? listRender;
  final SliverItemBuilder<T>? itemBuilder;
  final OnSliverItemRemoved<T>? onItemRemoved;
  final SliverItemPlaceholderBuilder<T>? itemPlaceholderBuilder;
  final SliverGroupHeaderBuilder? groupHeaderBuilder;
  final SliverGroupItemBuilder? groupItemBuilder;
  final SliverGroupItemPlaceholderBuilder? groupItemPlaceholderBuilder;
  final OnSliverDataIsReady<T>? onDataIsReady;
  final EdgeInsets padding;
  final Widget? emptyWidget;
  final SliverErrorBuilder errorWidget;
  final Widget? loadingWidget;
  final bool supportFlatGroup;
  final Map<String, dynamic>? params;
  final bool autoStart;
  final bool shouldDelayStart;
  final bool needLoadMore;
  final bool needRefresh;

  @override
  State<StatefulWidget> createState() {
    return _LoadSliverListState<T>();
  }
}

class _LoadSliverListState<T extends BaseEntity>
    extends State<LoadSliverList<T>> with WidgetDidMount<LoadSliverList<T>> {
  /// Maps [row, column] indices to the visibility percentage of the
  /// corresponding [VisibilityDetector] widget.
  final ValueNotifier<SplayTreeMap<RowColumn, double>> _visibilities =
      ValueNotifier(SplayTreeMap<RowColumn, double>());
  final ValueNotifier<bool> _shouldBlockListenScroll = ValueNotifier(false);
  final ValueNotifier<bool> _isPreloading = ValueNotifier(false);
  final ValueNotifier<bool> _isRefreshing = ValueNotifier(false);
  late bool _needLoadMore;

  @override
  void initState() {
    _needLoadMore = widget.needLoadMore && !widget.supportFlatGroup;
    super.initState();
    visibilityListeners.add(_update);
    assert(visibilityListeners.contains(_update), 'Make sure can listener');
  }

  @override
  void widgetDidMount(BuildContext context) {
    final loadListBloc =
        BlocManager().blocFromKey<LoadListBloc<T>>(widget.blocKey);
    if (loadListBloc != null) {
      final state = loadListBloc.state;
      if (state is LoadListLoadPageSuccess && widget.onDataIsReady != null) {
        widget.onDataIsReady!(asT<List<T>>(state.items)!, _isRefreshing.value);
      } else if (state is LoadListInitial && widget.autoStart) {
        loadListBloc.start(
          shouldDelayStart: widget.shouldDelayStart,
          params: widget.params,
        );
      }
    }
  }

  @override
  void dispose() {
    visibilityListeners.remove(_update);
    super.dispose();
  }

  Future<void> _update(RowColumn rc, VisibilityInfo info) async {
    final loadListBloc =
        BlocManager().blocFromKey<LoadListBloc<T>>(widget.blocKey);
    if (loadListBloc == null) {
      return;
    }

    if (!_needLoadMore) {
      return;
    }

    if (info.visibleFraction == 0) {
      _visibilities.value.remove(rc);
    } else {
      _visibilities.value[rc] = info.visibleFraction;
    }

    final state = loadListBloc.state;
    if (state is LoadListLoadPageSuccess && state.items.isNotEmpty) {
      final entries = _visibilities.value.entries;
      if (entries.isNotEmpty) {
        final lastColumn = entries.length == 1 ? 0 : entries.last.key.column;

        if (lastColumn < LoadListConstants.numberCanLoadMore) {
          widget.scrollController.addListener(() {
            if (!widget.scrollController.hasClients) {
              return;
            }
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              if (!widget.scrollController.hasClients) {
                return;
              }

              if (widget.scrollController.position.userScrollDirection ==
                  ScrollDirection.reverse) {
                if (!_shouldBlockListenScroll.value) {
                  _shouldBlockListenScroll.value = true;
                  await _loadMore();
                }
              } else if (widget.scrollController.position.userScrollDirection ==
                  ScrollDirection.forward) {
                if (!_isRefreshing.value) {
                  _isRefreshing.value = true;
                }
              }
            });
          });
        } else {
          if (_isRefreshing.value) {
            return;
          }

          final item = _visibilities.value.entries
              .firstWhereOrNull((e) => e.key.column == lastColumn - 1);
          if (item == null) {
            return;
          }

          final visibleFraction = _visibilities.value[item.key];

          if (visibleFraction == null) {
            return;
          }

          if (visibleFraction > 0.35 && !_isPreloading.value) {
            _isPreloading.value = true;
            await _loadMore();
          }
        }
      }
    }
  }

  Future<void> _loadMore() async {
    final loadListBloc =
        BlocManager().blocFromKey<LoadListBloc<T>>(widget.blocKey);
    if (loadListBloc == null) {
      return;
    }

    final nextItems = await loadListBloc.loadMore(params: widget.params);
    if (nextItems == null || nextItems.isEmpty) {
      return;
    }

    BlocManager().event<LoadListBloc<T>>(
      widget.blocKey,
      LoadListNextPage<T>(
        nextItems: nextItems,
        params: widget.params,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return context.hasBloc<LoadListBloc<T>>()
        ? BlocConsumer<LoadListBloc<T>, LoadListState>(
            bloc: BlocManager().blocFromKey<LoadListBloc<T>>(widget.blocKey),
            listenWhen: (previous, current) =>
                current is LoadListStartInProgress ||
                current is LoadListLoadPageSuccess ||
                current is LoadListRemoveItemSuccess ||
                current is LoadListRunFailure,
            listener: (_, state) {
              if (state is LoadListStartInProgress) {
                if (_shouldBlockListenScroll.value) {
                  _shouldBlockListenScroll.value = false;
                }
              }
              if (state is LoadListLoadPageSuccess) {
                if (widget.onDataIsReady != null) {
                  widget.onDataIsReady!(
                      asT<List<T>>(state.items)!, _isRefreshing.value);
                }

                if (_isRefreshing.value) {
                  _isRefreshing.value = false;
                }

                if (_isPreloading.value) {
                  _isPreloading.value = false;
                }
              } else if (state is LoadListRemoveItemSuccess) {
                if (widget.onItemRemoved != null) {
                  widget.onItemRemoved!(asT<T>(state.removedItem)!);
                }
              } else if (state is LoadListRunFailure) {
                if (state.error is ServerErrorException) {
                  /// do something here.
                }
              }
            },
            buildWhen: (previous, current) {
              if (current is LoadListRemoveItemSuccess) {
                return false;
              }

              return true;
            },
            builder: (context, state) {
              if (state is LoadListInitial) {
                return widget.loadingWidget ??
                    const SliverToBoxAdapter(
                      child: Center(
                        child: DotsLoading(),
                      ),
                    );
              }

              if (state is LoadListStartInProgress) {
                return widget.loadingWidget ??
                    const SliverToBoxAdapter(
                      child: Center(
                        child: DotsLoading(),
                      ),
                    );
              }
              if (state is LoadListRunFailure) {
                return widget.errorWidget(state.error);
              }

              List<BaseEntity> items = [];
              if (state is LoadListLoadPageSuccess) {
                items = state.items;
              } else if (state is LoadListLoadNextPageInProgress) {
                items = state.items;
              }
              return items.isEmpty
                  ? widget.emptyWidget ??
                      const SliverToBoxAdapter(
                        child: SizedBox(),
                      )
                  : widget.listRender != null
                      ? SliverPadding(
                          padding: widget.padding,
                          sliver: widget.listRender!(asT<List<T>>(items)!),
                        )
                      : LoadSliverListView<T>(
                          items: items,
                          padding: widget.padding,
                          supportFlatGroup: widget.supportFlatGroup,
                          groupHeaderBuilder: widget.groupHeaderBuilder,
                          groupItemBuilder: widget.groupItemBuilder,
                          groupItemPlaceholderBuilder:
                              widget.groupItemPlaceholderBuilder,
                          itemBuilder: widget.itemBuilder,
                          itemPlaceholderBuilder: widget.itemPlaceholderBuilder,
                        );
            },
          )
        : const SliverToBoxAdapter(
            child: SizedBox(),
          );
  }
}
