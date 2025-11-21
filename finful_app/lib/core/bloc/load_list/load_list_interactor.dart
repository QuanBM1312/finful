abstract class LoadListInteractor<T> {
  Future<List<T>?> loadItems({Map<String, dynamic>? params});

  Future<void> shouldRefreshItems({Map<String, dynamic>? params});

  bool shouldReloadData({Map<String, dynamic>? params});

  bool isDuplicateDataWhenLoadMore({Map<String, dynamic>? params});
}
