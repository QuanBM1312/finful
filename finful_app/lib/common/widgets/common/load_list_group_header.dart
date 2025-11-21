import 'package:finful_app/core/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../core/bloc/load_list/group.dart';
import 'normal_enum.dart';

class LoadListGroupHeader extends StatelessWidget {
  final List<Group<Object>> groups;
  final int index;
  final GroupHeaderBuilder builder;

  LoadListGroupHeader({
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
      groups.groupHeaderTitle(index: index),
      extraData: groups.groupHeaderExtraData(index: index),
    );
  }
}
