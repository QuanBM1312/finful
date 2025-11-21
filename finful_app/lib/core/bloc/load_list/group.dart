import '../../entity/entity.dart';

typedef MapFunction<T, S> = S Function(T source);
typedef CompareFunction<T> = int Function(T a, T b);

class Group<T extends Object> extends BaseEntity {
  final String groupBy;
  final String headerTitle;
  final List<T> list;
  final Map<String, dynamic>? extra;
  final bool isHidden;

  Group({
    required this.groupBy,
    required this.headerTitle,
    List<T>? initial,
    this.extra,
    this.isHidden = false,
  }) : list = initial ?? <T>[];

  void add(T item) {
    list.add(item);
  }

  void addAll(List<T> items) {
    list.addAll(items);
  }

  int get length => list.length;

  T itemAtIndex(int index) => list[index];

  void sort({
    required CompareFunction<T> compareFunction,
  }) {
    list.sort(compareFunction);
  }

  void insertItem(
    T item, {
    required int at,
  }) {
    list.insert(at, item);
  }

  A? extraObjectByKey<A extends Object>({
    required String key,
  }) {
    if (extra == null) {
      return null;
    }

    return extra![key];
  }

  Group<S> map<S extends Object>(MapFunction<T, S> mapFunction) {
    return Group(
      groupBy: groupBy,
      headerTitle: headerTitle,
      initial: list.map((e) => mapFunction(e)).toList(),
      extra: extra,
    );
  }

  Group<T> copyWith({
    bool? isHidden,
  }) {
    return Group<T>(
      groupBy: groupBy,
      headerTitle: headerTitle,
      initial: list,
      extra: extra,
      isHidden: isHidden ?? this.isHidden,
    );
  }

  @override
  List<Object> get props => [groupBy];

  @override
  Map<String, dynamic>? toJson() => null;
}
