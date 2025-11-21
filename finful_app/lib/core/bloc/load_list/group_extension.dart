
import '../../entity/entity.dart';
import '../../utils/cast_type.dart';
import 'group.dart';

extension GroupList on List<Group> {
  static bool isListGroup(String type) => type.contains('List<Group<');

  int totalItem() {
    var total = 0;
    for (final group in this) {
      if (isListGroup(group.list.runtimeType.toString())) {
        total += GroupList(List<Group>.from(group.list)).totalItem();
      } else {
        total += group.length;
      }
    }

    return total;
  }

  int totalItemWithHeader() {
    var total = 0;
    for (final group in this) {
      total += group.length;
      total += 1;
    }

    return total;
  }

  int totalItemWithoutHeader() {
    var headerTotal = 0;
    if (totalItemWithHeader() == 0) {
      return headerTotal;
    }

    for (int i = 0; i < totalItemWithHeader(); i++) {
      if (isGroupHeader(index: i)) {
        headerTotal += 1;
      }
    }

    return totalItemWithHeader() - headerTotal;
  }

  bool isGroupHeader({
    required int index,
  }) {
    if (index == 0) {
      return true;
    }

    var headerIndex = 0;
    for (var i = 0; i < length; i++) {
      headerIndex += this[i].length + 1;
      if (headerIndex == index) {
        return true;
      } else if (headerIndex > index) {
        break;
      }
    }

    return false;
  }

  String groupHeaderTitle({
    required int index,
  }) {
    if (index == 0) {
      return first.headerTitle;
    }

    var headerIndex = 0;
    for (var i = 0; i < length; i++) {
      headerIndex += this[i].length + 1;
      if (headerIndex == index) {
        return this[i + 1].headerTitle;
      } else if (headerIndex > index) {
        break;
      }
    }

    return 'N/A';
  }

  int indexOfGroup({
    required int index,
  }) {
    if (index == 0) {
      return 0;
    }

    var headerIndex = 0;
    for (var i = 0; i < length; i++) {
      headerIndex += this[i].length + 1;
      if (headerIndex == index) {
        return i + 1;
      } else if (headerIndex > index) {
        break;
      }
    }

    return 0;
  }

  bool isGroupHeaderHidden({
    required int index,
  }) {
    if (index == 0) {
      return first.isHidden;
    }

    var headerIndex = 0;
    for (var i = 0; i < length; i++) {
      headerIndex += this[i].length + 1;
      if (headerIndex == index) {
        return this[i + 1].isHidden;
      } else if (headerIndex > index) {
        break;
      }
    }

    return false;
  }

  Map<String, dynamic> groupHeaderExtraData({
    required int index,
  }) {
    if (index == 0) {
      return first.extra ?? const {};
    }

    var headerIndex = 0;
    for (var i = 0; i < length; i++) {
      headerIndex += this[i].length + 1;
      if (headerIndex == index) {
        return this[i + 1].extra ?? const {};
      } else if (headerIndex > index) {
        break;
      }
    }

    return const {};
  }

  I? groupItem<I extends BaseEntity>({
    required int index,
  }) {
    if (index == 0) {
      return null;
    }

    var headerIndex = 0;
    for (var i = 0; i < length; i++) {
      final previousIndex = headerIndex;
      headerIndex += this[i].length + 1;
      if (headerIndex == index) {
        return null;
      } else if (headerIndex > index) {
        return asT<I>(this[i].itemAtIndex(index - previousIndex - 1));
      }
    }

    return null;
  }

  void _appendByDefault(List<Group> groups) {
    if (this[length - 1].groupBy == groups.first.groupBy) {
      this[length - 1].addAll(groups.first.list);
      addAll(groups.sublist(1, groups.length));
    } else {
      addAll(groups);
    }

    return;
  }

  void append(List<Group> groups) {
    if (groups.isEmpty) {
      return;
    }

    if (isEmpty) {
      addAll(groups);
      return;
    }

    _appendByDefault(groups);
  }
}
