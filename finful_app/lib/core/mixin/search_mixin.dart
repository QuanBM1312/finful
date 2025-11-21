import 'package:finful_app/core/extension/extension.dart';

import '../utils/utils.dart';
import '../entity/entity.dart';

typedef Predicate<T> = bool Function(T data, String searchStr);

mixin SearchMixin {
  List<T>? searchCompleted<T extends BaseEntity>(
      List<T>? dataSet, String val, Predicate<T> predicate) {
    val = val.trim();
    if (val.isNullOrEmpty) {
      return asT<List<T>>(dataSet);
    }

    if (dataSet != null) {
      return asT<List<T>>(
          dataSet.where((record) => predicate(record, val)).toList());
    }
    return null;
  }
}
