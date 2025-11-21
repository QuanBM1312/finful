import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core.dart';
import '../../exception/app_exception.dart';
import 'base_bloc.dart';
import 'broadcast.dart';

const Key noneDisposeBloc = Key('none_dispose_bloc');

class RetryEvent {
  final Key key;
  final Object event;
  final Key _retryOnKey;
  final Duration? delay;

  Key get retryOnKey => _retryOnKey;

  RetryEvent({
    required this.key,
    required this.event,
    this.delay,
    Key? retryOnKey,
  }) : _retryOnKey = retryOnKey ?? key;
}

class BlocManager {
  static final BlocManager _singleton = BlocManager._internal();

  factory BlocManager() => _singleton;

  late List<BaseBloc> _blocs;
  late List<Broadcast> _broadcasts;

  late List<RetryEvent> _retryEvents;
  late Map<Type, Object Function(Key key)> _blocConstructors;

  BlocManager._internal() {
    _blocs = [];
    _broadcasts = [];
    _retryEvents = [];
  }

  // ignore: use_setters_to_change_properties
  void initialize(Map<Type, Object Function(Key key)> constructors) {
    _blocConstructors = constructors;
  }

  T newBloc<T extends BaseBloc>(Key key) {
    final found = _blocs.indexWhere((b) => b.key == key);
    if (found >= 0) {
      return _blocs[found] as T;
    }

    try {
      final newInstance = _blocConstructors[T]!(key) as T;
      // ignore: unnecessary_type_check
      assert(newInstance is BaseBloc,
          'New instance of bloc should be inherited BaseBloc');
      logger().trace('New Bloc is created with key = $key');
      _blocs.add(newInstance);
      if (newInstance.subscribes() != null) {
        _broadcasts.addAll(newInstance.subscribes()!);
      }
      _retryEvent<T>(key);
      return newInstance;
    } catch (e) {
      logger().error('Error in new instance of bloc $key: $e');
    }
    throw BlocException('Something went wrong in creating bloc $T');
  }

  T newBlocWithConstructor<T extends BaseBloc>(Key key, Function constructor) {
    final found = _blocs.indexWhere((b) => b.key == key);
    if (found >= 0) {
      return _blocs[found] as T;
    }

    try {
      final T newInstance = constructor();
      logger().trace('New Bloc is created with key = $key');
      // ignore: unnecessary_type_check
      assert(newInstance is BaseBloc,
          'New instance of bloc should be inherited BaseBloc!');
      _blocs.add(newInstance);
      if (newInstance.subscribes() != null) {
        _broadcasts.addAll(newInstance.subscribes()!);
      }
      _retryEvent<T>(key);
      return newInstance;
    } catch (e) {
      logger().error('Error in new instance of bloc: $key: $e');
    }
    throw BlocException('Something went wrong in creating bloc with key $key');
  }

  T? blocFromKey<T extends BaseBloc>(Key key) {
    final found = _blocs.indexWhere((b) => b.key == key);
    if (found >= 0 && _blocs[found] is T) {
      logger().trace('_blocs[found]--- ${_blocs[found].toString()}');
      return _blocs[found] as T;
    } else {
      logger().error('blocFromKey---Cannot found bloc with key $key');
    }
    return null;
  }

  void _retryEvent<T extends BaseBloc>(Key key) {
    for (var i = 0; i < _retryEvents.length; i++) {
      final retry = _retryEvents[i];
      if (retry.key == key) {
        event<T>(retry.key, retry.event);
        _retryEvents.removeAt(i);
        break;
      }
    }
  }

  void event<T extends BaseBloc>(
    Key key,
    Object event, {
    bool retryLater = false,
    Key? retryOnKey,
    Duration? delay,
  }) {
    try {
      final found = _blocs.indexWhere((b) => b.key == key);
      final checkKindOfBloc = retryOnKey == null || key == retryOnKey;
      if (found >= 0 && (!checkKindOfBloc || _blocs[found] is T)) {
        if (delay != null) {
          Future.delayed(delay, () {
            _blocs[found].add(event);
          });
        } else {
          _blocs[found].add(event);
        }
      } else {
        logger().error('Cannot found bloc with key $key');
        if (retryLater) {
          _retryEvents.add(RetryEvent(
            key: key,
            event: event,
            delay: delay,
            retryOnKey: retryOnKey,
          ));
        }
      }
    } catch (e) {
      logger().error('Call event error: $e');
    }
  }

  void broadcast(String event, {Map<String, dynamic> params = const {}}) {
    for (final b in _broadcasts) {
      if (b.event == event) {
        b.onNext!(params);
      }
    }
  }

  void cleanUp({
    Key? parentKey,
  }) {
    final removedKeys = <Key>[];
    final closeKey = parentKey ?? noneDisposeBloc;
    _blocs.removeWhere((b) {
      if (b.closeWithBlocKey == closeKey) {
        removedKeys.add(b.key);
        return true;
      }
      return false;
    });

    _broadcasts.removeWhere((b) {
      return removedKeys.contains(b.blocKey);
    });
  }

  void unsubscribes(Key blocKey) {
    _broadcasts.removeWhere((b) {
      return b.blocKey == blocKey;
    });
  }

  void remove(Key blocKey) {
    _blocs.removeWhere((b) {
      return b.key == blocKey || b.closeWithBlocKey == blocKey;
    });
  }
}
