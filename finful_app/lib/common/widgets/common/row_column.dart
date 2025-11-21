import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class RowColumn implements Comparable<RowColumn> {
  RowColumn(this.row, this.column);

  final int row;
  final int column;

  @override
  bool operator ==(dynamic other) {
    if (other is RowColumn) {
      return row == other.row && column == other.column;
    }
    return false;
  }

  @override
  int get hashCode => Object.hash(row, column);

  /// See [Comparable.compareTo].  Sorts [RowColumn] objects in row-major order.
  @override
  int compareTo(RowColumn other) {
    if (row < other.row) {
      return -1;
    } else if (row > other.row) {
      return 1;
    }

    if (column < other.column) {
      return -1;
    } else if (column > other.column) {
      return 1;
    }

    return 0;
  }

  @override
  String toString() {
    return '[$row, $column]';
  }
}

final visibilityListeners =
    <void Function(RowColumn rc, VisibilityInfo info)>[];

Key cellContentKey(int row, int col) => Key('Content-$row-$col');
Key cellKey(int row, int col) => Key('Cell-$row-$col');
