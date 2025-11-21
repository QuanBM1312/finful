import 'package:finful_app/core/bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../core/bloc/load_list/group.dart';
import 'sliver_enum.dart';

class LoadSliverGroupHeader extends StatelessWidget {
  final List<Group<Object>> groups;
  final int index;
  final SliverGroupHeaderBuilder builder;

  LoadSliverGroupHeader({
    required this.groups,
    required this.index,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final isHidden = groups.isGroupHeaderHidden(index: index);
    if (isHidden) {
      return const SizedBox();
    }

    return builder(
      groups[index].headerTitle,
      groups,
      index,
      extraData: groups[index].extra,
    );
  }
}
